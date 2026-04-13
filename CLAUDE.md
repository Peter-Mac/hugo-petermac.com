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
- **Site generator:** Hugo, run from a local environment that's intended to be cross-platform transferrable.
- **Node / npm:** used for theme assets (Bootstrap) and the Cloudflare deploy tool (Wrangler) — see `package.json`.
- **Content indexing:** Pagefind, installed via Python (`requirements.txt` → `pagefind`). The Python venv lives at `hugoenv/`.
- **Hosting & deploy:** GitHub hosts the repo. A GitHub hook triggers a Cloudflare worker on every content push, which rebuilds the live site.
- **Theme:** custom theme at `themes/peter-mac-theme/` (kept in-repo, not vendored).

### Local scripts
> The scripts below work, but Peter has flagged that they (and `install.sh` in particular) **may need an overhaul**.
- `install.sh` — overarching script to set up a fresh dev environment from scratch.
- `python_setup.sh` — sets up the Python side of the dev environment (Pagefind).
- `build.sh` — wipes `public/` and the Pagefind index dirs, runs `hugo` (with `--minify`, `--cleanDestinationDir`, debug logging, etc.), then builds the Pagefind index. **Prefers `npx pagefind@latest`** and only falls back to `python3 -m pagefind` if `npx` isn't on PATH.
- `start.sh` — ensures `local_ip.txt` exists (calling `get_ip.sh` if not), wipes `public/` and the Pagefind index dirs, then runs `hugo server` on port 3000 bound to `0.0.0.0` with the LAN IP as `baseURL` (so the dev preview is reachable from other devices on the network).
- `testbuild.sh` — convenience wrapper: runs `build.sh` then `start.sh`. Note that `start.sh` re-cleans `public/` before serving, so the `build.sh` output is effectively discarded; for a normal local preview, `start.sh` alone is enough.
- `cloudflare_deploy.sh` — pushes content to trigger the Cloudflare rebuild.

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
Day-to-day work is driven by the bash scripts listed under [Tech stack → Local scripts](#local-scripts) (`install.sh`, `python_setup.sh`, `build.sh`, `testbuild.sh`, `cloudflare_deploy.sh`). There's nothing exotic beyond those.

The only other commands you'll see are standard Python venv invocations — e.g. `source hugoenv/bin/activate` to enter the environment Pagefind is installed in.

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

## Things to avoid
- **Verbosity.** Sharp, short sentences over wordy or convoluted ones. Cut filler. If a sentence can be split or shortened, do it.

## Notes for Claude
Help uplift the **corporate / consulting** side of Peter's presence on the site. Two threads to keep front of mind:

- **30 years of IT experience as a tech contractor**, not a single-employer career. That breadth spans media, education, retail, payroll, and more. Unlike a career professional anchored to one industry, Peter has cross-domain pattern recognition — and the site doesn't sing about that enough yet. Look for chances to surface those domain experiences in articles, About/CV copy, and case-style posts.
- **Fractional / part-time architect value for medium-sized businesses.** Many mid-size corps can't justify a full-time solution architect, but still need senior guidance on tech direction. Peter's services can produce the assets (architectures, decision records, roadmaps, vendor evaluations) that steer them. Frame consulting copy and relevant articles around this proposition — pragmatic, cost-aware, outcome-focused.

