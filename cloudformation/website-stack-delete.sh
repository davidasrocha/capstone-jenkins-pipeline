#!/bin/bash

STACK_NAME="$1-website"

echo "Deleting website stack"

aws cloudformation delete-stack \
    --stack-name $STACK_NAME \
    --region=us-west-2

echo ""
echo "Waiting website stack deletion"
echo ""
echo "Website stack finished"
echo ""
