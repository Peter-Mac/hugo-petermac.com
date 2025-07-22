#!/bin/sh
# Exit immediately if a command exits with a non-zero status.
set -e

# Define environment name and path
env_name="hugoenv"
env_path="./$env_name"

# Clean old build and index files
rm -rf public
rm -rf static/pagefind static/_pagefind

# Run Hugo build
hugo --printPathWarnings --printUnusedTemplates --logLevel debug --cleanDestinationDir --ignoreCache --minify

# Run Pagefind index generation
if command -v npx >/dev/null 2>&1; then
    echo "Found npx – using Node-based Pagefind"
    npm_config_yes=true npx pagefind@latest --site ./public --output-subdir pagefind
elif command -v python3 >/dev/null 2>&1; then
    echo "npx not found – falling back to Python-based Pagefind"
    python3 -m pagefind --site ./public --output-subdir pagefind
else
    echo "Error: Neither 'npx' nor 'python3' was found in your PATH."
    echo "Please install Node.js/npm or Python 3 to proceed."
    exit 1
fi
