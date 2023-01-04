This repo contains files used for training how to use Azure ARM templates and blueprints and deploy resources with them.

There are 4 Json Arm-template files which do the following:
    - demoARMTemplateResGroup.json: Template for creating a resource group where all resources will be deployed
    - demoARMTemplateStorageAcc.json: Template for creating a storrage account resource.
    - demoARMTemplateVNet.json: Template for creating a virtual network which contains 2 subnets.
    - demoARMTemplateVM.json: Template for creating a VM and all its additional required resources such as network interface and public IP address.
    - demoARMTemplateLocationPolicy: Template for assigning an Allowed Locations policy to the resource group and all resources in it. 
        Unfortunately this policy template could not be tested, since my burner account does not have the permission to write policies and produces an error.
These arm template files can be used on their own to deploy the resources through the azure CLI, or with the blueprint file described below.


There is 1 bicep file which stores the blueprint code. It uses the ARM templates for the resources to do the following:
   1) Create a resource group. 
   2) Create a storrage account in the res group.
   3) Apply the allowed locations policy to the res group. As mentioned above this produces an error, hence for testing purposes the module is commented out.
   4) Create a Virtual network with 2 internal subnets.
   5) Create 3 Ubuntu VM-s, 2 of which are in one of the subnets and the third one is in the other subnet.