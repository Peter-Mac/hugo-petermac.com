#!/bin/sh
MY_IP=$(<myip.txt)
rm -rf public
rm -rf static/pagefind && rm -rf static/_pagefind

hugo server build --disableFastRender --port 3000 --bind=0.0.0.0 --baseURL=http://${MY_IP}:3000 --panicOnWarning --forceSyncStatic --gc

