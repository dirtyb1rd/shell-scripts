#!/bin/bash
# template: ansible validation

set -ecd "$(dirname "$0")/../ansible"

ansible-playbook playbook.yml --syntax-check
ansible-lint playbook.yml

echo "ansible checks passed"
