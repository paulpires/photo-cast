#!/bin/bash

# Adds github deploy key so travis can 
# clone https://github.com/paulpires/certs

set -e

openssl aes-256-cbc \
    -K $encrypted_667e26f82b63_key \
    -iv $encrypted_667e26f82b63_iv \
    -in ./scripts/github_certs_deploy_key.enc \
    -out deployment_key \
    -d
chmod 600 deployment_key
eval $(ssh-agent -s)
ssh-add deployment_key
