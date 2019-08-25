# How to run Ansible to provioner Jenkins

First, you need to have the EC2 instance IP where you are going to install Jenkins

Finally, you can run this command:

```
ansible-playbook -i EC2_INSTANCE_IP, provision.yml

// ansible-playbook -i 192.168.0.2, provision.yml
```
