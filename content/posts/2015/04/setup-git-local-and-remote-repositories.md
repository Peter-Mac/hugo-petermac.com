---
type: post
title: "Setup Git Local and Remote Repositories"
date: 2015-04-14
categories: 
  - "git"
---

If you are a remote worker or, like me get some work done on the train on the way to/from your office, you’ll appreciate the need for set up of a local and remote source code repository, This allows you to develop using your laptop/netbook, check in your changes locally and when you arrive at the mothership later, you can synchronise your local repository with the remote one ensuring all your changes are available for other developers. This article shows how to set up git for both a mothership type repository (let’s call it the remote repository) and a local version on your own laptop.

## Configuring Git project on the mothership.

### Prerequisites:

A Git server (the mothership) has been set up on a box called bluelight. This box is available to the network as git.petermac.com.

A git user has been created on the server called ‘git’. This user has access to the folder where the git repositories are stored.

### The Steps:

1.On your dev machine create your code project using whatever tools you need.

2.Initialise this working project under the git version control system

```
$ cd ~/projects/[myprojectname]
$ git init
peter@peter-desktop:~/Projects/rentmanager$ git init
Initialized empty Git repository in /home/peter/Projects/rentmanager/.git/
```

3.Add whatever work you’ve done to the repository

```
$ git add app/
$ git add docs/
```

4.Check the files you want added have been added

```
$ git status
# On branch master
# Initial commit
#
# Changes to be committed:
#   (use "git rm --cached ..." to unstage)
#
#    new file: app/rentmanager/,
#
```

5.Open a SSH session to bluelight – (the central git repository server)

```
$ sudo mkdir /usr/local/share/gitrepos/[myprojectname].git
```

6.Obviously substitute your real projectname and don’t forget to leave the .git extenstion

7.Initialise the repository under the new folder

```
$cd /usr/local/share/gitrepos/[myprojectname].git
[peter@bluelight myprojectname.git]$ sudo git init
Initialized empty Git repository in /usr/local/share/gitrepos/myprojectname.git/.git/
```

8.Change ownership of the repository to the system git user

```
$cd ..; sudo chown git.git -R /usr/local/share/gitrepos/myprojectname.git
```
