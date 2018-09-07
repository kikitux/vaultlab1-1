#!/usr/bin/env bash
set -e

#sample key to test all works
vault kv put kv/key value=value
vault kv get kv/key

# sample user
vault kv put kv/user value=myuser
vault kv get kv/user

# sample pass
vault kv put kv/pass value=mypass
vault kv get kv/pass

# we call our legacy app
envconsul  -vault-renew-token=false -secret kv/key -secret kv/user -secret kv/pass ./legacyapp.sh
