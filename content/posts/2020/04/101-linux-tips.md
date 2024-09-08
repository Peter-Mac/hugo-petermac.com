---
type: post
title: "102 Linux Tips"
date: 2020-04-04
tags: 
  - command-line
  - linux
  - linux-beginner
  - linux-tips
  - tips
---

Over 100 tips for beginner to intermediate Linux command line users. I'll add to the list as and when I think of it. The tips start simple but get a bit more complex as things go along.

\_001 Learning commands 101 use the 'man'  
To find out what commands and options are available for you

```
$ man
```

\_002 cd  
The cd command enables you to move between directories on your system. Like the following, for example:

```
$ cd /home/user/
```

\_003 cp  
The copy command, or cp, can be used to copy files from one location to another. To do this use the command below:

```
$ cp file /home/user/Desktop/file
```

\_004 mv

Similar to copy, mv instead moves the file to the new location, deleting the original file:

```
$ mv file /home/user/Desktop/file
```

\_005 rm

The rm command is for removing or deleting files and directories. You can use it like:

```
$ rm file
```

\_006 mkdir  
You can create directories with the mkdir command using something like:

```
$ mkdir folder
```

\_007 nano

Nano is one of the programs that enables you to edit text in files – it’s vital for working and editing in the command line. You use it like so:

```
$ nano file
```

\_008 Tab

The Tab key lets you auto-complete commands and file names. Double-tapping will list all objects with a similar name. Auto- completion works for unambiguous file and command names. For example, ‘fir’ gives you ‘firefox’ as no other commands begin with ‘fir’. If you get multiple hits, keep typing to narrow the selection, then hit Tab again

\_009 Up

Up on the keyboard has the very simple task of enabling you to pull up the last command that was entered, to run it again or edit it.

\_010 Copy text

If you’re in the terminal, you may want to copy text output to use somewhere. To do this, you can use:

Ctrl+Alt+C

\_011 Paste text

If you’ve found a command online or need to paste some text into nano, you can enter any text on the clipboard with:

Ctrl+Alt+V

\_012 Open terminal

This trick works in a lot of desktop environments: a shortcut for opening the terminal can be done with:

Ctrl+Alt+T

\_013 sudo

This lets you do commands as the super user. The super user in this case is root and you just need to add sudo to the start of any command.

\_014 Access root  
The super user, or root, can also be accessed by logging in as it from the terminal by typing su. You can enter the root user password and then run every command as root without having to use sudo at all.

\_015 Stop processes

If you have run a command and either it’s paused, taking too long to load, or it’s done its job and you don’t need to see the rest of it, you can stop it forcefully by using either Ctrl+C or Ctrl+Z. Remember, only do this if the process is not writing any data, as it is not safe in this instance and you could find yourself in trouble.

\_016 Access root without password

If your regular user is in the sudoers list (ie so that they can use sudo in general to run things as root), you can access the su account by using sudo su. This uses your normal user password to access root terminal functions.

To add a regular user to the sudoers list, you would need to first log in as the super user by using su. Then, you would simply run adduser username sudo (replacing ‘username’). Be careful who you add to the sudoers list, though!

\_017 Search for hidden files and directories

The ls command can be used in more than just the basic way of listing all the files in a folder. To begin with, you can use it to list all the hidden items along with the normal items by using:

```
$ ls -a
```

\_018 Home directory shortcut

The home directory is located at /home/user/ in the absolute filesystem, but you can use the tilde (~) to signify the home directory when moving between directories or copying, or doing mostly anything else – like with the following, for example:

```
$ cd ~
```

\_019 Link commands together

If you want to do a series of commands one after the other, like updating and then upgrading software in Debian, for example, you can use && to have a command run right after the one before. For example:

```
$ sudo apt-get update && sudo apt-get install libreoffice
```

\_020 Long terminal input

Sometimes when using a list or anything else with a long terminal output, you might not be able to read it well. To make it easier to understand, you can send the output to another command, less, through the | pipe. It works like so:

```
$ ls | less
```

\_021 Readable storage size

One of the details that ls -l displays is the size of the files that are located on the hard drive. This is done in bytes though, which is not always that useful. You can have it parse this file to become more legible simply by changing the -l to -lh, where the long-listing format option (-l) is tweaked with the human-readable option (-h).

\_022 Move to previous directory

If you want to move back to the directory that you were working on before, there is a cd command to do that easily. This one does not move up the filesystem, but rather back to the last folder that you were in:

