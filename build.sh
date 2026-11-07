#!/bin/bash
set -euo pipefail

SCRIPT_DIR="$(cd "$(dirname "$0")" && pwd)"
SRC_DIR="$SCRIPT_DIR/src"
TEMPLATE_DIR="$SRC_DIR/template"
CONTENT_DIR="$SRC_DIR/content"
PUBLIC_DIR="$SCRIPT_DIR/public"
# Absolute site URL used for link-preview (Open Graph) tags
SITE_URL="https://yonsei-reunion.github.io"

# Clean and prepare public directory
rm -rf "$PUBLIC_DIR"
mkdir -p "$PUBLIC_DIR"

# Copy style assets
cp -r "$TEMPLATE_DIR/style" "$PUBLIC_DIR/style"

# Copy non-markdown content files (images, etc.)
find "$CONTENT_DIR" -type f ! -name '*.md' -exec cp {} "$PUBLIC_DIR/" \; 2>/dev/null || true

# Convert each markdown file to HTML
for md_file in "$CONTENT_DIR"/*.md; do
    [ -f "$md_file" ] || continue

    filename=$(basename "$md_file" .md)

    # Extract H1 header as page title
    title=$(grep -m 1 '^# ' "$md_file" | sed 's/^# //')
    if [ -z "$title" ]; then
        title="$filename"
    fi

    # Home page is served at the site root and keeps its title without the site-name suffix
    if [ "$filename" = "index" ]; then
        page_path=""
        home_flag=(--metadata is-home=true)
    else
        page_path="${filename}.html"
        home_flag=()
    fi

    # Convert markdown to HTML using pandoc template
    # -smart: pandoc's smart quotes mistake a closing quote followed by a Korean particle
    # (e.g. '연세'를) for an apostrophe, so quotes are kept exactly as typed.
    pandoc --from markdown-smart --to html --wrap=none \
        --template="$TEMPLATE_DIR/page.html" \
        --metadata title="$title" \
        --metadata site-url="$SITE_URL" \
        --metadata page-path="$page_path" \
        "${home_flag[@]}" \
        "$md_file" > "$PUBLIC_DIR/${filename}.html"

    # Mark current page's nav link as active (only in nav, not in site-title)
    sed -i "/<nav/,/<\/nav>/s|href=\"${filename}.html\"|href=\"${filename}.html\" class=\"active\"|g" \
        "$PUBLIC_DIR/${filename}.html"

    echo "Built: ${filename}.html (title: $title)"
done

echo "Build complete. Output in: $PUBLIC_DIR"
