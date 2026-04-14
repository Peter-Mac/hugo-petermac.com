# CLAUDE.md

This file gives Claude Code project-specific guidance for working in this repo.

## Project overview
This repository contains the static files that support the petermac.com website — my professional persona presented to the world. The site uses the Hugo static site generator to render content. When changes are pushed to git, a git worker notifies Cloudflare's Wrangler process that content has been updated, which triggers a re-indexing of the site.

## Voice & audience
Peter Mac (me) should come across as **approachable and non-corporate**, with a preference for simple wording and plain phrases. Strip out corporate BS from any output.

The site serves two overlapping goals:
- **Technical relevance** — articles on what may look like niche topics (home automation, tech tooling, processes) demonstrate hands-on chops.
- **Solution architect credibility** — articles should also offer pragmatic, cost-effective guidance for fellow architects dealing with tech and people-management issues. The track record being shown is "experienced, pragmatic, cost-aware."

When drafting or editing content, default to that voice. Avoid jargon, hype, and filler.

## Tech stack
- **Site generator:** Hugo (installed via Homebrew on Mac; see README for other platforms). Currently running 0.160.1.
- **Node / npm:** used only for Wrangler (Cloudflare deploy tool) as a devDep, and for invoking Pagefind via `npx`. `npm install` pulls Wrangler and its transitive deps only.
- **Content indexing:** Pagefind, invoked via `npx pagefind@latest` at build time. No local install required — npx downloads to the per-user npm cache.
- **Hosting & deploy:** GitHub hosts the repo. A GitHub hook triggers a Cloudflare worker on every content push, which rebuilds the live site.
- **Theme:** custom theme at `themes/petermac-theme/` (kept in-repo, not vendored).
- **Platform:** macOS is Peter's working environment. Scripts are cross-platform-aware (`get_ip.sh` branches for Darwin and Linux); Linux paths are untested in practice.

### Local scripts
- `build.sh` — cleans `public/` + Pagefind index dirs, runs Hugo, builds the Pagefind index via `npx`.
- `start.sh` — ensures `local_ip.txt` exists (via `get_ip.sh`), then runs `hugo server` on port 3000 bound to `0.0.0.0` with the LAN IP as `baseURL` (so preview is reachable from other devices on the network).
- `testbuild.sh` — runs `build.sh` then `start.sh` for a full clean rebuild + live preview.
- `cloudflare_deploy.sh` — rebuilds via `build.sh` first (so production URLs are guaranteed in the output), then `npx wrangler pages deploy` for the `hugo-petermac-com` Cloudflare Pages project. See README for first-time setup.
- `get_ip.sh` — writes the active LAN IP to `local_ip.txt`. Branches for macOS (`ipconfig getifaddr`) and Linux (`ip route get` with `hostname -I` fallback).

## Repo layout
- `config/` — Hugo configuration files and settings.
- `content/` — site content, a mix of fixed pages and blog posts:
  - **Fixed pages** (one folder each): `consulting/`, `services/`, `about/`, `contact/`, `cv/`. Plus `search/` for the Pagefind UI and `_index.md` for the home page.
  - **Blog** lives under `content/posts/` as an expanding archive. Articles use a date-based path: `posts/<year>/<month>/<article-title>/`. Each article folder contains an `index.md` for the body, with any associated images/assets stored alongside it in the same folder.
- `themes/peter-mac-theme/` — custom theme; **all layouts and partials live here**, not in a top-level `layouts/`.
- `static/` — static assets copied as-is into the build.
- `public/` — Hugo build output.
- `resources/` — Hugo's processed asset cache.
- `*.sh` — local scripts (see Tech stack → Local scripts).

## Common commands
Day-to-day work runs through the bash scripts listed under [Tech stack → Local scripts](#local-scripts). Nothing exotic beyond those.

## Authoring conventions

### Sign-off before commit
All new or edited content must be **reviewed locally before being pushed to production**. The workflow is:
1. Run `./start.sh` to serve the site locally on `http://<local-ip>:3000` (or `./testbuild.sh` if a clean rebuild + Pagefind index is wanted first).
2. Preview in the browser and verify layout, formatting, images, and copy.
3. **Wait for explicit sign-off from Peter** before staging, committing, or pushing.

Do not commit content on Peter's behalf without that explicit review step. The Cloudflare deploy is triggered by the push, so an unreviewed commit is an unreviewed publish.

### Front matter / publish dates
- Default publish date is the current date.
- Peter may request a **back-dated (or otherwise non-current) publish date** to fill gaps in the publication timeline. Honour the requested date in the front matter rather than auto-stamping "now."

### Images
- Prefer images with **transparent backgrounds** where possible (PNG/SVG over flat-background JPGs).
- All images must be **accessible**: meaningful `alt` text on every image, descriptive captions where helpful, and consideration of screen reader behaviour. Decorative-only images should still have an empty `alt=""` so screen readers skip them cleanly.
- Store article images alongside the `index.md` in the same article folder.

### Tags
- **Reuse existing tags** where appropriate — check what's already in use before inventing new ones.
- New tags are fine when no existing tag fits; don't force a bad match just to avoid adding one.

### Changelog & TODO
Two project-meta files to keep current:
- **`CHANGELOG.md`** — append an entry under a dated section after any meaningful infrastructure or tooling change. Not for content/post additions (those live in git log).
- **`TODO.md`** — parked items and future work. When a TODO is actioned, move it into the CHANGELOG and remove it from here. When something gets flagged during a session but isn't actioned, add it here.

Keep entries short; match the tone of the existing files.

## Things to avoid
- **Verbosity.** Sharp, short sentences over wordy or convoluted ones. Cut filler. If a sentence can be split or shortened, do it.

## Notes for Claude
Help uplift the **corporate / consulting** side of Peter's presence on the site. Two threads to keep front of mind:

- **30 years of IT experience as a tech contractor**, not a single-employer career. That breadth spans media, education, retail, payroll, and more. Unlike a career professional anchored to one industry, Peter has cross-domain pattern recognition — and the site doesn't sing about that enough yet. Look for chances to surface those domain experiences in articles, About/CV copy, and case-style posts.
- **Fractional / part-time architect value for medium-sized businesses.** Many mid-size corps can't justify a full-time solution architect, but still need senior guidance on tech direction. Peter's services can produce the assets (architectures, decision records, roadmaps, vendor evaluations) that steer them. Frame consulting copy and relevant articles around this proposition — pragmatic, cost-aware, outcome-focused.

