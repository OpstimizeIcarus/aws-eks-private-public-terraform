# AWS-EKS-Private-Public-without-NAT-gateway-using-Terraform
This repo includes the end-to-end terraform code to create the AWS EKS cluster with **Cluster endpoint access = Public + Private** by deploying the the Worker Nodes in **PRIVATE Subnet WITHOUT NAT GATEWAY**👀.  
This is AWS recommended configuration which be will mostly used accross the many organization as it comes with following benifits.  

* 🚀 Worker node traffic to the endpoint will stay within your VPC(less latency + increased security).  
* 🚀 Application running in worker node can communicate to external aws services using vpc-private-endpoints(less latency + increased security).  
* 🚀 The cluster endpoint is accessible from outside of your VPC(we don't have to be inside vpc to connect to cluster. For example, kubectl commands can be executed outside the vpc to communicate to eks cluster provided required IAM roles present).  

## 📌 Resources list
* 1️⃣ Virtual Private Cloud (VPC)
* 2️⃣ Two Private subnet(without nat gateway) with individual route tables (we will create new route tables for each subnet).
* 3️⃣ VPC endpoints for ec2,eks,ecr,ecr-dkr,s3(gateway).
* 4️⃣ One Security group for VPC endpoints with 1 inbound rule for **port-443 to allow traffic within VPC**(we can even restrict to only subnets where eks workernodes will be deployed).
* 5️⃣ EKS cluster with **public and private** API endpoint access.
* 6️⃣ EKS nodegroup.  

>[!NOTE]
>We will be choosing the same set of subnets while creating EKS cluster and while adding the nodegroup as well. However one can choose different set of subnets as well from what is being choosen during eks cluster creation and while adding the nodegroup

## 📌Resource provisioning through Terraform.

### Stack
* Terraform - v1.7.1
* aws-provider - v5.33.0
###  Usage
This repo contains the terraform code to provision the eks cluster with both private+public api endpoint access **without using the NAT gateway** by leveraging the **VPC endpoints.**  
This terraform code is fully modularized hence it can be easy for reusability/enhancement or one can update it according to his need with minimal change without breaking the code flow.

There are 2 tf modules.  

🎯**Network**  - vpc , subnets , vpc-endpoints , security group , route tables  
🎯**EKS**      - eks , iam roles for eks and worker nodes , node group  

Under the Root folder , we have our 
* **main.tf**
* **providers.tf** -> make sure to update the your aws profile and region
* **inputs-Parameters.tf.json** -> file where we provide the values to variables.  
kindly note that we have one variable called **proj** this value will be used for tagging/naming the resources accordingly.  
*example* : proj=dev, this would tag the resources like dev-eks,dev-vpc and etc..!

##### kindly refer the below table for inputs variable and their description

| Input  | Description | Type | Example |
| --- | --- | --- | --- |
| `proj` | name which will be used to tag/name the resources accordingly | string | `dev` 
| `eks_versions` | EKS version to use | string | `1.28`
| `vpc_cidr` | vpc cidr range | list(string) | `10.0.0.0\16` 
| `eks_subnet` | subents cidr range | list(string) |`"10.0.128.0/23","10.0.144.0/23"`
| `az` | AZ list where subnets will be deployed | list(string) |`"us-east-1a","us-east-1b"`
| `vpc_endpoints` | list of vpc endpoints required | list(string) | `"com.amazonaws.us-east-1.ec2","com.amazonaws.us-east-1.ecr.api"`

###  Execution
Once the inputs are updated in **inputs-Parameters.tf.json**, run the following commands in **Root** directory

✔ To initialize the terraform code.
```ruby
▶️ terraform init
```

✔ To check what are the resources tf is going to create as per configurations defined
```ruby
▶️ terraform plan
```

✔ To apply the above displayed plan,
```ruby
▶️ terraform apply
```

> [!TIP]
> Not familiar with Terraform ?🙄  
> :shipit:No worries. Have look at my 👀 [**MEDIUM**](https://medium.com/@opstimize.icarus/aws-eks-without-nat-gateway-5cbe577aa8ca) blog where I have listed down all the steps for creating this setup manually from AWS console



