#!/bin/bash

STACK_NAME="$1-website"

echo "Creating website stack"

aws cloudformation create-stack \
    --stack-name $STACK_NAME \
    --on-failure DELETE \
    --template-body file://./website.yml \
    --region=us-west-2

echo ""
echo "Waiting website stack creation"
echo ""
echo "Website stack finished"
echo ""
