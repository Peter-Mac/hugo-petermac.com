---
type: post
title: "Calculating ip address ranges"
date: 2020-04-04
tags:
  - networking
  - tips
---

A handy way of calculating how many IP addresses are available in a subnet is as follows:

Eg. 1 Given an IP subnet with the CIDR of 192.168.0.0/16, how many available IP addresses have you got?

Answer is to subtract the delimiter (16) from 32 and calculate 2 to the power of the remainder....so that's 2^16 = 65536.

However beware that some cloud hosting environments pre-allocate addresses for their own use (AWS used first 4 and last 1) so you really only have 65531.

Eg 2. What's the smallest subnet you can create for the CIDR of 192.168.0.0?

Answer is 192.168.0.0/32 because 32-32 = 0 => effectively no addresses are available.

Eg 3. How many addresses are available with the CIDR of 10.0.1.0/24

Answer is 32-24 = 8, 2^8 = 256. The available IP addresses are 10.0.1.0 to 10.0.1.255

So - remember to subtract the delimiter (Mask bit) from 32 and raise 2 to the power of the result.
