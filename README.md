# Notes on Infrastructure Automation at Home

## Proxmox

-[ubuntu - how to use cloud-init](https://documentation.ubuntu.com/lxd/latest/cloud-init/)
-[proxmox forum - network setup using cloud init](https://forum.proxmox.com/threads/cloud-init-network-configuration-with-ubuntu-cicustom-option.115746/post-500466)

```shell
--cicustom "user=local:snippets/userconfig.yaml,vendor=local:snippets/cloudinit-vendor.yml,network=local:snippets/cloudinit-network.yml"
```

cloud-init.vendor-data
cloud-init.user-data
cloud-init.network-config

example

```yaml
config:
  cloud-init.network-config: |
    version: 2
    ethernets:
      eth1:
        addresses:
          - 10.10.101.20/24
        gateway4: 10.10.101.1
        nameservers:
          addresses:
            - 10.10.10.254
```