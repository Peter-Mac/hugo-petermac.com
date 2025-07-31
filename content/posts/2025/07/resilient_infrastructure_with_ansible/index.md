---
layout: post
title: Resilient Infrastructure with Ansible
subtitle: An Ansible-Driven Approach to Proxmox Service Deployment
date: 2025-07-26
tags:
  - infrastructure
  - networks
  - self-hosting
---
**Building Resilient Infrastructure: An Ansible-Driven Approach to Proxmox Service Deployment**

When building a homelab or small-scale production environment, the challenge isn't just getting services running—it's creating an architecture that's resilient, repeatable, and maintainable over time. After iterating through various approaches, I've settled on an Ansible-driven deployment strategy for my Proxmox infrastructure that addresses these requirements while maintaining operational simplicity.

This post outlines the architectural decisions, automation patterns, and lessons learned from building a fully automated service deployment pipeline that can provision, configure, and integrate new services with just a few lines in an inventory file.

## Architectural Foundation: Resilience Through Design

### The Three Pillars of Infrastructure Reliability

**Resilience** - The system must gracefully handle failures and provide quick recovery paths
**Repeatability** - Any deployment should be reproducible across environments with consistent results  
**Maintainability** - Adding new services or modifying existing ones should be straightforward and low-risk

These principles drove every architectural decision, from the choice of Proxmox as the virtualisation layer to the specific way services integrate with monitoring and logging systems.

### Proxmox as the Foundation Layer

Proxmox Virtual Environment provides an ideal foundation for this approach because it offers both virtualisation flexibility and programmatic control:

- **LXC containers** for lightweight service deployment with near-native performance
- **Full VMs** for services requiring kernel-level isolation or specific OS requirements
- **REST API** enabling complete infrastructure automation
- **Snapshot capabilities** providing instant rollback for testing and recovery
- **Clustered storage** supporting high availability and live migration

The key insight was treating Proxmox not just as a hypervisor, but as a programmable infrastructure platform that could be fully controlled through Ansible automation.

## The Ansible Project Architecture

### Modular Role-Based Structure

Rather than monolithic playbooks, the project uses a highly modular structure that promotes reusability and clear separation of concerns. For example a shell based structure showm below:

```
ansible/
├── site.yml                    # Orchestration entry point
├── inventory/
│   ├── hosts.yml              # Infrastructure definition
│   └── group_vars/            # Hierarchical configuration
├── roles/
│   ├── common/                # Base system configuration
│   ├── proxmox_lxc/          # Container lifecycle management
│   ├── docker_host/          # Docker daemon setup
│   ├── traefik/              # Reverse proxy and service discovery
│   ├── monitoring/           # Observability stack deployment
│   └── services/             # Individual service implementations
└── traefik_dynamic/          # Auto-generated proxy configurations
```

This structure enables **composition over inheritance**—services are built by combining focused roles rather than duplicating configuration across multiple playbooks.

### Infrastructure as Code Through Inventory

The most powerful aspect of this architecture is how the entire infrastructure is defined declaratively in the inventory file (production.yml). Here's how a new service gets defined:

```yaml
       homepage_servers:
          hosts:
            prod-homepage-lxc-01:
              ansible_host: 192.168.10.32
              ansible_user: ansible
              ansible_ssh_private_key_file: ~/.ssh/id_rsa
              
              # LXC configuration
              lxc_id: 130
              lxc_hostname: 'prod-homepage-lxc-01'
              lxc_ip_address: '192.168.10.32'
              lxc_memory: 512  # Homepage needs less memory
              lxc_cores: 1
              
              #Homepage uses a custom middleware set
              service_middlewares:
                - "default-headers@file"
                - "homepage-headers@file"

    # Your existing logical groupings remain the same
    lxc_containers:
      children:
        ...
        homepage_servers:
        iot_servers:
        ...etc
    
    # the containers that will have monitoring agents installed
    # cAdvisor and/or node_exporter
    monitoring_targets:
      children:
        ...:
        homepage_servers:
        ...
        ...
```

This declaration triggers:
- LXC container provisioning with specified resources
- Base system configuration and hardening
- Docker installation and network setup
- Service deployment with proper networking
- Monitoring and logging integration

