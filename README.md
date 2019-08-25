# About the project

This is the fourth project of the Udacity Nanodegree Program "Cloud Dev Ops Engineer".
The objective was to do Jenkins Setup and deploy a static web site to AWS S3.

You can take a look in the infrastructure diagram [here](https://raw.githubusercontent.com/davidasrocha/aws-jenkins-pipeline/master/cloud-infrastructure-diagrams/aws-jenkins-pipeline.jpeg).

### How to run

First, you need to have configured **[AWS CLI](https://aws.amazon.com/cli/)** in your computer.

Second, you need to have a KeyPair for your Jenkins EC2 instance, and configured it in your computer.

Finally, you can configure parameters to CloudFormation stack:

* Copy file `./cloudformation/parameters/jenkins-network.json.dist` to `./cloudformation/parameters/jenkins-network.json`, and edit parameters.
* Copy file `./cloudformation/parameters/jenkins-servers.json.dist` to `./cloudformation/parameters/jenkins-servers.json`, and edit parameters.

So, you can run this command to access CloudFormation directory:

```
cd ./cloudformation
```

Now, you can run this command to create stacks to Jenkins network and server:

```
./jenkins-stack-create.sh jenkins-pipeline
```

Run this command to create S3 Bucket to web site:

```
./website-stack-create.sh static-website
```

Then, you need to install some Jenkins Plugins (Blue Ocean and Pipeline AWS), and configure AWS credentials for it.

### How to access Jenkins

After create a stack, you can use exported value **JenkinsURL** to access de public Jenkins address in any web browser.
