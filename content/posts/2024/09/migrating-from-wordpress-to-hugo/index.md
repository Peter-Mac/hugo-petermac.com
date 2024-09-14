---
layout: post
title: Migrating from Wordpress to Hugo
subtitle: Introducing Static Sites for an simpler life
date: 2024-09-12
tags:
  - wordpress
  - hugo
#image: '/img/home-automation-1.webp'
---


## Background

This is the first article published to my new revamped website using a new publishing tool [Hugo Static Site Generator](https://gohugo.io). My website has been running on Wordpress for pretty much as long as I can remember and the first time I ran into the concept of a static site was working for a university here in Melbourne. It didn't gel with me at the time because of the amount of non-static content that was in use. However, when I look at my own site running Wordpress, Maria DB on a Nginx web server, I realised I was over-cooking it.  

Automation is the key to a lot of what I do and I wanted to be able to create an [Ansible](https://opensource.com/article/21/3/ansible-sysadmin) enabled way to easily redeploy the petermac.com stite within my own hosting environment. This would typically involve generating the docker containers to host the wordpress and maria db images, another for Nginx, then populating the database with extracts from backup. 

## The penny drop moment
Wordpress is overkill for my simple requirements. Why do I have to log in to a CMS every time I want to create a post...or update one of the multitude of plugins which keep trying to upsell me to a paid version.  The act of logginig in is a [^1][PITA] which kind of puts me off posting anyway. So the search began for an alternate simpler mechanism. 

## Research
The concept of a static site generator (SSG) is fairly simple to understand. Take a picee of content in a fairly standard mark-up format, point a SSG tool at it and the resulting output should be something that can be displayed in a web browser without any need for back-end server process.  I did a market scan and ended up with two contenders. The first [Eleventy](https://www.11ty.dev/), the second Hugo. A breakdown of the pros and cons can be found [here](https://www.petermac.com/posts/2024/01/migrating-a-wordpress-site-to-a-static-site/).

## The Experience
I created a demo site with Eleventy, uploaded some content and was really happy with the working model and the simplicity of approach. The challenge was finding a theme that somewhat mirrored my existing site. Time not being on my side, I saw a Hugo theme that was as close to what I needed to work for me. The switch from Eleventy (which is aweesome in it's own way) to Hugo did take a bit of getting used to as they both have different underlying concepts and terminology.

I took the [hugo theme](https://github.com/zhaohuabing/hugo-theme-cleanwhite/tree/master) and butchered it to shape my needs, did some more searching and found some good best practice (or at least better than I know) helping sites such as that by [Bryce Wray](https://www.brycewray.com) and I'v now got a working site on Cloudflare Pages, with a couple of bash scripts able to push a new post in a matter of seconds with no stuffing around with logins, no plugins that need constant updating and most importantly no local infrastructure to support to keep my site running.

## Details
```(Bash)
hugo version 0.134.1+extended running on MacOS
npm/npx version 10.8.2
wrangler v 3.76.0 (cloudflare CLI)
```

## How it works
I've got a content folder with a combination of stand alone pages (about, services, contact etc), then a 'posts' folder under which I have year/month folders where post material goes.

Through lessons learned, I'd removed any UI based operations into a self-named themes folder. This contains the code I used from the original theme with modifications to suit my specific needs. 

It is possible to use a theme and keep it intact while replicating files in your own layouts folder but I found myself continually editing the wrong version of the file and wondering why things weren't working. In the end I decided to keep the themes/peter-mac-theme folder and focus on getting that part working to process outputs according to my needs.

For search, I've opted for [Pagefind](https://pagefind.app) which acts as a lightweight indexer of your content and the implementation is relatively straightforward.

For deployment, I'm pushing the content to cloudflare pages. Initially I used the CF web portal to create the pages site and set up a project, but then when I saw the ability to use a CLI tool which fits nicely into my workflow, I was all set. 

## The Downsides
I have three primary devies in my work life. My own laptop, my client provided laptop and my trysty iPad. Needless to say my client provided laptop doesnt come into the picture except for the added weight in my backpack. I will only carry my personal laptop if I need to do any serious tech work on a given day, otherwise it stays at the kitchen bench. Otherwise my iPad is generally with me when remote from home-office. So, how do I now propose to interact with the new Hugo site.

Options available are:
1. SSH from iPad using the Blink App to a remote dev server that's I use as a go-to for a lot of my tinkering and testing. Question here is what do I use to generate the content?
2.  

## Publish Process
1. Create a new folder under the Content/Year/Month structure.  I will usually name the folder with the name of the post I'm about to create. 
2. Create an index.md file within the folder.
3. Add any images to the folder and refer to them in the content with the necessary markdown.
4. When happy with the article wording run the build script (build.sh).
5. To view in local preview (before committing anything) run the serve.sh script. This executes a local tcp service on whatever port you need (I go with default 3000)
6. Once happy with the content, commit everything to git with a simple git commit and git push.
7. Finally run the cloudflare_deploy script (which uses the wrangler command) to push the latest updates to the live site.

### Codebase
You can find all the code for the site here:
[https://github.com/Peter-Mac/hugo-petermac.com](https://github.com/Peter-Mac/hugo-petermac.com)

### Scripts

**build.sh**
```bash
!/bin/sh
# set an stop condition if anything goes wrong
set -ex
rm -rf public
rm -rf static/pagefind && rm -rf static/_pagefind # kill prev PF index, if any
hugo --printPathWarnings --printUnusedTemplates --logLevel debug --cleanDestinationDir --ignoreCache
npm_config_yes=true npx pagefind@latest --site ./public --output-subdir pagefind
```

**serve.sh**
```bash
#!/bin/bash
MY_IP=$(<myip.txt)
npm_config_yes=true npx serve public -d -l tcp://${MY_IP}
```

**cloudflare_deploy.sh**
```bash
#!/bin/sh
# ensure wrangler is installed locally with:
# npm install wrangler --save-dev
# ensure you're logged in with:
# npx wrangler login
# then execute this command (ensuring the project name matches one already created)
npm_config_yes=true npx wrangler pages deploy public --project-name="hugo-petermac-com" --commit-dirty=true
```

## TODO
There's still a few tidy up jobs to do
[ ] convert the article_title.md files to index.md and put them in specific folders
[ ] comment code segments so I dont forget what works where

_FootNotes_
[^1] Pain In The Ass

