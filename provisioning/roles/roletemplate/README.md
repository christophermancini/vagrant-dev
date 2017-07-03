# Role Name

## Overview

Brief description of what this role does

## Sample Playbook

```yaml
---
- hosts: localhost
  become_method: sudo
  connection: local
  roles:
    - { role: this_role }
  vars:
    this_role_varname: 'some value'
```
