# About the project

This project is part of the Udacity Nanodegree Program "Cloud DevOps Engineer". The objective is going to deploy an API using blue-green strategy directly on Kubernetes.

You can take a look in the infrastructure diagram [here](https://raw.githubusercontent.com/davidasrocha/capstone-jenkins-pipeline/master/cloud-infrastructure-diagrams/aws-jenkins-pipeline.jpeg).

### How to run and configure project

First, you need to have configured **[AWS CLI](https://aws.amazon.com/cli/)** in your computer.

Second, you need to have a KeyPair for your Jenkins EC2 instance, and configured it in your computer.

Then, you are going to [configure stacks](./cloudformation/README.md) and [provisioner Jenkins server](./ansible/README.md).

### Configure Jenkins Pipeline

Finally, you need to install some Jenkins Plugins (Blue Ocean and Pipeline AWS), and configure AWS credentials for it.

### How to do partial setup

You can do a partial setup including CloudFormation Stacks and Jenkins install and follow the Jenkins Wizard Configuration.

First, you need to run this command:

```
./jenkins-setup.sh STACK_NAME VPC_CIDR_BLOCK SUBNET_CIDR_BLOCK YOUR_IP_ADDRESS KEYPAIR_NAME
```

After this command running you can get **Jenkins URL** in console to access **Jenkins Wizard** in Web Browser.