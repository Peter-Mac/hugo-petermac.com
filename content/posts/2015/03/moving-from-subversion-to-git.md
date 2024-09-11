---
layout: post
title: "Moving from Subversion to Git"
date: 2015-03-18
categories: 
  - "git"
---

I have been using subversion for a number of years and it wasn’t until I had seen and sampled the simplicity and power of git that I decided once and for all to bite the bullet and migrate all my subversion repositories to git.

I’d done the same from cvs to subversion in the early 2000’s and still think the move worked out well with a bit of preparation.

An unfortunate side effect of subversion is that it takes a good bit of effort to set up and manage a new repository so I ended up with two somewhat monolithic repositories…

1. archives
2. projects

The ‘archives ‘ repository contained all old project work and the ‘projects’ one contained relevant or current project work.

The result of this was that each archive had a bundle of sub-folders, each containing a project in its’ own right. Although git can handle the concept of sub-modules it’s not the best way to structure your project. In fact, it was a pretty lazy to structure my subversion projects in the first place but convenience overcame system administrative chores at the time.

This article explains the following:

1. Converting a monolithic subversion repository to a git repository
2. Breaking out the new git repository into a set of discrete repositories.
3. General backup process and scripts to copy the new repositories across to a backup system.

First off, a couple of conventions I keep are…

My server stores a central set of repositories with the name of myproject.git My workstations work with their local version of repositories called myproject (no .git) My server exports it’s .git repositories to a backup server using the same .git naming convention. I have created a git.git user.group on my server to run all git processes. File ownership is given to this user so other users can’t fowl things up at least without thinking about it first.

Step 1 – Migrating to git from Subversion

I store all my git repositories on a server in the directory

```
/usr/local/share/gitrepos
```

All of my subversion repositories are stored in

```
/usr/local/share/svn
```

Even though each folder is accessible using standard paths and commands, I have to go through the subversion door using the same mechanism I would access it from a remote box, namely http://. Other people may use svn:// if that’s their way of working.

Migration is taken care of with a single command.

```
sudo git svn clone https://localhost/repository/projects --stdlayout --authors-file=/home/peter/authors.txt \
-t tags -b branches -T trunk /usr/local/share/gitrepos/projects.git/
```

An explanation of all the bits follow:

sudo – because I run everything as unprivileged user, sudo gives me the rights i need to create new files and folders.

git svn – this is the git subcommand that manages conversion of subversion repositories.

clone – make a copy of the repositories that I’m pointing at.

https://localhost/repository/projects – I access all my subversion repositories using secure http. This allows me to securely browse the content across the Internet and track things easily using Trac.

Depending on your setup, this parameter will contain the path to your svn repository,however you access it.

–stdlayout option tells git svn that my subversion repository is in the standard layout of trunk/branch/tags directories.

–authors file – this is a file I created by hand containing a list of all the people who committed project material in the past. It’d format is as follows:

peter= Peter Mac Giollafhearga simon= Simon Shagwell <simon\\'s email at his domain.com>

\-t tags -b branches -T trunk – these values are for completeness and I’m not sure they are necessary given the –stdlayout option, but if you’ve called your branches, tags and trunks anything different, this is how you find it.

Once the command has completed you should find a projects.git folder has been created and navigating into it you will see all your nasty subversion sub-folders which you should have set up as individual repositories in the first place…tut tut!

Step 2 – Breaking out Git into baby gits

The structure of the new git repository is something like this.

```
gitrepository/
  projects.git/
    project1/
    WorldDomination/
    SomeStuff/
    SomeotherStuff_V2/
    Demos/
    Downloads/
    .git/
```

The .git folder (you cans see it using ls -a) contains a list of all the git related material such as project history, revisions and tags. Check you can see your history by typing

```
git log
```

The next task is to break the contents of the rather large ‘project’ folder into a git repository per project. The tool for the job is a combination of the very useful git subtree command and a bit of custom shell scripting specific to this job.

The subtree functionality was written by Avery Pennarun and is hosted by the github site. You can download the git subtree command from the URL http://github.com/apenwarr/git-subtree. Installation instructions are on the same site so I won’t bore you with it here.

