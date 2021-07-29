# powershell for azure sql server database

# it needs Az, AzureRM module installed locally

#connect to your azure
Connect-AzAccount 
# new browser will pop up


# create azure sql server on azure VM

$rgname = 'rg-test'
$location = 'East US'
$storagename = 'pkuazstorage'
$cred = Get-Credential -Message "Type name and password of local admin acc"

New-AzResourceGroup -name $rgname -location $location 

#create storage
New-AzStorageAccount -ResourceGroupName $rgname -Name $storagename -Location $location -Type Standard_LRS


#create azure sql db===================

$server = 'pkazsqlserver0'
$dbname = 'mydb01'
$localIp = (Invoke-webrequest -uri https://api.ipify.org).content.trim()

#create sql server
New-AzSqlServer -ResourceGroupName $rgname -Location $location -ServerName $server -SqlAdministratorCredentials $cred 

#create server firewall
New-AzSqlServerFirewallRule -ResourceGroupName $rgname -ServerName $server -AllowAllAzureIps
New-AzSqlServerFirewallRule -ResourceGroupName $rgname -ServerName $server -FirewallRuleName "mylocal" -StartIpAddress $localIp -EndIpAddress $localIp

#Create database
New-AzSqlDatabase -ResourceGroupName $rgname -ServerName $server -Edition Standard -DatabaseName $dbname -RequestedServiceObjectiveName 'S0'


# # open the smss studio by cmd
# $cmd = "SQL Server Management Studio -S '$server.database.windows.net' -d 'master' -U '$($cred.username)' -nosplash"
# invoke-Expression $cmd