And then later:
- Automatic Traefik integration for external access 

```yaml
  - name: "homepage"
    domain: "homepage.lan.petermac.com"
    backend_url: "http://192.168.40.3:8080"
    server_transport: "insecureTransport@file"
    pass_host_header: false
    cert_resolver: "cloudflare"
    middlewares:
      secure: ["default-headers"]
      insecure: ["redirect-to-https"]

```

### Resilience Through Automation

**Immutable Infrastructure**: Every deployment creates containers from known-good templates, ensuring consistent starting states and eliminating configuration drift.

**Declarative Configuration**: Services are described in terms of desired end-state rather than imperative steps, making deployments idempotent and safe to re-run.

**Automated Testing**: Each service deployment includes health checks and validation steps that verify proper operation before marking deployment complete.

**Backup Integration**: Container snapshots and data backups are automatically configured as part of the deployment process.

## Service Integration: The Traefik Advantage

### Dynamic Service Discovery

One of the elegant aspects of this architecture is how new services automatically integrate with the reverse proxy infrastructure. Rather than manual configuration updates, services declare their routing requirements through Ansible variables:

```yaml
# Service role automatically generates Traefik configuration
traefik_services:
  - name: "{{ service_name }}"
    subdomain: "{{ service_subdomain }}"
    backend_url: "http://{{ service_name }}:{{ service_port }}"
    cert_resolver: letsencrypt
    middlewares: "{{ service_middlewares | default([]) }}"
```

This gets translated into dynamic Traefik configuration files that are automatically loaded without requiring proxy restarts. The result is zero-downtime service deployment with automatic SSL certificate provisioning (via cloudflare domain verification).

### Network Segmentation and Security

Services operate within isolated Docker networks, with Traefik serving as the controlled entry point. This provides:

- **Network isolation** between services unless explicitly connected
- **Centralised SSL termination** with automatic certificate management
- **Request routing** based on hostnames and paths
- **Middleware injection** for authentication, rate limiting, and headers

The architecture treats network security as a foundational concern rather than an afterthought.

## Observability by Default

### Integrated Monitoring and Logging

Every service deployment automatically integrates with the monitoring and logging infrastructure through inventory-driven configuration:

```yaml
    # the containers that will have monitoring agents installed
    # cAdvisor and/or node_exporter
    monitoring_targets:
      children:
        wikijs_servers:
        homepage_servers:
        iot_servers:
        traefik_servers:
```

This approach ensures that observability isn't optional—it's automatically configured for every service with appropriate dashboards, alerting, and log aggregation.

Where nodes are identified as being docker based, cAdvisor gets installed, otherwise node_exporter. There's no config as this is determined at run-time.

**Prometheus Integration**: Services expose metrics endpoints that are automatically discovered and scraped by the monitoring system.

**Centralised Logging**: Log forwarding agents are deployed alongside applications, ensuring all logs flow to the central aggregation system.

**Automated Dashboards**: Grafana dashboards are deployed as part of service roles, providing immediate visibility into service health and performance.

## Repeatability Through Standardisation

### Template-Based Deployment

The foundation of repeatability lies in standardised deployment patterns. Every service follows the same basic structure:

1. **Container Provisioning**: LXC container created from standardised template
2. **Base Configuration**: Security hardening, monitoring agents, and common tooling
3. **Service Deployment**: Application-specific installation and configuration
4. **Integration Setup**: Traefik routing, monitoring, and backup configuration
5. **Validation**: Health checks and functional testing

This approach means that adding a new service requires minimal custom code—most of the complexity is handled by reusable roles.

### Environment Consistency

The same Ansible codebase deploys across development, staging, and production environments with only variable changes. This eliminates the "works on my machine" problem and ensures that testing in development accurately reflects production behavior.

## Operational Benefits

### Streamlined Service Addition

Adding a new service to the infrastructure follows a consistent pattern:

1. **Define service in inventory** with resource requirements and integration needs
2. **Create service role** (often by copying and modifying existing role)
3. **Run deployment** with automatic integration across all infrastructure layers
4. **Validate operation** through automated health checks and monitoring

