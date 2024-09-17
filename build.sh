#!/bin/sh
# set an stop condition if anything goes wrong
set -ex

# nuke the build folder
rm -rf public

# nuke the pagefind index folder - this will be repopulated shotly
rm -rf static/pagefind && rm -rf static/_pagefind

hugo --printPathWarnings --printUnusedTemplates --logLevel debug --cleanDestinationDir --ignoreCache --minify

# The following command generates the pagefind index and places it in a subdir
# of the public folder. This is added to the cbuild command for deployments
npm_config_yes=true npx pagefind@latest --site ./public --output-subdir pagefind
