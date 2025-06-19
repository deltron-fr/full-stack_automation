## Full Stack Monitoring & Automation Platform

This project is a fully automated, production-ready stack for deploying, monitoring, and managing a modern web application on Azure. It leverages Terraform for infrastructure provisioning, Ansible for configuration management and application deployment, and Docker Compose for orchestrating application and monitoring services. The stack includes a PostgreSQL database, backend and frontend services, Nginx reverse proxy, SSL via Certbot, and a complete monitoring suite (Prometheus, Grafana, Loki, Promtail, cAdvisor).

---

## Table of Contents

- [Architecture Overview](#architecture-overview)
- [Folder Structure](#folder-structure)
- [Infrastructure Provisioning (Terraform)](#infrastructure-provisioning-terraform)
- [Configuration Management & Deployment (Ansible)](#configuration-management--deployment-ansible)
- [Application & Monitoring Stack (Docker Compose)](#application--monitoring-stack-docker-compose)
- [Monitoring Stack Details](#monitoring-stack-details)
- [Environment Variables](#environment-variables)
- [How to Deploy](#how-to-deploy)
- [Accessing the Services](#accessing-the-services)
- [Customization](#customization)
- [Troubleshooting](#troubleshooting)
- [Credits](#credits)


## Architecture Overview


All infrastructure and services are provisioned and configured with a single command:
```
terraform apply -auto-approve
```

## Folder Structure

```
.
├── ansible/
│   ├── .env.j2
│   ├── ansible.cfg
│   ├── compose.monitoring.yaml.j2
│   ├── compose.yaml.j2
│   ├── inventory.ini
│   ├── nginx.conf.j2
│   ├── playbook.yaml
│   └── sample_all.yaml
├── monitoring/
│   ├── grafana.ini
│   ├── loki-config.yaml
│   ├── prometheus.yaml
│   ├── promtail-config.yaml
│   ├── dashboards/
│   │   ├── prometheus-dashboard.json
│   │   └── cadvisor-dashboard.json
│   └── provisioning/
│       ├── datasources/
│       │   └── datasources.yaml
│       └── dashboards/
│           └── dashboard.yaml
├── terraform/
│   ├── ansible.tf
│   ├── backend.tf
│   ├── main.tf
│   ├── ouptut.tf
│   ├── providers.tf
│   ├── terraform_sample.tfvars
│   └── variables.tf
└── .gitignore
```

---

## Infrastructure Provisioning (Terraform)

All Azure infrastructure is defined using **Terraform** with the `azurerm` provider.

### 🔑 Key Resources

- **Resource Group**, **Virtual Network**, **Subnet**
- **Public IP**, **Network Interface**, **Network Security Group**
- **Linux Virtual Machine** (Ubuntu 22.04 LTS)
- **Network Security Rules** for:
  - SSH (port 22)
  - HTTP (port 80)
  - HTTPS (port 443)
- **Remote and Local Provisioners** for:
  - Ansible playbook execution.
  - Dynamic DNS update - using [afraid.org](https://freedns.afraid.org/).

### 📦 Variables

- Defined in `variables.tf`
- Values provided via:
  - `terraform_sample.tfvars` (example file), actual file is `terraform.tfvars`

### 🗃️ Remote State

- Configured in `backend.tf`.
- Uses **Azure Storage Account** for remote state management.


