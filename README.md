# About the project

This is the fourth project of the Udacity Nanodegree Program "Cloud Dev Ops Engineer".
The objective was to do Jenkins Setup and deploy a static web site to AWS S3.

You can take a look in the infrastructure diagram [here](https://raw.githubusercontent.com/davidasrocha/aws-jenkins-pipeline/master/cloud-infrastructure-diagrams/aws-jenkins-pipeline.jpeg).

### How to run and configure project

First, you need to have configured **[AWS CLI](https://aws.amazon.com/cli/)** in your computer.

Second, you need to have a KeyPair for your Jenkins EC2 instance, and configured it in your computer.

Then, you are going to [configure stacks](./cloudformation/README.md) and [provisioner Jenkins server](./ansible/README.md).

### How to run and configure Jenkins with Ansible

Finally, you need to install some Jenkins Plugins (Blue Ocean and Pipeline AWS), and configure AWS credentials for it.
