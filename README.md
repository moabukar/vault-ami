# Vault AMI Build

```bash
packer init .
packer fmt .
packer validate .


## Configure AWS

aws configure # OR export AWS_ACCESS_KEY_ID=...
packer build vault-ami.pkr.hcl
```