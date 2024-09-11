---
layout: post
title: "Using magic_quotes_gpc or addslashes()"
date: 2015-06-01
tags: 
  - php
permalink: "/blog{% if pagination.pageNumber > 0 %}/{{ pagination.pageNumber }}{% endif %}/index.html"
---

I’ve worked on a bundle of web based applications over the years and time and time again I’ve seen the recurring problem of the slash. Yes, we’ve probably all seen it in one or more forums where the apostrophe some user entered, probably with the name O’Brein ends up as O\\Brein.

Why does this happen in sites running on PHP? The answer is a duplication of escapes. Yep, a Houdini Supreme.

Firstly a systems administrator has installed PHP and set the value for magic\_quotes\_gpc = on in the system’s php.ini (usually located in /etc/). This will automatically add slashes to all GET/POST/COOKIE data. This makes it safe before writing it to a database. Mr O’Brein becomes Mr O\\’Brein when magic\_quotes\_gpc is set to on.

Secondly, a programmer has come along and thinking they’re doing the right thing takes all user input and uses the addslashes() funtion to escape all quotes. This results in a doubling of the escapes so, Mr O’\\Brien now becomes MR O\\\\’Brein.

When this data is rendered, we see the automatic removal of only one set of escapes but the other set is left behind…yuck!!

When programmers see this they think "I’ll just use the stripslashes() method, I mean, that’s what it’s there for". As the light from the idea bulb fades, they realise they’re fixing a problem that should never have occurred in the first place. You need to go to the source of your data and clean it up, make sure you’re either using magic\_quotes\_gpc=on OR addslashes. My preference is to use addslashes all the time and turn magic\_quotes\_gpc off, this way the logic of your code explicitly sets user input to be what you want.