```
$ cd -
```

\_023 Move up directory

The cd command can also be used to move up in the filesystem. Do this with two full stops, like so:

```
$ cd ..
```

\_024 General wildcards

The asterisk (\*) can be used as a wildcard in the terminal to stand for anything. A typical use case is copying or removing specific types of files. For example, if you want to remove all PNG files from a directory, you cd to it and type:

```
$ rm *.png
```

\_025 More with the pipe

The pipe (|) can be used to feed all outputs into the next command, enabling you to call a piece of data or string from one command and put it straight into the next command. This works with grep and other core Linux tools.

\_026 Delete directories

Using rm on a directory with objects within it won’t work, as it needs to also delete the files inside. You can modify the rm command to delete everything within a directory recursively using:

```
$ rm -r directory
```

\_027 Shutdown command

You can shut down the system from the terminal using the shutdown command, the halt option (-h), which stops all running programs at the same time, and specifying a time of now so it turns off immediately rather than in 60 seconds:

```
$ sudo shutdown -h now
```

\_028 Display all file information

As well as merely listing the files, we can use ls to list all of the information relating to each file, such as last date modified, permissions and more. Do this by using:

```
$ ls -l
```

\_029 Reboot from command line

Back in the day, rebooting required a slightly more complex shutdown command: shutdown -r. In recent years it’s been replaced with a very simple:

```
$ sudo reboot
```

\_030 Timed shutdown

The timing function of the shutdown command can be very useful if you need to wait for a program or cron job to finish before the shutdown occurs. You can use the time to do a normal halt/shutdown, or even with -r for a reboot after ten minutes, with something like:

```
$ sudo shutdown -h +10
```

\_031 Log out

Logging out from the x session is generally advisable from the desktop environment, but if you need to log back out to the login manager, you can do this by restarting the display manager. In the case of many Linux distros, you use the command below:

```
$ sudo service lightdm restart
```

\_032 Debian: update repositories

Debian-based (and Ubuntu-based) distros use apt-get as the command line package manager. One of the quirks of apt-get as a package manager is that before upgrading or installing software, it does not check to see if there’s a newer version in the repositories. Before doing any installation in Debian, use:

```
$ sudo apt-get update
```

\_033 Debian: install software

Unlike a graphical package manager or software centre, you can’t quite search for the kind of packages you want to install, so you need to know the package name before installing. Once you do though, try:

```
$ sudo apt-get install package
```

\_034 Debian: update software

You can upgrade the software in Debian from the terminal by first performing the repository update command in Tip 32, followed by the upgrade command below:

```
$ sudo apt-get upgrade
```

\_035 Debian: uninstall software

As part of package management, apt-get enables you to uninstall software as well. This is simply done by replacing install with remove in the same command that you would use to install said package (Tip 33). You can also use purge instead of remove if you want to delete any config files along with it.

\_036 Debian: upgrade distro

Debian systems can often update to a ‘newer version’, especially when it’s rolling or if there’s a new Ubuntu. Sometimes the prompt won’t show up, so you can do it in the terminal with:

```
$ sudo apt-get dist-upgrade
```

\_037 Debian: multiple packages

A very simple thing you can do while installing on all platforms is list multiple packages to install at once with the normal installation command. So in Debian it would be:

```
$ sudo apt-get install package1 package2 package3
```

\_038 Debian: dependencies

Compiling differs between software and they’ll each have a guide on how to go about it. One problem you might face is that it will stop until you can find and install the right dependency. You can get around this by installing auto-apt and then using it during configuration with:

```
$ sudo auto-apt run ./configure
```

\_039 Debian: force install

Sometimes when installing software, apt-get will refuse to install if specific requirements aren’t met (usually in terms of other packages needing to be installed for the software to work properly). You can force the package to install even without the dependencies using:

```
$ sudo apt-get download package $ sudo dpkg -i package
```

\_040 Debian: install binary

In Tip 39, we used dpkg -i to install the binary installer package that we downloaded from the repositories. This same command can be used to install any downloaded binary, either from the repos or from a website.

```
_041 Debian: manual force install package
```

If the advice in Tip 39 is still not working, you can force install with dpkg. To do this you just need to add the option --force-all to the installation command to ignore any problems, like so:

```
$ sudo dpkg --force-all -i package
```

\_042 Red Hat: update software

Unlike apt-get, the yum package manager for Red Hat/Fedora-based distros does not need you to specifically update the repositories. You can merely update all the software using:

