---
layout: post
title: High Availability for Your Home Automation
subtitle: Keep things going where others may fail
date: 2024-11-12
tags:
  - hoome-automation
  - networks
---

A couple of lessons I've learned along the way to smooth the HA journey to minimise outages and keep the sanity of your family intact by avoiding the failure of any of the automations they've all come to expect as standard.

"Honey, the bathroom lights are staying on and I'm trying to brush my teeth in the dark!" which is 'spouse-speak' for "have you been playing with stuff again? I wish you wouldn't!"

A couple of steps that can be taken to minimise glitches in the matrix. In order of increasing complexity they are:

1. Ditch those hubs that rely on cloud, use local integrations instead.
2. If using the Conbee USB zigbee devices, keep a backup device on hand.
3. Use a Uninterruptible Power Supply (UPS) for your main automation server.
4. If you've implemented local DNS (with Pi-hole running on any device), create a duplicate instance and run it on a different power circuit.
5. If you can spare the dollars. euros, escudos etc, invest in a backup hosting server.
6. If you can spare even more, go for three servers and use a kubernetes cluster to have a nearly unbreakable environment.

Note: The perfect server type will have dual NICs to help support redundancy.

[Here's what I've gone for as an example](https://www.servethehome.com/minisforum-ms-01-review-the-10gbe-with-pcie-slot-mini-pc-intel/)

In my setup, I've got 1 through to 5 implemented so far.

## Hub Simplification

_Covering steps 1 and 2 above_

I had the following hubs at various stages:
- Philips Hue
- Samsung Smart Things
- Ario Camera base station
- Nue hub (local vendor's zigbee(ish) device)

These have all been ditched over time with the introduction of a Zigbee Conbee II USB receiver and it's integration into a combination of Zigbee2MQTT and Home Assistant. 

The problem with all these devices and 'availability' is if your internet fails, their reliance on cloud services means you're left high and dry with unstable or at the very best unknown variability on local functionality. If you can keep everything local, it's one less link in the chain to be worried about.

The Conbee device is pretty affordable ($50-$60)

I run it on an extended USB cable so as to help reduce the electromagnetic interference caused by other devices near it.  **Get a USB extension cable to avoid hours of frustration**

I subsequently got a second Conbee device and keep it in it's wrapper pinned to the wall behind the main servers as a belt and braces measure. If the primary device fails, it would take a fair few days of frustration waiting on a backup to arrive from uncle Bezos.

## UPS

_Covers point 3 above_

A reliability measure for any decent self-hosted environment really should include a UPS to help protect the key devices in the network.

**Why?**
If your power goes out, there's no lights to control, there's no blinds to be raised or lowered. It's a dash for the candles and torches, or if you're lucky a trip to the local cafe (to find they've also got a power outage !!)

So...the reason for a UPS is not immediately obvious. There are 2 reasons I can think of.

a) Graceful power-down of the supported devices.

b) If power comes back in a relatively timely manners, you don't have to reset anything, ensure your docker services have come up properly, DNS is available when needed etc.

**What needs to be protected in the case of a power outage?**
Any device that acts as an integral part of the network setup. Only you can be the judge of that. 
In my case, I've gone for a bit of a whopper UPS with the ability to connect half a dozen devices. The services include:

 - Home Assistant Server
 - Pi-hole DNS Servers x 2
 - NAS
 - Firewall Device
 - Routers
 - Network Hub

## DNS fail-over

_Number 4 from the list_

I've got two raspberry Pies (is that the correct plural of pi?) each has an identical install of Pi-Hole DNS with cross device replication in place. This is pretty straight forward to setup with plenty of articles online on how to set up.

Local DNS is configured through routers to promote both the devices with a third reference to Cloudflare's 1.1.1.1 for external routing use.

Both PIes are UPS enabled.

## Backup Hosting Server

_Step number 5_

This is where it gets a little bit flaky for me. I've an 'always on' Apple Mac mini which I use to act as an rsync client for the main HA server. Now, this is where I could/should be doing things a bit better (and I will when I get the time).

Ideal setup would be:

 - Use of two identical devices (A and B).
 - Ansible driven device setup with repeatable and immutable installation and config of both
 - Real time replication of events and logs to central host from A
 - Remote alerting (via ping or other uptime service (kuma-uptime))
 - Automatic failover from A to B if kuma reports outage

However, right now, I've got rsync working and the knowledge that if the primary server ever suffers catastrophic HDD failure, I'm kind of stuffed. 

Next steps here are: 

- To pull my finger out and get the MiniForums (MF) device setup with Proxmox and Ansible with a live instance of Home Assistant.
- To ensure that the MF device can run HA in live fail-over with my little Intel NUC powered off.
- To bring the spare Conbee device into the mix and see how it interoperates with the existing on (conflicts?? I really don't know).

## HA Cluster

_and finally step 6_

For the future...when I get around to finishing the previous pieces off and get spouse approval for yet more hardware hiding under the stairs. You need 3 nodes in a cluster for one to act as an arbiter in the case of a fail-over with one of the others. While not mandatory to have the same hardware in place, the recommendation is to do this to ensure any system hardware differences don't introduce unexplained glitches. I'll give this a run however using some non-identical kit before splashing out on anything new.

## Summary
We've had network outages in the recent past with the neighbourhood impacted as a result of a road-dig. The automations didn't miss a beat.

We've had power outages when a tree fell on a power line nearby (sounded like a light sabre from star wars from the back garden). The devices stayed online for about an hour at which point, I decided to power them down gracefully. This avoids possible HDD failures due to sudden halting of spin.

Everything else from the above is different levels of icing on the cake. Some of which I'm happy to forgo until I get bored, retire or both.