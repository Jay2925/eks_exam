#!/bin/bash

# Set your region and EKS cluster name
REGION="us-east-1"
CLUSTER_NAME="exam_eks"

# Update kubeconfig to access the cluster
aws eks --region "$REGION" update-kubeconfig --name "$CLUSTER_NAME" >/dev/null

# Header
echo -e "NodeName\tStatus\tAMI Age (Days)"

# Get list of nodes
kubectl get nodes --no-headers | awk '{print $1}' | while read NODE; do
    # Get node status
    STATUS=$(kubectl get node "$NODE" -o jsonpath='{.status.conditions[?(@.type=="Ready")].status}')
    STATUS_TXT="Ready"
    if [[ "$STATUS" != "True" ]]; then
        STATUS_TXT="NotReady"
    fi

    # Get EC2 Instance ID associated with the node
    INSTANCE_ID=$(kubectl get node "$NODE" -o jsonpath='{.spec.providerID}' | cut -d'/' -f5)

    # Get Image ID (AMI) used by the instance
    IMAGE_ID=$(aws ec2 describe-instances --instance-ids "$INSTANCE_ID" --region "$REGION" \
        --query "Reservations[0].Instances[0].ImageId" --output text)

    # Get AMI creation date
    AMI_DATE=$(aws ec2 describe-images --image-ids "$IMAGE_ID" --region "$REGION" \
        --query "Images[0].CreationDate" --output text)

    # Calculate AMI age in days
    AMI_DATE_EPOCH=$(date -d "$AMI_DATE" +%s)
    NOW_EPOCH=$(date +%s)
    AGE_DAYS=$(( (NOW_EPOCH - AMI_DATE_EPOCH) / 86400 ))

    # Output the report line
    echo -e "$NODE\t$STATUS_TXT\t$AGE_DAYS"
done
