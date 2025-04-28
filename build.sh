#!/bin/sh
# set an stop condition if anything goes wrong
# set -ex

# ensure the python env is present before starting
env_name="hugoenv"
env_path="./$env_name"

# Check if the environment directory exists
#if [ ! -d "$env_path" ]; then
#    echo "Warning: Python environment '$env_name' not found at $env_path."
#    echo "Please create the environment using 'python -m venv $env_path' or activate it if it exists in a different location."
#    exit 1
#else
#    echo "Python environment '$env_name' is present."
#fi
#
# nuke the build folder
rm -rf public

# nuke the pagefind index folder - this will be repopulated shotly
rm -rf static/pagefind && rm -rf static/_pagefind

hugo --printPathWarnings --printUnusedTemplates --logLevel debug --cleanDestinationDir --ignoreCache --minify

# The following command generates the pagefind index and places it in a subdir
# of the public folder. This is added to the cbuild command for deployments
npm_config_yes=true npx pagefind@latest --site ./public --output-subdir pagefind

# 2024-11-12 - Peter Mac
# Opting for the python build rather than the npm option
#python3 -m pagefind --site ./public  --output-subdir pagefind