```
$ sudo yum update
```

\_043 Red Hat: install software

Installing with yum is very simple, as long as you know the package name. Yum does have some search facilities though, if you really need to look it up, but once you know what package you want, use the following command:

```
$ sudo yum install package
```

\_044 Red Hat: uninstall software

Yum can also be used to uninstall any package you have on your system, whether you installed it directly from yum or not. As long as you know the package name you can uninstall with:

```
$ sudo yum remove package
```

\_045 Red Hat: force install

The force install function on Red Hat and Fedora-based Linux distros requires that you have a package downloaded and ready to install. You can download things with yum and then force the install with:

```
$ sudo yum install --downloadonly --downloaddir=[directory] package
$ sudo rpm -ivh --force package
```

\_046 Red Hat: manual install

RPM is one of the package installers on Red Hat distros and can be used to install downloaded packages. You can either do something like in Tip 45 and download the package from the repos, or download it from the Internet and install with:

```
$ sudo rpm -i package
```

\_047 Red Hat: force manual installation

As in Tip 45, you can use RPM to force install packages if there’s a dependency issue or something else wrong with any other packages that you have downloaded. The same command should be used as in Tip 45, with the -ivh and --force options present.

\_048 Fedora: distro upgrade

Yum has its own distribution upgrade command, but only in Fedora and they prefer you not to use it unless you have to. Nonetheless, you can use the fedora-upgrade package in yum with:

```
$ sudo yum install fedora-upgrade
```

\_049 Search a file for a term in files

The basic use of grep is to search through a file for a specific term. It will print out every line with that term in, so it’s best to use it with system files with readable content in. Use it with:

```
$ grep hello file
```

\_050 Check for lines

Looking for specific lines in a file is all well and good, but when you then start to hunt them down and you realise the file is hundreds of lines long, you can save yourself a lot of time by getting grep to also print out the line number. You can do this with the -n option:

```
$ grep -n hello file
```

\_051 Regular expressions

If you need to make a more advanced search with grep, you can use regular expressions. You can replace the search term with ^hello to look for lines that start with hello, or hello$ for lines ending in hello.

```
$ grep -n ^hello file
$ grep -n hello$ file
```

\_052 Wildcards and grep

When searching for lines, you can use a wildcard if you need to look for similar terms. This is done by using a full stop in the search string – each full stop represents one wildcard character. Searching for h...o will return any five-letter string with h at the start of the string and o at the end. Use it like so:

```
$ grep ‘\<h...o>’ file</h...o>
```

\_053 More wildcards

You’ll also be using wildcards to find something ending or beginning with a specific string but with no fixed length. You can do this in grep by using an asterisk (\*) along with the dot.

In the above example, we would have used h.\*o instead.

\_054 Stop a system service

A system service is the kind of background software that launches at start up. These are controlled by the system management daemons like init or systemd, and can be controlled from the terminal with the service command. First, you can stop a service using:

```
$ sudo service name stop
```

\_055 Start a service

You can start system services that have been stopped by using the same service command with a different operator. As long as you know the service name, start it using:

```
$ sudo service name start
```

\_056 Restart a system service

This one is popular with setting up web servers that use Apache, for which restarts may be needed, along with other services that you customise along the way. Instead of running both the stop and start commands sequentially, you can instead restart services by using:

```
$ sudo service name restart
```

\_057 Know the ID

The ID that you can get for the software with top can be used to manipulate it, but a common reason to know the ID is so that you can end the process if it’s having trouble stopping itself or using too many resources. With the ID in hand, you can kill it with:

```
$ ps auxw | grep apache
www-data 11671 0.1 3.1 675756 127036 ? S 06:25 0:15 /usr/sbin/apache2 -k start
$ kill 11671
```

\_058 Kill multiple IDs

Sometimes a process can be split up over multiple IDs (this is usually the case with a web browser – Google Chrome is a notorious example), and you need to kill multiple processes at once. You can either try and quickly kill all the IDs, or use the common name for the process and kill it with:

```
$ killall -v process
```

\_060 List USB devices  
You may need to know which USB and USB- related devices are connected to a system, or find our their proper designation. You’ll need to install it first, but once you have, you can use lsusb in the terminal to list all of the available devices.

```
$ lsusb
```

\_061 List hard drives and partitions

Whether you need to check the designation of certain drives for working on them, or you just need to get a general understanding of the system’s layout, you can use fdisk to list all the hard drives. Do this in the terminal with:

