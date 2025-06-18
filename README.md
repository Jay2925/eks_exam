Explain (1-2 sentences) how to run and test your solution: (readme)

get all code in your vs code 

change SSH key name and region you want to use 

hit terraform init , plan , apply 

then you can update kubeconfig file using below command 

aws eks --region us-east-1 update-kubeconfig --name exam_eks

////////////////////////////

Briefly describe how your script handles errors and missing nodes: (readme) 

The node_audit.sh script includes basic error handling to ensure it runs reliably even if some nodes or AWS resources are missing:

Node Availability:
The script uses kubectl get nodes to list all EKS worker nodes.

If no nodes are found, it simply skips the audit loop and outputs nothing.

Node Readiness Check:
For each node, it checks the Ready condition.

If a node is NotReady, it is clearly labeled in the output.

 EC2 Metadata Fetching:
If an EC2 instance ID or AMI ID is not found (due to API failure or node issues), the script may display an empty or "null" result for AMI age.

Errors in AWS CLI commands (e.g., permissions or expired tokens) will show command-line errors but won’t crash the script.

 Graceful Degradation:
If any part of the node-to-EC2 lookup fails, the script continues to audit remaining nodes without stopping entirely.
