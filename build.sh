#!/usr/bin/env bash
# Build all decks under decks/* into a unified dist/ with a landing page.
set -euo pipefail

# Vercel's bundled pnpm crashes on Node 22 ("Value of 'this' must be of type
# URLSearchParams"). Pin to a known-good version via npx so it works on both
# local machines (uses the project's pnpm if available) and Vercel.
if [ "${VERCEL:-}" = "1" ]; then
  PNPM="npx --yes pnpm@10.16.0"
else
  PNPM="pnpm"
fi

ROOT="$(cd "$(dirname "$0")" && pwd)"
DIST="$ROOT/dist"
DECKS_DIR="$ROOT/decks"

rm -rf "$DIST"
mkdir -p "$DIST"

# Collect (slug, title) pairs as we build, for the landing page and decks.json.
LANDING_ITEMS=""
DECKS_JSON_ITEMS=""

shopt -s nullglob
for deck_path in "$DECKS_DIR"/*/; do
  slug="$(basename "$deck_path")"
  echo "── building $slug"

  pushd "$deck_path" > /dev/null

  if [ ! -d node_modules ]; then
    $PNPM install
  fi

  $PNPM build --base "/$slug/"

  if [ ! -f dist/index.html ]; then
    echo "ERROR: $slug build did not produce dist/index.html" >&2
    exit 1
  fi

  rm -rf "$DIST/$slug"
  mkdir -p "$DIST/$slug"
  cp -R dist/. "$DIST/$slug/"

  # Inject Vercel Web Analytics script into every built HTML page.
  # The script is auto-served at /_vercel/insights/script.js on Vercel deployments
  # with Analytics enabled; locally it 404s harmlessly. Doing this here avoids
  # adding @vercel/analytics as a per-deck dependency.
  while IFS= read -r html_file; do
    sed -i.bak 's|</head>|<script defer src="/_vercel/insights/script.js"></script></head>|' "$html_file"
    rm -f "$html_file.bak"
  done < <(find "$DIST/$slug" -type f -name "*.html")

  # Extract title from slides.md frontmatter (first `title:` line in the YAML block).
  title=$(awk '
    /^---$/ { if (!in_fm) { in_fm=1; next } else { exit } }
    in_fm && /^title:/ { sub(/^title:[[:space:]]*/, ""); gsub(/^"|"$/, ""); print; exit }
  ' slides.md)
  title="${title:-$slug}"

  LANDING_ITEMS+="    <li><a href=\"/$slug/\"><span class=\"t\">$title</span><span class=\"s\">/$slug/</span></a></li>"$'\n'

  # Escape title for JSON (backslashes and double-quotes; titles in slidev frontmatter
  # rarely contain control chars, so this is sufficient).
  json_title=$(printf '%s' "$title" | sed -e 's/\\/\\\\/g' -e 's/"/\\"/g')
  if [ -n "$DECKS_JSON_ITEMS" ]; then
    DECKS_JSON_ITEMS+=","$'\n'
  fi
  DECKS_JSON_ITEMS+="  { \"slug\": \"$slug\", \"title\": \"$json_title\" }"

  popd > /dev/null
done

if [ -z "$LANDING_ITEMS" ]; then
  echo "ERROR: no decks built" >&2
  exit 1
fi

# Write decks.json — canonical deck index consumed by aliirani.com/talks.
cat > "$DIST/decks.json" <<JSON
[
$DECKS_JSON_ITEMS
]
JSON

cat > "$DIST/index.html" <<HTML
<!doctype html>
<html lang="en">
<head>
<meta charset="utf-8">
<meta name="viewport" content="width=device-width,initial-scale=1">
<title>Talks · Ali Irani</title>
<script defer src="/_vercel/insights/script.js"></script>
<style>
  :root { color-scheme: light; }
  * { box-sizing: border-box; }
  html, body { margin: 0; padding: 0; }
  body {
    font-family: Inter, -apple-system, BlinkMacSystemFont, "Segoe UI", sans-serif;
    color: #111827;
    background: #fafaf9;
    line-height: 1.5;
    min-height: 100vh;
    display: flex;
    align-items: center;
    justify-content: center;
    padding: 2rem;
  }
  main { max-width: 640px; width: 100%; }
  .rule {
    width: 40px; height: 3px; background: #0d9488; border-radius: 2px;
    margin-bottom: 1.5rem;
  }
  h1 { font-size: 2.25rem; font-weight: 700; margin: 0 0 0.5rem; letter-spacing: -0.01em; }
  .dim { color: #6b7280; }
  ul { list-style: none; padding: 0; margin: 2.5rem 0 0; }
  li { margin: 0; }
  li a {
    display: flex; justify-content: space-between; align-items: baseline;
    padding: 1rem 0; border-bottom: 1px solid #e5e7eb;
    text-decoration: none; color: #111827;
    transition: color 0.15s;
  }
  li:first-child a { border-top: 1px solid #e5e7eb; }
  li a:hover { color: #0d9488; }
  .t { font-weight: 600; font-size: 1.1rem; }
  .s { font-family: "Fira Code", monospace; font-size: 0.85rem; color: #9ca3af; }
  footer { margin-top: 3rem; font-size: 0.85rem; color: #9ca3af; }
  footer a { color: #0d9488; text-decoration: none; }
</style>
</head>
<body>
<main>
  <div class="rule"></div>
  <h1>Talks</h1>
  <p class="dim">Selected talks by Ali Irani.</p>
  <ul>
$LANDING_ITEMS
  </ul>
  <footer><a href="https://aliirani.com">aliirani.com</a></footer>
</main>
</body>
</html>
HTML

echo "── done. open $DIST/index.html"
