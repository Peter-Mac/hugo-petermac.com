---
layout: post
title: "Securing PostgreSQL"
date: 2020-02-16
tags: 
  - databases
  - permissions
  - postgresql
  - security
---
Here's some post install tasks tht should be considered to ensure your PostgreSQL setup is nice and secure.

Install PostgreSQL

`sudo apt-get update sudo apt-get install postgresql postgresql-contrib`

Upon installation, Postgres creates a Linux user called "postgres" which can be used to access the system. We can change to this user by typing: `sudo su - postgres` From here, we can connect to the system by typing: `psql`

Notice how we can connect without a password. This is because Postgres has authenticated by username, which it assumes is secured.

Exit out of PostgreSQL and the postgres user by typing the following: `\q exit` Disable Remote Connections

`sudo vi /etc/postgresql/9.1/main/pg_hba.conf`

Ensure the contents of the config file look something like the following:

`local all postgres peer local all all peer host all all 127.0.0.1/32 md5 host all all ::1/128 md5`

The first two security lines specify "local" as the scope that they apply to. This means they are using Unix/Linux domain sockets. The second two declarations are remote, but the hosts that they apply to (127.0.0.1/32 and ::1/128) are interfaces that specify the local machine.

**What If You Need To Access the Databases Remotely?**

To access PostgreSQL from a remote location, consider using SSH to connect to the database machine and then using a local connection to the database from there. It is also possible to tunnel access to PostgreSQL through SSH so that the client machine can connect to the remote database as if it were local. [Visit the PostgreSQL official documentation pages.](https://www.postgresql.org/docs/9.1/ssh-tunnels.html)

Use roles to lock down access to individual databases

Log into PostgreSQL:

`sudo su - postgres psql`

To create a new role, type the following:

`CREATE ROLE role_name WITH optional_permissions;`

To see the permissions you can assign, type:

`\h CREATE ROLE`

You can alter the permissions of any role by typing:

`ALTER ROLE role_name WITH optional_permissions;`

List the current roles and their attributes by typing:

`\du List of roles Role name | Attributes | Member of -----------+------------------------------------------------+----------- hello | Create DB | {} postgres | Superuser, Create role, Create DB, Replication | {} testuser | | {}`

Create a new user and assign appropriate permissions for every new application that will be using PostgreSQL.
