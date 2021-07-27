<#
when you want to deploy the infra
uncomment below code
and set up correct param file in templateparam
#>

#Connect-AzAccount

#New-AzResourceGroup -Name myResourceGroup -Location "uksouth"

$templateFile = "D:\Documents\Tutorials\azuredeploy.json"
#$TemplateParameterFile = "D:\Documents\Tutorials\azuredeploy-parameters-dev.json"
$TemplateParameterFile = "D:\Documents\Tutorials\azuredeploy-parameters-prod.json"


New-AzResourceGroupDeployment -Name addstags `
    -ResourceGroupName myResourceGroup `
    -TemplateFile $templateFile `
    -storagePrefix "pkudev" `
    -storageSKU Standard_LRS `
    -TemplateParameterFile $TemplateParameterFile
    
    
    