```
$ sudo fdisk -l
```

\_062 Check running software

Sometimes you’ll want to check what’s running on your system and from the terminal this can be done simply with top. It lists all the relevant information you’ll need on your currently running software, such as CPU and memory usage, along with the ID so you can control it.

```
$ top
```

\_063 Unpack a ZIP file

If you’ve downloaded a ZIP file and you did it from the terminal or you’re working from it, you can to unpack it using the unzip command. Use it like so:

```
$ unzip file.zip
```

\_064 Unpack a TAR file

Sometimes Linux will have a compressed file that is archived as a .tar.gz, or a tarball. You can use the terminal to unpack these or similar TAR files using the tar command, although you need the right options. For the common .gz, it’s:

```
$ tar -zxvf file.tar.gz
```

\_065 Copy and write disks

Coming from UNIX is a powerful image tool called dd, which I’ve been using a lot recently for writing Raspberry Pi SD cards. Use it to create images from discs and hard drives, and for writing them back. The if is the input file or drive and the of is the output file of the same. It works like so:

```
$ dd if=image.img of=/dev/sda bs=1M
```

\_066 Create an empty file

Sometimes when coding or installing new software, you need a file to write to. You could create it manually with nano and then save it, but the terminal has a command similar to mkdir that enables you to create an empty file – this is touch:

```
$ touch file
```

\_067 Print into the terminal

The terminal uses echo to print details from files into the terminal, much like the C language. If you’re writing a Bash script and want to see the output of the current section, you can use echo to print out the relevant info straight into the terminal output.

\_068 Check an MD5 hash

When downloading certain files it can help a lot to check to make sure it’s downloaded properly. A lot of sites will offer the ability to check the integrity of the downloaded file by comparing a hash sum based on it. With that MD5 and the file location at hand, you can compare it with:

```
$ md5sum file
```

\_069 Run commands to X display  
Sometimes you need to do something concerning the X display, but the only way you can enter the command line is by switching to an alternate instance with Ctrl+Alt+F2 or similar. To send a command to the main X display, preface it with DISPLAY=“:0” so it knows where to go.

\_070 Create a new SSH key

When you need to generate a strong encryption key, you can always have a go at creating it in the terminal. You can do this using your email address as identification by entering the following into the terminal:

```
$ ssh-keygen -t rsa -C “your_email@example.com”
```

\_071 System details

Sometimes you want to check what you’re running and you can do this with the simple uname command, which you can use in the terminal with the following:

```
$ uname
```

\_072 Kernel version

As part of uname, you also get the kernel version. Knowing this can be useful for downloading the right header files when compiling modules or updating certain aspects. You can get purely the kernel version by adding the -r option:

```
$ uname -r
```

\_073 CPU architecture

If you’re on an unknown machine, you might need to find out what kind of architecture you’re running. Find out what the processor is with:

```
$ uname -p
```

\_074 Everything else

Uname enables you to display a lot of data that is available from the system and you can look at all of this information by simply using the -a option with the command:

```
$ uname -a
```

\_075 Ubuntu version

With all the distro updates you do, it can be tricky to keep track of which version of Ubuntu you are on. You can check by using:

```
$ lsb-release -a
```

\_082 Open files in terminal

If you’ve got a file you can see in a graphical file manager, instead of opening a terminal and navigating to and then executing the file or script, you can usually run it directly from the terminal. To do this you usually just need to right-click and select a ‘run in terminal’ option.

\_083 Find files in terminal

You can search for specific files throughout the filesystem by using the find command. You need to give find a location to search in and a parameter to search for. For simply searching for a file from root with a specific name you can use:

```
$ find / -name file
```

\_084 Locate files in terminal

Similar to find is locate, a newer tool that works slightly differently to find. While find also has ways to search for files by age, size, owner and so on, locate only really uses the name to locate, however it can do it so much faster. Use it with:

```
$ locate file
```

\_085 Current location

In the terminal you might find yourself a little lost in the filesystem, or want a quick and easy way to pipe your current location into something else. You can print out your current absolute location using pwd.

```
$ pwd
```

\>\_086 Move directories  
When moving between directories you might want to be able to quickly return to the previous one that you were using. Instead of using cd for moving to the directory, you can instead use pushd to move and create a ‘stack’ of directories to move between.

```
$ pushd
```

\_087 Move back through pushd

Following on from Tip 86, once you want to start moving back up the stack to the first directory, you can use popd in the terminal. You can also check which directories you have stacked up by using the dirs command as well.

