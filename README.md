Things to create:

### Resource group
Name should be an input in the pipeline
Location should be an input in the pipeline

### Virtual network
Name is an input in the pipeline
Location should be the same as the resource group
IP Range should be an input in the pipeline

### Virtual Machine
Ubuntu 20.04
hostname is an input in the pipeline
Kernel version must be supported by Azure Site Recovery
Use SSH key for authentication as the admin account
1OS disk, 30GB
1 data disk, 500 GB

When commits are made to the main branch in your repository, a pipeline job should be run to lint the terraform code.
A separate pipeline should be used to run the resource deployment. The pipeline should take the inputs described above. It should use the Azure Dev/Test environment for release audit tracking.