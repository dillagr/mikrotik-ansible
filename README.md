## Mikrotik +Ansible
I didn't know that Mikrotik can be configured by Ansible. This information came about from a recent blogpost that mentioned the possibility.  

So here it is.


## **_Prework Notes_**
You may need to run the following commands to download the routeros modules.  

```
ansible-galaxy collection install ansible.netcommon
ansible-galaxy collection install community.routeros
```

And, configure your own ansible-vault (vars/creds.yml). I didn't share this file as it contains my passwords.


## **_Execute Ansible_**
To run the playbooks, just execute this command.

```
ansible-playbook -i inventory 00-reset-noconfig.yml
```

(.. and the rest of the other numbered _yml_ files.)


## Trainings
These Mikrotik trainings have really benefited me. I highly recommend them.

* [MikroTik LABs for Beginners](https://bit.ly/2MJgiw1)
* [MikroTik Traffic Control with LABs](https://bit.ly/30NYHJM)
* [MikroTik RouterOS Hardening LABs](https://bit.ly/2WPn2xV)
* [MikroTik Network Associate with LABs](https://bit.ly/3f8vHC9)
* [MikroTik Security Engineer with LABs](https://bit.ly/2ZYjkUF)
* [Starting an ISP with MikroTik](https://bit.ly/2WQDUEo)
* [MikroTik Network Management with LABs](https://bit.ly/2CLh7mE)
* [VLAN on MikroTik with LABs](https://bit.ly/2ZWxZ2w)
* [OSPF on MikroTik with LABs](https://bit.ly/3jDo1ej)


