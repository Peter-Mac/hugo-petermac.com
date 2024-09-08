---
type: post
title: "Installing MySQL gem on OSX 10.6"
date: 2013-06-01
categories: 
  - "databases"
  - "osx"
  - "ruby-on-rails"
---

Hopefully this will be a time saver for anyone else who goes through the following pain.

I have a brand spanking new OSX 10.6 installation. I installed mysql 5.5.9-OSX10.6-X86 (because I thought everything was still i386 based…watch this space!) I installed RVM and installed ruby 1.92 under RVM control. I then do a ‘bundle install’ and it gripes about not having mysql2 gem installed. I do a manual install using the following command.

```
sudo gem install mysql2
```

and after a bit of crunching, we get to the following error:

```
Building native extensions.  This could take a while...
ERROR:  Error installing mysql2:
ERROR: Failed to build gem native extension.
1.9.1/ruby/ruby.h:108: error: size of array ‘ruby_check_sizeof_long’ is negative
/Users/peter/.rvm/rubies/ruby-1.9.2-p180/include/ruby-1.9.1/ruby/ruby.h:112: error: size of array ‘ruby_check_sizeof_voidp’ is negative
In file included from /Users/peter/.rvm/rubies/ruby-1.9.2-p180/include/ruby-1.9.1/ruby/intern.h:29,
             from /Users/peter/.rvm/rubies/ruby-1.9.2-p180/include/ruby-1.9.1/ruby/ruby.h:1327,
             from /Users/peter/.rvm/rubies/ruby-1.9.2-p180/include/ruby-1.9.1/ruby.h:32,
             from ./mysql2_ext.h:4,
             from client.c:1:
/Users/peter/.rvm/rubies/ruby-1.9.2-p180/include/ruby-1.9.1/ruby/st.h:69: error: size of array ‘st_check_for_sizeof_st_index_t’ is negative
```

### The Solution

- Uninstall your MySQL using the commands below
    
    sudo rm /usr/local/mysql \\ rm -rf /usr/local/mysql\* \\ rm -rf /Library/StartupItems/MySQLCOM \\ rm -rf /Library/PreferencePanes/My\* \\ rm -rf /Library/Receipts/mysql\* \\ rm -rf /Library/Receipts/MySQL\*
    
- edit /etc/hostconfig and remove the line MYSQLCOM=-YES
    
- Now go and download the 64 bit version of the MySQL package – get the dmg rather than the gzip file.
    

The rationale behind this is that your new beaut 10.6 is actually referencing 64 bit modules by default. How to prove this I do not know – I’m confused and still searching for the answer. If I do a uname, I get the following.

```
$ uname – a
Darwin MacBook-Air.local 10.6.0 Darwin Kernel Version 10.6.0: Wed Nov 10 18:13:17 PST 2010; root:xnu-1504.9.26~3/RELEASE_I386 i386
```

Now, if I’m not mistaken that’s an i386 at the end – go figure. If anyone has any further insights please let me know.

The next step is to download the gem for your ruby/rails use

```
sudo env ARCHFLAGS="-arch x86_64" gem install mysql2 -- \
--with-mysql-dir=/usr/local/mysql --with-mysql-lib=/usr/local/mysql/lib \
--with-mysql-include=/usr/local/mysql/include
```

- The next error encountered is when I try to start the rails server using ‘rails s’
    
    /Users/peter/.rvm/gems/ruby-1.9.2-p180/gems/mysql2-0.2.6/lib/mysql2.rb:7:in \`require': dlopen(/Users/peter/.rvm/gems/ruby-1.9.2-p180/gems/mysql2-0.2.6/lib/mysql2/mysql2.bundle, 9): Library not loaded: libmysqlclient.16.dylib (LoadError)
    
- The answer to this problem is to run the following command
    
    sudo install\_name\_tool -change libmysqlclient.16.dylib /usr/local/mysql/lib/libmysqlclient.16.dylib ~/.rvm/gems/ruby-1.9.2-p180/gems/mysql2-0.2.6/lib/mysql2/mysql2.bundle
    

Bear in mind, I’m running version 1.9.2-p180 fo ruby – you will need to change the command for whatever version you’re running.
