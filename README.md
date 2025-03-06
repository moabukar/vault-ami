# Vault AMI Build

```bash
packer init .
packer fmt .
packer validate .

packer build vault-ami.pkr.hcl
```