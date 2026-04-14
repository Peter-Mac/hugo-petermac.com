#!/bin/sh
# Deploy the built site in ./public to Cloudflare Pages.
# Always rebuilds first to guarantee production URLs in the output,
# regardless of what state public/ was left in by a local preview.
# See README.md for first-time setup (Node.js, wrangler login, project creation).
set -e
./build.sh
npm_config_yes=true npx wrangler pages deploy public --project-name="hugo-petermac-com" --commit-dirty=true
