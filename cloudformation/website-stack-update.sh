#!/bin/bash

STACK_NAME="$1-website"

echo "Updating website stack"

aws cloudformation update-stack \
    --stack-name $STACK_NAME \
    --template-body file://./website.yml \
    --region=us-west-2

echo ""
echo "Waiting website stack update"
echo ""
echo "Website stack finished"
echo ""
