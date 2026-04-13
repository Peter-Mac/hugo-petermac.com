# Changelog

A running log of meaningful **infrastructure and tooling** changes to this project. Content/post additions are not tracked here — those live in git log.

Format loosely follows [Keep a Changelog](https://keepachangelog.com/). Dated sections rather than versions.

See [TODO.md](TODO.md) for parked / future work.

---

## 2026-04-14 — Infrastructure stabilisation

First substantial collaborative session with Claude Code. Baseline tidy-up across dependencies, build scripts, deploy path, and docs.

### Added
- `CLAUDE.md` — project context for future Claude Code sessions (voice, tech stack, layout, authoring conventions, sign-off workflow).
- `README.md` — "Installing Hugo" section pointing at Homebrew / Hugo's official install docs, plus a "First-time Cloudflare deploy setup" block.
- Cross-platform branching in `get_ip.sh` (macOS + Linux).

### Changed
- Standardised on `npx pagefind@latest` for search indexing. Python fallback dropped.
- `start.sh` no longer wipes `public/` before serving — `testbuild.sh` now behaves as intended (clean build + live preview).
- `cloudflare_deploy.sh` slimmed from 14 lines of prerequisite comments down to one real command.
- README: stale Python/Pagefind block replaced with accurate npx description; `serve.sh` → `start.sh`; `peter-mac-theme` → `petermac-theme`.

### Removed
- `install.sh` — pinned stale Hugo 0.134.2 and hadn't been the real install path in practice.
- `python_setup.sh`, `requirements.txt`, and the local `hugoenv/` venv (79 MB).
- ~50 transitive npm deps incorrectly hoisted to top-level `dependencies` in `package.json`.
- Unused `bootstrap` npm devDep — theme uses `static/css/bootstrap.min.css` directly.

### Fixed
- Hugo 0.158+ compatibility — `.Site.Author` → `.Site.Params.Author`, `languageCode` → `locale`, `outputs.yaml` unwrapped.
- Silenced `.Site.LanguageCode` deprecation warnings across four template usages (replaced with `.Site.Language.Locale`).

### Security
- Cleared the dependabot noise caused by misplaced transitive deps. 3 moderate vulns remain inside Wrangler's transitive tree (esbuild, undici) — parked pending Wrangler v4 upgrade.

