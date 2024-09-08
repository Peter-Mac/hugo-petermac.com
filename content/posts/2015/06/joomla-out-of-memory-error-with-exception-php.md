---
type: post
title: "Joomla out of memory error with exception.php"
date: 2015-06-01
categories: 
  - "cms"
  - "php"
---

I’ve just suffered a strange out of memory exception with one of my Joomla sites. All the posts I read indicated that I needed to allocate more memory in my php configuration – crazy I thought – I already had 64MB allocated. There must be something more fundamentally wrong for this nasty gremlin to be happening. The actual error is–

```
Fatal error: Allowed memory size of 67108864 bytes exhausted (tried to allocate 40 bytes) in /home/site/public_html/libraries/joomla/error/exception.php on line 117
```

What I did (thanks to a couple of fragmented suggestions is change the line on 117 to the following

```
$this->backtrace = debug_print_backtrace();
```

Then re-render the site and you should see your browser fill with tons of crap. Hit the stop button after a second or two (before your browser crashes) and you should be able to see the root cause of your issue. For me it was a corruption of my jos\_session table which I was able to fix with a truncate jos\_session; command from the mysql command line.

I hope this note may save someone else a couple of hours of messing around with their memory settings.
