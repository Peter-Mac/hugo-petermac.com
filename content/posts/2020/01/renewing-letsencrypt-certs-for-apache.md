---
layout: post
title: "Renewing letsencrypt certs for Apache"
date: 2020-01-16
tags: 
  - gnu-linux
  - apache
  - letsencrypt
---

# To renew as standalone and restart apache

```
> sudo service apache2 stop sudo certbot certonly --standalone
```

Results in the following output:

```
Saving debug log to /home/peter/appdir/~/.certbot/logs/letsencrypt.log
Plugins selected: Authenticator standalone, Installer None
Please enter in your domain name(s) (comma and/or space separated) (Enter 'c'
to cancel): staging.spxtrader.com.au
Obtaining a new certificate
Performing the following challenges:
http-01 challenge for staging.spxtrader.com.au
Waiting for verification...
Cleaning up challenges
Non-standard path(s), might not work with crontab installed by your operating system package manager
```

```
IMPORTANT NOTES:
- Congratulations! Your certificate and chain have been saved at:
/home/peter/appdir/~/.certbot/config/live/staging.spxtrader.com.au/fullchain.pem
Your key file has been saved at:
/home/peter/appdir/~/.certbot/config/live/staging.spxtrader.com.au/privkey.pem
Your cert will expire on 2020-01-04. To obtain a new or tweaked
version of this certificate in the future, simply run certbot
again. To non-interactively renew *all* of your certificates, run
"certbot renew"
- If you like Certbot, please consider supporting our work by:

Donating to ISRG / Let's Encrypt: https://letsencrypt.org/donate
Donating to EFF: https://eff.org/donate-le
```

Then update your /etc/apache2/sites-available/vhosts-ssl.conf

> sudo service apache2 start