The entire process typically takes minutes rather than hours, and the risk of configuration errors is minimised through automation.

### Disaster Recovery and Migration

Because the entire infrastructure is code-driven, disaster recovery becomes a matter of:

1. **Restore data** from automated backups
2. **Run Ansible playbooks** against new infrastructure
3. **Validate services** through automated testing

This approach has been tested multiple times during hardware migrations and has consistently provided rapid recovery with minimal manual intervention.

### Documentation Through Code

The inventory file and role structure serve as living documentation of the infrastructure. Unlike traditional documentation that becomes stale, the Ansible code must accurately reflect the current state or deployments will fail.

## Performance and Resource Optimisation

### Right-Sizing Through Profiles

This is a TODO - Rather than guessing at resource requirements, services _should_ be deployed using predefined resource profiles:

```yaml
service_profiles:
  micro: { cores: 1, memory: 1024, storage: 20 }
  small: { cores: 2, memory: 2048, storage: 50 }
  medium: { cores: 4, memory: 4096, storage: 100 }
  large: { cores: 8, memory: 8192, storage: 200 }
```

These profiles are based on observed usage patterns and can be easily adjusted as requirements change. The result is better resource utilisation and more predictable performance.

### Monitoring-Driven Optimisation

Because monitoring is integrated from day one, resource optimisation decisions are data-driven rather than speculative. Regular capacity planning is informed by actual usage metrics rather than theoretical requirements.

## Lessons Learned and Evolution

### Initial Complexity vs. Long-Term Simplicity

The upfront investment in automation and standardisation is significant, but the operational benefits compound over time. What initially seems like over-engineering for a small environment pays dividends as the number of services grows.

### Configuration Management Evolution

Early iterations used static configuration files that required manual updates for each service. The current approach generates configurations dynamically based on inventory declarations, eliminating many sources of human error.

### Testing Integration

Automated testing wasn't part of the initial implementation but became essential as the infrastructure grew. Current deployments include validation steps that catch issues before they impact users.

## Open Source Contribution

The complete Ansible project is available on GitHub: [https://github.com/Peter-Mac/ansible-infrastructure-public](https://github.com/Peter-Mac/ansible-infrastructure-public)] 

The project includes:
- **Complete role library** for common services
- **Example inventory configuration** for a basic proposed deployment scenario  
- **Documentation with howto** for basic use and options
- **Testing frameworks** for validating deployments

The goal is to provide a foundation that others can build upon, adapted to their specific requirements while maintaining the core principles of resilience, repeatability, and maintainability.

## Future Evolution

### Container Orchestration Integration

While the current Docker Compose approach works well for the current scale, the architecture is designed to evolve toward Kubernetes or other orchestration platforms as requirements grow.

### Multi-Site Deployment

The modular structure supports extension to multi-site deployments with minimal changes to core roles. This capability will become increasingly important as the infrastructure scales. Note that I havent tested this beyond a single node at this point.

### Enhanced Automation

Future development will focus on even greater automation, including:
- **Automated capacity planning** based on usage trends
- **Self-healing infrastructure** that can detect and remediate common issues
- **Progressive deployment** capabilities for zero-downtime updates

## Conclusion

Building resilient infrastructure isn't about using the most advanced tools—it's about applying solid engineering principles consistently. This Ansible-driven approach to Proxmox service deployment demonstrates how automation, standardisation, and thoughtful architecture can create infrastructure that's both powerful and maintainable.

The key insights are:

**Start with Architecture**: Define principles before choosing tools
**Automate Everything**: Manual processes don't scale and introduce errors
**Design for Change**: Make common operations simple and safe
**Monitor by Default**: Observability should be automatic, not optional
**Document Through Code**: Keep documentation and implementation synchronized

For anyone building similar infrastructure, the complete project serves as both a working reference implementation and a foundation for further customisation. The investment in proper automation pays dividends in operational simplicity, system reliability, and peace of mind.

The infrastructure landscape continues to evolve, but the fundamental principles of resilience, repeatability, and maintainability remain constant. This approach provides a solid foundation for whatever challenges lie ahead.

