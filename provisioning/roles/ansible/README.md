# Ansible

## Overview

Installs Ansible on the target machine

## Sample Playbook

```yaml
---
- hosts: localhost
  become_method: sudo
  connection: local
  roles:
    - { role: ansible }
  vars:
    this_role_varname: 'some value'
```
