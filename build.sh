#!/bin/sh
set -e

# Clean old build and index files
rm -rf public
rm -rf static/pagefind static/_pagefind

# Hugo build
hugo --printPathWarnings --printUnusedTemplates --logLevel debug --cleanDestinationDir --ignoreCache --minify

# Pagefind index
npm_config_yes=true npx pagefind@latest --site ./public --output-subdir pagefind
