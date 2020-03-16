#!/bin/bash

# Adds github deploy key so travis can 
# clone https://github.com/paulpires/certs

set -e

openssl aes-256-cbc \
    -K $encrypted_667e26f82b63_key \
    -iv $encrypted_667e26f82b63_iv \
    -in github_deploy_key.enc \
    -out github_deploy_key \
    -d
chmod 600 github_deploy_key
eval $(ssh-agent -s)
ssh-add github_deploy_key
