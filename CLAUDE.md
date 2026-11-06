# CLAUDE.md

This file provides guidance to Claude Code (claude.ai/code) when working with code in this repository.

## Project Overview

A static website for Yonsei University alumni anthology (연세대학교 졸업생 문집). Content is written in Markdown, converted to HTML via a shell-based build pipeline, and deployed to GitHub Pages (https://yonsei-reunion.github.io).

## Build & Deploy

- **Build**: `./build.sh` — converts `src/content/*.md` to `public/*.html` using pandoc. Requires `pandoc` installed.
- **Deploy**: pushing to `main` triggers `.github/workflows/deploy.yml`, which runs `./build.sh` and deploys `public/` to GitHub Pages. The GitHub repo is `yonsei-reunion/yonsei-reunion.github.io`.

## Architecture

The build pipeline (`build.sh`) does the following for each `.md` file in `src/content/`:
1. Extracts the first `# heading` as the page title
2. Converts Markdown to HTML with `pandoc --template` using `src/template/page.html` and the extracted title
3. Adds `class="active"` to the nav link matching the current page
4. Copies non-Markdown assets (images, etc.) from `src/content/` and `src/template/style/` into `public/`

Key directories:
- `src/content/` — Markdown source files (Korean language content)
- `src/template/` — `page.html` (pandoc template with `$title$`/`$body$` placeholders) and `style/` assets (CSS, images, SVG)
- `public/` — generated output (gitignored, rebuilt from scratch each build)

## Content Conventions

- All content is in Korean
- Navigation links in `page.html` must be updated manually when adding new pages
- Internal links in Markdown use `.html` extensions (e.g., `essay-guide.html`)
