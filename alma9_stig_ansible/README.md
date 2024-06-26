# STIG for AlmaLinux OS 9 automation

This is my libvirt+ansible automation for the soon-to-be-published [DISA STIG](https://public.cyber.mil/stigs/) for AlmaLinux OS 9.

Once the STIG is published, Ansible, Chef and SCAP automation will also be available from DISA.

The libvirt script will create a VM from a kickstart which does the basic tasks like setting up encrypted partitions and user credentials, that can't be done (easily) post-install by Ansible.

> [!WARNING]
> Do not just blindly run the hardening on your production server without thoroughly reading what the playbook does - it will lock accounts, disable wifi, reconfigure the firewall and more!

You need to at least change the network config, username and various passwords in `alma9_stig_ansible.cfg` and `inventory.yml`

You will need console access early in the boot process to enter the LUKS password, so if you run this remotely take that into consideration. Personally I use `virsh console` or Virt-Manager.

For users without a TuxCare Extended Security Updates license, run like this:

```shell
ansible-playbook playbook.yml --skip-tags tuxcare
```

> [!NOTE]
> This will probably upgrade you to the latest AlmaLinux community release (9.4) rather than keeping you on 9.2 ESU, so the FIPS mode is not validated. This is not reversible and hasn't been tested as much as 9.2 has.

Users with a FIPS 140-3 requirement (anyone officially using a STIG) should buy a 9.2 ESU license from [TuxCare](https://tuxcare.com/almalinux-enterprise-support/) and enter their `esu_key` in `inventory.yml`, then just run normally like so:

```shell
ansible-playbook playbook.yml
```

It takes under 10mins to run the Ansible hardening the first time, and even less to create the VM using libvirt.
