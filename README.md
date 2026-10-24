# Tomlog

Personal bilingual blog about topics I enjoy, reflections and projects.
Posts are written in Spanish; the English versions are translated with AI.

Built with [Quarto](https://quarto.org) and published to GitHub Pages at
<https://tomasaam.github.io/tomlog>.

## Structure

```
blog/
├── _quarto.yml            # site config: navbar, theme, filters
├── index.qmd              # Spanish front page: intro + post list
├── posts/<slug>/index.qmd # Spanish posts (originals)
├── en/
│   ├── _metadata.yml      # sets lang: en for everything under en/
│   ├── index.qmd          # English front page
│   └── posts/<slug>/index.qmd  # English translations
├── _post-template.qmd     # copy this to start a new post
├── _posts.ejs             # layout of the post list on both front pages
├── _partials/
│   └── title-block.html   # post header: date, [category] and title
├── translation-link.lua   # adds the ES/EN link and the AI-translation note
├── custom.scss            # dark theme: colours, fonts and layout
├── images/                # profile picture and shared images
└── .github/workflows/
    └── publish.yml        # renders and deploys the site on every push to main
```

Files and folders starting with `_` are not rendered as pages.

## Design

A single dark theme built on Bootstrap's `darkly`, defined in `custom.scss`.
Text uses IBM Plex Sans; the logo, menu, dates and categories use JetBrains
Mono (both loaded from Google Fonts). All colours are variables at the top of
`custom.scss`. Categories `reflexiones`/`reflections` and
`proyectos`/`projects` get their own colour; any other category uses the
amber accent.

## Requirements

- [Quarto](https://quarto.org/docs/get-started/) 1.10+
- Git

## Run locally

```bash
quarto preview
```

Opens the site at a local URL and re-renders when you save a file.

## Write a new post

1. Copy `_post-template.qmd` to `posts/<slug>/index.qmd` (for example
   `posts/mi-primer-post/index.qmd`) and write it in Spanish.
2. Translate it with AI and save it as `en/posts/<slug-en>/index.qmd`.
   Translate `title`, `description` and `categories` too.
3. Link the two versions with the `translation:` field in each front matter:
   - Spanish post: `translation: ../../en/posts/<slug-en>/index.qmd`
   - English post: `translation: ../../../posts/<slug>/index.qmd`

   The English post automatically gets the note *"Originally written in
   Spanish and translated with AI."* If a post has no translation yet, remove
   the `translation:` line.
4. Images for a post go inside the post's folder, next to `index.qmd`.

Posts appear on the front page sorted by `date`, newest first.

## Publish

Every push to `main` publishes the site. The GitHub Actions workflow in
`.github/workflows/publish.yml` renders it with Quarto and deploys it to
GitHub Pages; the rendered site is never committed to the repository.
Progress and errors show up in the repository's **Actions** tab, where the
workflow can also be run by hand.

One-time setup: in the repository settings, set **Pages → Source** to
**GitHub Actions**.

## Custom domain (optional)

Buy a domain (for example from Cloudflare, Porkbun or NIC Chile), add a
`CNAME` file containing only the domain next to `_quarto.yml` (Quarto copies
it to the site automatically), update `site-url`, re-publish, and configure
the DNS records as described in the
[GitHub Pages docs](https://docs.github.com/pages/configuring-a-custom-domain-for-your-github-pages-site).
