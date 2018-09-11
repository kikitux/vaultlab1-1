#!/usr/bin/env bash

# this is using ENV consul
set -e

#sample key to test all works
vault kv put kv/key value=value
vault kv get kv/key

# sample user
vault kv put kv/user value=najib
vault kv get kv/user

# sample pass
vault kv put kv/pass value=test123
vault kv get kv/pass

# we call our legacy app
envconsul -vault-renew-token=false -secret kv/key -secret kv/user -secret kv/pass ./legacyapp.sh
