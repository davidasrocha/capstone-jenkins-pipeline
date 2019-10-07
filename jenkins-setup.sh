#!/bin/bash

if [ -z $1 ] || [ $1 = "" ] 
then
    echo "Stack name not provide"
    echo ""
    exit 1
fi

if [ -z $2 ] || [ $2 = "" ] 
then
    echo "VPC CIDR not provide"
    echo ""
    exit 1
fi

if [ -z $3 ] || [ $3 = "" ] 
then
    echo "Subnet CIDR not provide"
    echo ""
    exit 1
fi

if [ -z $4 ] || [ $4 = "" ] 
then
    echo "Security IP not provide"
    echo ""
    exit 1
fi

if [ -z $5 ] || [ $5 = "" ] 
then
    echo "Key Pair Name not provide"
    echo ""
    exit 1
fi

NETWORK_STACK_NAME="$1-network"
SERVERS_STACK_NAME="$1-servers"
STORAGE_STACK_NAME="$1-storage"

VPC_CIDR_BLOCK="$2"
SUBNET_CIDR_BLOCK="$3"

SECURITY_IP_ADDRESS="$4"
KEY_PAIR_NAME="$5"

echo "Creating network stack"

NETWORK_STACK_ID=$(aws cloudformation create-stack \
    --stack-name "$NETWORK_STACK_NAME" \
    --template-body "file://$PWD/cloudformation/jenkins-network.yml" \
    --parameters ParameterKey=VpcCidrBlock,ParameterValue="$VPC_CIDR_BLOCK" ParameterKey=SubnetCidrBlock,ParameterValue="$SUBNET_CIDR_BLOCK" \
    --region=us-west-2 \
    --query "StackId" \
    --output text)

if [ -z $NETWORK_STACK_ID ] || [ $NETWORK_STACK_ID = "" ]
then
    echo ""
    echo "ERROR: $NETWORK_STACK_NAME wasn't created"
    echo ""
    exit 1
fi

echo ""
echo "Waiting network stack creation"
echo ""

aws cloudformation wait stack-create-complete \
    --stack-name $NETWORK_STACK_NAME

echo "Creating servers stack"

SERVERS_STACK_ID=$(aws cloudformation create-stack \
    --stack-name "$SERVERS_STACK_NAME" \
    --template-body "file://$PWD/cloudformation/jenkins-servers.yml" \
    --parameters ParameterKey=JenkinsVPC,ParameterValue="$NETWORK_STACK_NAME-VPCId" ParameterKey=JenkinsPublicSubnet,ParameterValue="$NETWORK_STACK_NAME-PublicSubnetID" ParameterKey=MyIPAddress,ParameterValue="$SECURITY_IP_ADDRESS" ParameterKey=KeyPairName,ParameterValue="$KEY_PAIR_NAME" \
    --region=us-west-2 \
    --capabilities CAPABILITY_NAMED_IAM \
    --query "StackId" \
    --output text)

if [ -z $SERVERS_STACK_ID ] || [ $SERVERS_STACK_ID = "" ]
then
    echo ""
    echo "ERROR: $SERVERS_STACK_NAME wasn't created"
    echo ""
    exit 1
fi

echo ""
echo "Waiting servers stack creation"
echo ""

aws cloudformation wait stack-create-complete \
    --stack-name $SERVERS_STACK_NAME

echo "Creating storage stack"

STORAGE_STACK_ID=$(aws cloudformation create-stack \
    --stack-name "$STORAGE_STACK_NAME" \
    --template-body "file://$PWD/cloudformation/jenkins-storage.yml" \
    --region=us-west-2 \
    --query "StackId" \
    --output text)

if [ -z $STORAGE_STACK_ID ] || [ $STORAGE_STACK_ID = "" ]
then
    echo ""
    echo "ERROR: $STORAGE_STACK_NAME wasn't created"
    echo ""
    exit 1
fi

echo ""
echo "Waiting storage stack creation"
echo ""

echo "Jenkins stacks finished"
echo ""

JENKINS_IP=$(aws cloudformation describe-stacks \
    --stack-name "$SERVERS_STACK_NAME" \
    --query "Stacks[0].Outputs[?OutputKey=='JenkinsIp'].OutputValue" \
    --output text)

if [ -z $JENKINS_IP ] || [ $JENKINS_IP = "" ] 
then
    echo ""
    echo "IP to Jenkins Server not found"
    echo ""
    exit 1
fi

cd "$PWD/ansible"

echo "Provision Jenkins Server"

ansible-playbook -i "$JENKINS_IP," "$PWD/provision.yml"

if [ -f "./roles/jenkins/files/initialAdminPassword" ]
then
    JENKINS_PASSWORD=$(cat "./roles/jenkins/files/initialAdminPassword")
    echo "Your Jenkins Admin Password: $JENKINS_PASSWORD"
    rm -rf "./roles/jenkins/files/initialAdminPassword"
fi

echo "Jenkins server provisioned"

JENKINS_URL=$(aws cloudformation describe-stacks \
    --stack-name "$SERVERS_STACK_NAME" \
    --query "Stacks[0].Outputs[?OutputKey=='JenkinsURL'].OutputValue" \
    --output text)

echo "Jenkins URL: $JENKINS_URL"

exit 0
