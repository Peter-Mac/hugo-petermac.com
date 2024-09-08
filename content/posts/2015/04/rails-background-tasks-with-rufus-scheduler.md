---
type: post
title: "Rails background tasks with Rufus Scheduler"
date: 2015-04-09
categories: 
  - "ruby-on-rails"
---

I have a database that is populated based on events that happen in real-time. I wanted to view the output of reports from that database on a regular basis (every 30 seconds). I found a lovely little gem called ‘rufus-scheduler’ that does the trick nice and neatly. Here’s how it worked for me.

Add the gem to your Gemfile

```
gem 'rufus-scheduler'
```

Update your bundle with bundle install

```
/path/to/my/app/$ bundle install
```

Create a file in your initializers folder. I’ve called mine task\_scheduler. This file contains instructions to start the scheduled background process and on the tasks you want to run regularly.

The contents of mine are as follows:

```
scheduler = Rufus::Scheduler.start_new

scheduler.every("30s") do
   stats_direct = Stats.new("Frankston Direct")
   stats_direct.line_status

   stats_loop = Stats.new("Frankston Loop")
   stats_loop.line_status

   stats_loop = Stats.new("Sandringham")
   stats_loop.line_status
end
```

And that’s all there is to it.

More info on the gem can be found [here](https://rubygems.org/gems/rufus-scheduler)
