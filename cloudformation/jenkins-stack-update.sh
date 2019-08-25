#!/bin/bash

NETWORK_STACK_NAME="$1-network"
SERVERS_STACK_NAME="$1-servers"

echo "Updating network stack"

aws cloudformation update-stack \
    --stack-name $NETWORK_STACK_NAME \
    --template-body file://./jenkins-network.yml \
    --parameters file://./parameters/jenkins-network.json \
    --region=us-west-2

echo ""
echo "Waiting network stack update"
echo ""

# aws cloudformation wait stack-update-complete \
    # --stack-name $NETWORK_STACK_NAME

echo "Updating servers stack"

aws cloudformation update-stack \
    --stack-name $SERVERS_STACK_NAME \
    --template-body file://./jenkins-servers.yml \
    --parameters file://./parameters/jenkins-servers.json \
    --region=us-west-2 \
    --capabilities CAPABILITY_NAMED_IAM

echo ""
echo "Waiting servers stack update"
echo ""

# aws cloudformation wait stack-update-complete \
    # --stack-name $SERVERS_STACK_NAME

echo "Jenkins stacks finished"
echo ""
