---
layout: post
title: "Background Check Network Status"
date: 2020-04-24
tags:
  - networking
  - mac-os
  - scripting
---

Because I live in the land down under where we're serviced by a broadband network system that's been screwed over by a number of successive Governments, we can never be guaranteed a consistent service. I wrote the following script to run in the background on my Apple Mac to notify me of any changes to the network status. It requires nc to run...but you can change this to any command that does an external connection test such as a simple ping. It does a little sleep at the end for 10 seconds. Obviously adjust to suit your circumstances.

```
#!/bin/bash

INTERNET_STATUS="UNKNOWN"

while [ 1 ] 
do
nc -z 8.8.4.4 53 >/dev/null 2>&1
if [ $? -eq 0 ]  ; then
  if [ "$INTERNET_STATUS" = "DOWN" ] || [ "$INTERNET_STATUS" = "UNKNOWN" ] ; then
      # if on a mac you can have siri speak to you...
      # using the say command
      # otherwise change the say command to echo
      # or in my case, have a notification pop up to let you know when offline
      /usr/bin/osascript -e "display notification \"The network is up\" with title \"Network Status\""
      INTERNET_STATUS="UP"
  fi
else
  if [ "$INTERNET_STATUS" = "UP" ]; then
      /usr/bin/osascript -e "display notification \"The network is down\" with title \"Network Status\""
      INTERNET_STATUS="DOWN"
  fi
fi
sleep 10 
done;
```

It runs in the background and can be killed by simply identifying the processing and issuing a kill command. For example I run it as a file called check\_network.sh with chmod +x applied.

To start it simply type

./check\_network.sh

To kill it, look for it's pid and kill issue the kill command


![Kill the running background process](/images/2020-04-24-kill_ps.jpg)
Killing the running background process
