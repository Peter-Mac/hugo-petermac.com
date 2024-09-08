---
type: post
title: "Smoothing out your workflow with git, github, RoR and Capistrano"
date: 2015-06-01
categories: 
  - "git"
  - "ruby-on-rails"
  - "software-development"
---

## Overview

Scripts can be found on github [https://github.com/Peter-Mac/git\_scripts](https://github.com/Peter-Mac/git_scripts)

I use git, github and the Ruby on Rails capistrano gem to help manage my workflow.

The scripts contained here are handy one liners that help speed up my workflow so I dont really have to think too hard when I'm doing something that's repetitive.

## My Workflow

I do all of my development on feature branches that are then merged back to the 'develop' branch.

The develop branch is used to collate work from multiple devs before pushing to the 'master' branch.

The master branch is then used to push code for release to either a staging server or a production server.

Capistrano is used to connect to each server and act as the deployment mechanism. This way I can deploy to remote servers, watch the script working its way through the full code and database migration process.

## The scripts

#### do\_feature\_merge.sh

This script allows you to

- merge your current feature branch back into the 'develop' branch
    
- provide a merge comment
    
- create a new feature branch, or stay with the develop branch as active
    

#### do\_release.sh

This script is used to push your local changes to the remote github repository and to provide a comment for the changes.

#### do\_deploy.sh

This is the script responsible for executing the capistrano deployment tasks. It takes an environment value as parameter (either 'staging' or 'production').

- It updates a VERSION file with the date and time of this release, checks the VERSION file into github,
    
- It starts the capistrano deployment tasks
    
- It checks out the develop branch ready for you to create your next feature branch
