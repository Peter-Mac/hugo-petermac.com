---
layout: post
title: "Configure git to use a remote repository"
date: 2015-02-10
categories: 
  - "git"
---

1. Return back to the local machine and add reference to the new ‘remote’ repository from the base directory of the project.
    
    $ git remote add remote ssh://git at git.petermac.com/usr/local/share/gitrepos/myprojectname\].git
    
2. Here the ‘git remote add’ part says add a reference to a remote repository. The second ‘remote’ is the friendly name I want to use when referring to the repository on the git server
    
3. Now commit the local files to the local repository – Note: Step 3 was only an add, not a commit. When you commit you’ll be prompted (or you can enter it as a -m option) to enter a message to be used as a comment.
    
    peter@peter-desktop:~/Projects/myprojectname$ git commit  
    Created initial commit 633fd3c: initial checkin of project core and data migration files
    
4. It’s time to test the new remote repository by ‘pushing your local repository info up to it. This is done using git push
    
    peter@peter-desktop:~/Projects/myprojectname$ git push –dry-run –all --repo=remote  
    fatal: 'origin': unable to chdir or not a git archive fatal: The remote end hung up unexpectedly
    

Didn’t quite go to plan – so let’s see what’s wrong

```
peter@peter-desktop:~/Projects/myprojectname$ git remote show remote
The authenticity of host 'git.petermac.com (192.168.0.15)' can't be established.
RSA key fingerprint is 5a:ce:6e:a4:78:d5:01:50:36:2b:bb:12:67:e1:be:53.
Are you sure you want to continue connecting (yes/no)? yes
Warning: Permanently added 'git.petermac.com' (RSA) to the list of known hosts.
git at git.petermac.com's password:
* remote remote
URL: ssh://git at git.petermac.com/usr/local/share/gitrepos/myprojectname.git
```

let’s try again

```
$ git push –dry-run –all –repo=remote
git at git.petermac.com's password:
To ssh://git at git.petermac.com/usr/local/share/gitrepos/myprojectname.git
[new branch] master > master
```

looks like it will work so remove the dry-run parameter

```
$ git push –all –repo=remote
```

That’s all folks!
