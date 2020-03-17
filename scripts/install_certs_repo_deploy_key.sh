#!/bin/bash

# Adds github deploy key so travis can 
# clone https://github.com/paulpires/certs

set -e

openssl aes-256-cbc \
    -K $encrypted_1d562ea9f9b4_key \
    -iv $encrypted_1d562ea9f9b4_iv \
    -in ./scripts/github_certs_deploy_key.enc \
    -out github_certs_deploy_key \
    -d
chmod 600 github_certs_deploy_key
eval $(ssh-agent -s)
ssh-add github_certs_deploy_key