Once you have it installed you’re almost ready to roll. The following shell script has comments at the top to explain what it does. Save this to your favourite scripts folder and chmod it so it’s executable (chmod +x git\_breakout.sh).

Then cd into the folder you created earlier (in my case /usr/local/share/gitrepository/projects). Run the script and watch the output. Depending on the size of your projects it will take a bit of time to complete; mine took about 20 minutes.

```
#!/bin/sh
#git_breakout.sh
#This script should be run from within a git repository folder that
#contains many child folders.
#It will create a branch for every subfolder it finds and a new
#top level folder for each.
#It then initialises a git respoitory, copying into the relevant branch

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
  echo "This script must be run as root" 1>&2
  exit 1
fi

current_dir=`echo ${PWD##*/}`
git_user=git
git_group=git

for project in $( ls . )
do
  if [ -d $project ]; then
    project_lower=`echo $project.git | tr [A-Z] [a-z]`
    branchname=$project_lower."export"
    echo "performing subtree split..."
    git subtree split -P $project -b $branchname
    mkdir ../$project_lower
    cd ../$project_lower
    echo "initialising git"
    git init
    echo "fetching branch"
    git fetch ../$current_dir $branchname
    git checkout -b master FETCH_HEAD 2>&1
    cd ..
    echo "setting appropriate ownership"
    chown $git_user.$git_group -R $project_lower
    cd $current_dir
  fi
done
```

Once the script has completed, you should be able to see a new directory structure, something along the following lines.

```
gitrepository/
  projects.git/
  project1.git
  worlddomination.git/
  somestuff.git/
  someotherstuff_v2.git/
  demos.git/
  downloads.git/
```

Each folder is now its’ own git repository with it’s own internal version history, tags, branches etc. cd into one of the folders and do a git log just to confirm you still have history.

The original projects.git can be removed (after backing it up for safety’s sake) if you’re satisfied everything is in place. We’re now ready to proceed with the next stage of the game, namely backing up our new git repositories to a remote share.

Step 3 – Backing up Git

I use a 2TB removable disk as a central data server for sharing files throughout my network. My thinking is that should the place ever burn down and I have the opportunity, there’s only one box I need to grab before rushing out the door. Of course, I burn frequent snapshots of this box to DVD.

I have created a ‘backups’ share on the disk which I map to my physical server using NFS.

The entry in my /etc/fstab file is something like this.

```
192.168.0.20:/DataVolume/backups  /usr/local/share/backups  nfs defaults    0 0
```

This means I can read/write to my backups folder as if it was a local folder on a local disk.

The job at hand is to be able to backup my git repositories using a cron task scheduled to run when everything is nice and quiet. Below is the script I use to run my git backups.

```
#!/bin/bash
# git_backup.sh
# Backup git repositories to another folder

# Make sure only root can run our script
if [ "$(id -u)" != "0" ]; then
   echo "This script must be run as root" 1>&2
   exit 1
fi

git_command=/usr/bin/git
#Where they're going to be backed up
backup_dir=/usr/local/share/backups/git
#Location of current live repositories
repository_dir=/usr/local/share/gitrepos

cd $repository_dir
for project in $( ls . )
do
    if [ -d $project ]; then
    destination="$backup_dir/$project"

    if [ -d $destination ]; then
      cd $destination
      echo "pulling $project..."
      $git_command pull
      echo "done."
      cd $repository_dir
    else
      echo "mkdir $destination"
      mkdir $destination
      cd "$repository_dir/$project"
      echo "cloning $project..."
      $git_command clone -v -l --no-hardlinks . $destination
      cd ..
      echo "done."
    fi
    fi
done
```

Once this script is run, you ‘ll have a copy of all your repositories in the backup folder. The next time it’s run should only take a fraction of the time as it won’t have to reestablish the git repository again.

So there you have it, migrating a subversion repository to git is really simple, the fun starts when you try to play with the results. I hope this has been helpful to others faced with the same job. Any improvements please let me know.
