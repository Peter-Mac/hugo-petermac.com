# TODO

Parked items and future work on petermac.com. Shareable with other tools as needed.

See [CHANGELOG.md](CHANGELOG.md) for what's already been done.

---

## Infrastructure / tooling

- **Wrangler v3 → v4 upgrade.** Clears the 3 remaining moderate dependabot alerts (esbuild + undici in Wrangler's transitive tree). Wrangler v4 reorganised commands around Cloudflare Pages / Workers Static Assets, so `cloudflare_deploy.sh` will likely need changes. Research + test against the existing Cloudflare project before committing.
- **Unused Hugo templates.** `./build.sh` logs ~22 "Template is unused" warnings against `themes/petermac-theme/`. Theme cleanup opportunity — remove dead layouts/partials after confirming nothing references them.

## Content / positioning

- **Uplift the consulting / services / about / cv pages** to surface two threads not yet singing loudly enough on the site:
  - 30 years of IT experience as a contractor across multiple industries (media, education, retail, payroll, etc.) — cross-domain pattern recognition, not a single-vertical career.
  - Fractional / part-time solution architect value for medium-sized businesses who can't justify a full-time architect but still need senior guidance and assets (architectures, decision records, roadmaps, vendor evaluations).
  - Tone: pragmatic, cost-aware, outcome-focused. Non-corporate.
