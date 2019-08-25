#!/bin/bash

NETWORK_STACK_NAME="$1-network"
SERVERS_STACK_NAME="$1-servers"

echo "Deleting servers stack"

aws cloudformation delete-stack \
    --stack-name $SERVERS_STACK_NAME

echo ""
echo "Waiting servers stack deletion"
echo ""

aws cloudformation wait stack-delete-complete \
    --stack-name $SERVERS_STACK_NAME

echo "Deleting network stack"

aws cloudformation delete-stack \
    --stack-name $NETWORK_STACK_NAME

echo ""
echo "Waiting network stack deletion"
echo ""

aws cloudformation wait stack-delete-complete \
    --stack-name $NETWORK_STACK_NAME

echo "Jenkins stacks finished"
echo ""
