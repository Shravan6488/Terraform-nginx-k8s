## Prerequisites
- Terraform veriosn > 0.11
- git
- kubectl sdks if using google cloud console



## Quick start
**Prerequisite:** make sure you're authenticated to GCP via [gcloud](https://cloud.google.com/sdk/gcloud/) command line tool using either _default application credentials_ or _service account_ with proper access.

** How to runt the code
 git clone https://github.com/Shravan6488/Terraform-nginx-k8s.git
 
 * cd Terraform-nginx-k8s
 * cd my-cluster
 
 - provide your #######cluster name and your ######projectid and #######region in terraform.tfvars file .
 * and also edit dns.tf file
 ``` change the dns name in dns_name attribute
 cd deploy-app-example
 ``` change in nginx-example.yml also replace your dns name which you mentioned previous.
 

Once the required variables are defined, use the commands below to create a Kubernetes cluster:
```bash
$ terraform init
$ terraform apply
```

After the cluster is created, run a command from terraform output to configure access to the cluster via `kubectl` command line tool. The command from terraform output will be in the form of:

```bash
$ gcloud container clusters get-credentials my-cluster --zone europe-west1-b --project example-123456 (change example-123456 to your project)
```


## Repository structure
```bash

├── my-cluster
│   ├── deploy-app-example
│   └── k8s-config
│       ├── env-namespaces
│       └── storage-classes  
|
└── terraform-modules
    ├── cluster
    ├── firewall
    │   └── ingress-allow
    ├── node-pool
    └── vpc
```

### terraform-modules
The folder contains reusable pieces of terraform code which help us manage our configuration more efficiently by avoiding code repetition and reducing the volume of configuration.

The folder contains 4 modules at the moment of writing:

* `cluster` module allows to create new Kubernetes clusters.
* `firewall/ingress-allow` module allows to create firewall rules to filter incoming traffic.
* `node-pool` module is used to create [Node Pools](https://cloud.google.com/kubernetes-engine/docs/concepts/node-pools) which is mechanism to add extra nodes of required configuration to a running Kubernetes cluster. Note that nodes which configuration is specified in the `cluster` module become the _default_ node pool.  
* `vpc` module is used to create new Virtual Private Cloud (VPC) networks.

### my-cluster
Inside the **my-cluster** folder, I put terraform configuration for the creation and management of an example of Kubernetes cluster.

* `deploy-app-example` has an bunch of Kubernetes objects definitions which are used to deploy nginx to a Kubernetes cluster. You can use the command below to deploy nginx to the cluster once it is created:
	```bash
	$ kubectl apply -f ./deploy-app-example/nginx-example.yml
	```
## To deploy new version

* create new/edit  terraform.tfvars /terraform1.tfvars(if create new) change the cluster name.
* and run kubectl apply -f ./deploy-app-example/nginx-example2.yml (nginx-example2 not in code you can create one)
- Repeat the previous steps again.

## dns switch 
-Two ways can do
* Manually ( which i have done through console)
* Using terraform 
