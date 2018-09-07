# vaultlab1

## what

This is sample legacyapp that requires user/pass to connect to a db.

We setup a Vault node, and using envconsul to sun our `legacyapp.sh` we can get the values from vault.

## How to run

```
vagrant ssh
sudo su -
cd /vagrant
./app.sh
```
