---
layout: post
title: "Home Automation with Nue hub"
date: 2019-10-02
tags: 
  - home-automation
---

**Experience with combination of the 3ASmartHome ‘Nue' and Philips Hue components so far.**

**The Goal**

To automate light operations around the house with integration between Alexa, IFTTT and general schedules.

I have replaced old fashioned halogen lights with LEDs over time and didn't want to blow that investment (approx 30 downlight at $30-$40 per light) so I was looking for a smart light switch solution instead. I also knew a few automations would be motion driven so integration with motion sensors would also be ideal.

Below is an account of my experience with the 3asmarthome switches and assorted components available from 3asmarthome.com.au based in Cheltenham in Melbourne, Australia.

  
**Smart Switches**

The 3a smart switches look fairly smart and modern. The build is pretty good with only concern being a slight movement on one or two units when installed due to the outer casing being a tiny bit too large. The switches are good for controlling lights through Alexa voice activation. Detection of devices in the Hui app is good - but control is limited to rudimentary ‘scene’ conditions. The ability to program the switches does not exist (no openhab/hassio integration). This is disappointing given the use of the Zigbee 3.0 protocol implies the devices should be identifiable and controllable.  

The installation of switches will only work where a neutral (black in AU) wire is available at the switch. A number of 2-way and 3-way scenes in my house dont have such available. This is a pain as it results in new (smart) switches being mixed with old. There is currently no way to provide a dumb switch option (ie. with same look and feel as smart ones) to install for consistency around the house.  

The lack of a switch option in these cases means the use of a smart light bulb is the only option. So I end up with a dumb light switch controlling a smart light bulb...there is an upside with smart lights as detailed below.  
On the downside, a dumb switch controlling a smart light means the switch must be left on if you want any scenes/automations to work. If you switch the light off, this obviously cuts power to the light and you’re back to an ‘off’ smart light bulb. This is not a good place to be.  

**Smart Light bulbs**

Effective and cheaper than the Philips ones. Multi colour, identifiable and controllable by the Philips Hue App (and Alexa). The light status in the Hue app has to be set as ‘always on’ to allow remote programming/control through scenes. They fit the existing downlight holes so no extra cutting is required (which I’ve read about with the Philips downlights).  I’m thinking of swapping out some lights (controlled by smart switches) to be smart bulbs to provide more control (office, laundry, cellar). Light quality is fairly good, but I’ve nothing to compare it against. On the downside (referred to above)...you hav to leave the light switch on and control them via app/voice otherwise your smart bulb becomes dumb very quickly.

  
**Motion Sensors**

Very finicky to set up - multiple attempts failed, then as if by magic (and with support from the 3aSmarthome guys everything worked but I’m still not sure what I changed - the Hui app is extremely frustrating in its simplicity and lack of intuitive controls. This results in lights coming on at all times during the day? I’m sure I need to go back to the dreaming board with this...it just cant be so!!  

I also purchased a few Philips Hue motion sensors given the trials I had with the 3A ones. The outcome is that they can only be used to control other Philips Hue devices and the 3A smart lights. They can’t be used to control the 3a light switches...this is a bummer given the number of switches I’ve installed. Upshot is install smart lights where you want motion control (via Philips Hue) and switches where voice control is preferred.  

**Infrared Control**

Depends on a specific ‘Smart Life’ app. Once installed, and configured it’s very versatile in terms of providing an absolute tonne of devices to control. I had it controlling my 10+ year old aircon within a few minutes. I set up a ‘false’ condition to turn on the air con when the temperature dropped below 21C....the ambient temperature was about 17C...next thing the aircon is humming away.
