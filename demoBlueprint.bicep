targetScope = 'subscription'

//Create a resource group
resource demoRG 'Microsoft.Resources/resourceGroups@2021-04-01' = {
  name: 'demo-rg'
  location: 'East US'
}

// Create the variables which hold the names of the resources which the blueprint creates.
var storageAccName = 'demostorageaccbparm1'
var vnetName = 'demo-vnet1'
var subnet1Name = 'demo-subnet1'
var subnet2Name = 'demo-subnet2'
var vmName1 = 'ubuntuVM1'
var vmName2 = 'ubuntuVM2'
var vmName3 = 'ubuntuVM3'


// Create the storage account using its ARM-Template
module storageAccount 'demoARMTemplateStorageAcc.json' = {
  name: 'storageAcc'
  scope: demoRG
  params:{
    storageName: storageAccName
    storageSKU: 'Standard_LRS'
  }
} 

// Set an allowed locations policy
// module locationPolicyApply 'demoARMTemplateLocationPolicy.json' = {
//   name: 'LocationPolicy'
//   scope: demoRG
//   params:{
//     policyID: tenantResourceId('microsoft.authorization/policyDefinitions', 'e56962a6-4747-49cd-b67b-bf8b01975c4c')
//     policyName: 'Allowed Locations Policy'
//   }
// }

// Create the vnet using its ARM-Template
module vNet 'demoARMTemplateVNet.json' = {
  name: 'vNet'
  scope: demoRG
  params:{
    VNetName: vnetName
    Subnet1Name: subnet1Name
    Subnet2Name: subnet2Name
  }
}

// Create the first VM using its ARM-Template and place it in the first subnet
module vm1 'demoARMTemplateVM.json' = {
  name: vmName1
  scope: demoRG
  params:{
    VM_Name: vmName1
    storageName: storageAccName
    VNetName: vnetName
    SubnetName: subnet1Name
  }
  dependsOn: [storageAccount, vNet]
}

// Create the second VM using its ARM-Template and place it in the first subnet
module vm2 'demoARMTemplateVM.json' = {
  name: vmName2
  scope: demoRG
  params:{
    VM_Name: vmName2
    storageName: storageAccName
    VNetName: vnetName
    SubnetName: subnet1Name
  }
  dependsOn: [storageAccount, vNet]
}

// Create the third VM using its ARM-Template and place it in the second subnet
module vm3 'demoARMTemplateVM.json' = {
  name: vmName3
  scope: demoRG
  params:{
    VM_Name: vmName3
    storageName: storageAccName
    VNetName: vnetName
    SubnetName: subnet2Name
  }
  dependsOn: [storageAccount, vNet]
}

output subID string = subscription().id
