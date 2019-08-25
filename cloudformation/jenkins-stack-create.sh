#!/bin/bash

NETWORK_STACK_NAME="$1-network"
SERVERS_STACK_NAME="$1-servers"

echo "Creating network stack"

aws cloudformation create-stack \
    --stack-name $NETWORK_STACK_NAME \
    --on-failure DELETE \
    --template-body file://./jenkins-network.yml \
    --parameters file://./parameters/jenkins-network.json \
    --region=us-west-2

echo ""
echo "Waiting network stack creation"
echo ""

aws cloudformation wait stack-create-complete \
    --stack-name $NETWORK_STACK_NAME

echo "Creating servers stack"

aws cloudformation create-stack \
    --stack-name $SERVERS_STACK_NAME \
    --on-failure DELETE \
    --template-body file://./jenkins-servers.yml \
    --parameters file://./parameters/jenkins-servers.json \
    --region=us-west-2 \
    --capabilities CAPABILITY_NAMED_IAM

echo ""
echo "Waiting servers stack creation"
echo ""

aws cloudformation wait stack-create-complete \
    --stack-name $SERVERS_STACK_NAME

echo "Jenkins stacks finished"
echo ""
