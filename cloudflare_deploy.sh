#!/bin/sh
# Deploy the built site in ./public to Cloudflare Pages.
# See README.md for first-time setup (Node.js, wrangler login, project creation).
npm_config_yes=true npx wrangler pages deploy public --project-name="hugo-petermac-com" --commit-dirty=true
