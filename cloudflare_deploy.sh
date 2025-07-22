#!/bin/sh

# Ensure an operational version of node is installed (using nvm as the version manager)
# From the ~/projects/dotfiles project, execute the following command
# make apps-install-nvm
# then find out what's running locally with the following command
# nvm ls
# List available installs wit the following command
# nvm ls-remote
# once identified an install candidate, install with the following command
# nvm install lts/jod
# Then make sure it's in use with the following command
# nvm use lts/jod

# ensure wrangler is installed locally with:
# npm install wrangler --save-dev
# ensure you're logged in with:
# npx wrangler login
# then execute this command (ensuring the project name matches one already created)
npm_config_yes=true npx wrangler pages deploy public --project-name="hugo-petermac-com" --commit-dirty=true