```
$ popd
```

\_088 Process priorities  
CPU priority for processes can be seen as running from -20 for highest priority or +20 for lowest. Putting “nice -n X” in front of any command enables you to change the priority from 0 to whatever number X is standing in for. Only sudo or root can elevate the priority of a process, but anyone can set one down the priority chain.

\_089 Download via the terminal

If you need to download something via the Internet in the terminal, you’ll want to use the wget command. It will take any URL you specify and download it directly into your current location in the terminal (as long as you have permission to do so). Use it like:

```
$ wget http://example.com/file.zip
```

090\_Change image formats Instead of loading up an image editor like GIMP, you can actually change images in the terminal using the convert command. You can very simply use it to change the filetype or even change the size. Do it with:

```
$ convert image.jpg image.png
```

\_091 Alter image settings  
As well as convert there’s also mogrify, which is part of the same software package. You can use it scale, rotate and do more to an image more easily than with some of the convert commands. To resize you can use something like:

```
$ mogrify -resize 640x480! image.png
```

\_092 Send message to displays

This is an old school prank that can actually have good uses when done right. Xmessage enables you to send a message prompt to an x display on the same system, as long as you know the display you want to send it to. Try:

```
$ DISPLAY=:0 xmessage -center “Hello World!”
```

\_093 Rename files with cp

This is an extension of the way you can use cp – cp will copy a file and name it to whatever you want, so you can either copy it to another directory and give it a different name, or you can just copy it into the same folder with a different name and delete the original. This also works for renaming with mv.

\_094 Manual screenshots

This is something we have to do during Raspberry Pi tutorials, but it works everywhere else. For GNOME-based desktops you can do it in the terminal by calling gnome-screenshot, in XFCE it’s xfce-screenshooter, in LXDE it’s scrot and so on. This will immediately take a screenshot of what you can see.

```
$ gnome-screenshot
...or
$ xfce-screenshooter
...or
$ scrot
```

\_095 Delayed screenshots

With the functions above, you can add delay to set up a screenshot. This is useful if you want  
to show the contents of a drop-down menu, for example. Screenshot tools allow you to delay by adding the -d option and number of seconds, eg:

```
$ scrot -d 5
```

\_096 Do the locomotion

The story behind this is that apparently after finding a lot of people misspelling the list command ‘ls’ as ‘sl’, this joke program was made to particularly hammer home that they were indeed not using the correct command. It plays the animation of a steam locomotive; sl.

```
$ sl
```

\_097 What does the cow say

A Debian trick as part of apt-get, moo is an easter egg wherein you type apt-get moo and a cow asks you if you have mooed today. If you have, in fact, not mooed today then you should immediately find a quiet room and let out a single, loud moo to appease the terminal cow.

```
$ apt-get moo
```

\_098 $ ^^^

This little trick is great for quickly correcting typing mistakes. If you omit ^^, then will be removed from the previous command. By default, only the first occurrence of is replaced. To replace every occurrence, append ":&". You can omit the trailing caret symbol, except when using ":&".

```
$ grpe peter /etc/passwd
-bash: grpe: command not found
$ ^pe^ep
```

and

```
$ grep petermac /etc/passwd ; ls -ld /home/petermac
ls: cannot access /home/petermac: No such file or directory
$ ^petermac^peter_mac^:&
```

\_099 Reference a Word of the Current Command and Reuse It

```
$ !#:N
```

The "!#" event designator represents the current command line, while the :N word designator represents a word on the command line. Word references are zero based, so the first word, which is almost always a command, is :0, the second word, or first argument to the command, is :1, etc.

```
$ mv Working-with-Files.pdf Chapter-18-!#:1
```

This translates to:

mv Working-with-Files.pdf Chapter-18-Working-with-Files.pdf

\_100 Save a Copy of Your Command Line Session

```
$ script
```

—then do stuff and finally,

```
$ exit
```

\_101 Use Vim to Edit Files over the Network

```
$ vim scp://remote-user@remote-host//path/to/file
```

\_102 Display Your Command Search Path in a Human Readable Format

```
$ echo $PATH | tr ':' '\n’
```

Show Open Network Connections

```
$ sudo lsof -Pni
```

The lsof command can not only be used to display open files, but open network ports, and network connections.

The -P option prevents the conversion of port numbers to port names.

The -n option prevents the conversion of IP addresses to host names.

The -i option tells lsof to display network connections.
