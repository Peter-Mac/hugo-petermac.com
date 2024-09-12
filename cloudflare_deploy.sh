#!/bin/sh
# ensure wrangler is installed locally with:
# npm install wrangler --save-dev
# ensure you're logged in with:
# npx wrangler login
# then execute this command (ensuring the project name matches one already created)
npm_config_yes=true npx wrangler pages deploy public --project-name="hugo-petermac-com" --commit-dirty=true
