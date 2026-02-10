#!/bin/bash
# template: terraform validation

set -e
cd "$(dirname "$0")/../infra"

terraform init -upgrade > /dev/null 2>&1
terraform validate
terraform fmt -check -recursive

echo "tf checks passed"
