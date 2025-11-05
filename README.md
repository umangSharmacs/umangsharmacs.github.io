# Umang Sharma — Portfolio (GitHub Pages + Jekyll Minima)

This repository hosts my personal portfolio using GitHub Pages with the Jekyll "minima" theme. Content is mostly written in Markdown and converted to HTML by GitHub Pages.

## Structure
- `_config.yml`: Site config, theme, plugins, and navigation.
- `index.md`: Homepage content (Markdown). Original static page saved as `legacy_index.html`.
- `projects.md`: Projects index page, appears in the top navigation.
- `projects/`: Individual project pages (Markdown), each with front matter.
- `data/`, `icons/`: PDFs, images, and icons used across the site.

## Add a new project page
Create a Markdown file under `projects/` with YAML front matter:

```markdown
---
layout: page
title: My Project Title
permalink: /projects/my-project/
---

# My Project Title

Short description, methods, results, and links.

- Paper/PDF: [/data/Some_File.pdf](/data/Some_File.pdf)
- Source: https://github.com/...
```

Then link it from `projects.md` (or let Jekyll collections auto-list them later if we switch to `_projects/`).

## Navigation
Top navigation is controlled by `header_pages` in `_config.yml`:

```yaml
header_pages:
  - projects.md
```

Add any additional top-level pages by listing their filenames here.

## Local preview (optional)
GitHub Pages will auto-build the site on push. For local preview, install Ruby and run Jekyll locally (optional):

```bash
gem install bundler jekyll
bundle init
echo 'gem "github-pages", group: :jekyll_plugins' >> Gemfile
bundle install
bundle exec jekyll serve
```

Then open `http://127.0.0.1:4000`.

Note: Local builds may differ slightly from GitHub Pages. Ensure `.nojekyll` is not present so Pages can process the site.

## Deploy
Push to the default branch. In GitHub → Settings → Pages, ensure the source is the default branch. Pages will rebuild automatically within 1–3 minutes.

## Custom styles (optional)
To override Minima styles, create `assets/main.scss` that imports Minima and add custom CSS variables/selectors. Example skeleton:

```scss
---
---
@import "minima";

// Custom overrides here
```

## License / Attribution
Originally started from a static HTML portfolio; now migrated to Jekyll Minima. Content © Umang Sharma.