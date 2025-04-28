---
layout: post
title: Thoughts on setting up Proxmox on a home network 
subtitle: Scalable (sort of), configurable and flexible
date: 2025-01-14
tags:
  - infrastructure
  - networks
  - self-hosting
---

When running a stable home server with Docker containers for services like
Traefik (reverse proxy), Plex (media server), Calibre (e-book library), Home 
Assistant, Mosquitto (MQTT), and Zigbee2MQTT, it's natural to ask: should I
stick with Docker on bare metal or move to Proxmox Virtual Environment (PVE)? 

**Proxmox** is a platform that combines full virtualization (via KVM VMs) and 
lightweight containers (LXC), offering features beyond what a standard 
Docker-on-Linux setup provides ([Proxmox vs Docker: Comprehensive Comparison for Users](https://readyspace.com/proxmox-vs-docker/#:~:text=%2A%20Proxmox%20is%20an%20open,deployment%2C%20portability%2C%20and%20development%20workflows)).
This article (and a few that will follow) will walk through what Proxmox can offer, the key technical concepts (especially around networking) for a migration, and how to address challenges like VLAN segmentation and device passthrough in a single-node home lab. The goal is to help you decide _“to Proxmox or not”_ by understanding the trade-offs and setup steps, in clear and approachable terms.

## What Proxmox Offers Beyond Docker on Bare Metal

**Proxmox VE** (Virtual Environment) is an open-source **type-1 hypervisor** platform that runs on a bare-metal Debian-based OS. In contrast to Docker, which isolates applications in containers using the host kernel, Proxmox can run entire **virtual machines (VMs)** _and_ Linux containers side by side ([Proxmox vs Docker: Comprehensive Comparison for Users](https://readyspace.com/proxmox-vs-docker/#:~:text=Proxmox%20VE%20supports%20two%20key,the%20quick%20deployment%20of%20applications)) ([Proxmox vs Docker: Comprehensive Comparison for Users](https://readyspace.com/proxmox-vs-docker/#:~:text=,backup%20options%20for%20data%20integrity)). Here are some key benefits Proxmox provides beyond a plain Docker-on-Linux server:

- **Full OS Isolation:** Each service can run in its own VM or LXC container with a dedicated OS environment. This means you could, for example, run Home Assistant OS in a VM and Plex in a separate container or VM, achieving stronger isolation than Docker’s process-level isolation. You can even run different OSes (e.g. a Windows VM or a specialized Linux distro) if needed.
    
- **Integrated Web UI Management:** Proxmox comes with a web-based management interface for creating and controlling VMs/containers, configuring networks, and monitoring resources. No need for separate tools – everything (status, logs, console access, snapshots) is available in the browser. This can complement or replace command-line Docker/Portainer workflows with a more visual approach.
    
- **Advanced Features:** Proxmox supports **snapshots** and **backups** of VMs and containers out of the box, making it easy to take point-in-time backups of an entire service environment. It also supports features like live migration (moving a VM to another host with minimal downtime) and clustering for **high availability** setups ([Proxmox vs Docker: Comprehensive Comparison for Users](https://readyspace.com/proxmox-vs-docker/#:~:text=%2A%20Proxmox%20is%20an%20open,deployment%2C%20portability%2C%20and%20development%20workflows)). While these might be overkill for a single home server today, they open the door to future expansion (e.g. adding a second node for redundancy).
    
- **Flexibility (VMs _and_ Containers):** With Proxmox you can choose the virtualization type per service. Use a full VM when you need complete isolation or a different OS, and use an **LXC container** for a lightweight environment closer to a Docker container. Proxmox’s LXC containers share the host kernel (like Docker) but behave more like mini-OS machines (with their own init system). This hybrid capability means you’re not limited to one approach ([Proxmox vs Docker: Comprehensive Comparison for Users](https://readyspace.com/proxmox-vs-docker/#:~:text=Proxmox%20VE%20supports%20two%20key,the%20quick%20deployment%20of%20applications)).
    
- **Firewall and Security Features:** Proxmox includes an optional built-in firewall that can apply rules at the VM or container level and across the host, adding another layer of security on top of your network’s firewall. Each VM/CT can have firewall rules defined to restrict traffic, and if you cluster Proxmox nodes, you can even define cluster-wide firewall policies ([Cluster Manager - Proxmox VE](https://pve.proxmox.com/wiki/Cluster_Manager#:~:text=files%2C%20replicated%20in%20real,corosync)).
    

**In short,** Proxmox is like upgrading your single host into a fully featured virtualization server. It excels at scenarios where you want to simulate a multi-server environment on one machine, have stronger isolation, or need features like snapshots and easy resource allocation. Docker shines in lightweight app deployment and easy portability of applications ([Proxmox vs Docker: Comprehensive Comparison for Users](https://readyspace.com/proxmox-vs-docker/#:~:text=%2A%20Proxmox%20is%20an%20open,deployment%2C%20portability%2C%20and%20development%20workflows)), so the decision depends on whether you need Proxmox’s extra capabilities badly enough to justify the added complexity. If you foresee running diverse workloads, experimenting with different OS environments, or scaling out to multiple hosts, Proxmox offers a powerful platform to build on. Otherwise, a simple Docker-on-Linux setup might remain more efficient for your needs ([Advice needed: looking to migrate my docker containers to Proxmox : r/Proxmox](https://www.reddit.com/r/Proxmox/comments/zjumsr/advice_needed_looking_to_migrate_my_docker/#:~:text=I%20dont%20see%20the%20point,portainer%20there%20and%20thats%20it)).
