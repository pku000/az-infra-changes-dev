#parameters =====================================


# choose values to replace the variables
param(
    [string]$computerName = 'localhost',
    [string]$Drive = 'C:'
)
Get-WmiObject -Class Win32_logicalDisk -Filter "DeviceID ='$Drive'" -ComputerName $computerName


# [CmdletBinding()] 
# # converts functions to cmd lets --set up the params
# # so when you start writing the cmd let they will come only from this function
# # checks if that funcs has these parameters in the funcs
# param (
#     [Parameter()]
#     [TypeName]
#     $ParameterName
# )


# function t {
#     param (
#         [string]$computerName='localhost'
#     )
    
#     function t {
#         Clear-Host
#         Write-Host "Hello function"
#     }
# }


function Get-Info {
    [CmdletBinding()]
    param (
        # Parameter help description
        [Parameter(Mandatory=$false)]
        [string]$ComputerName ='localhost'
    )
   Write-Host "hello", $ComputerName
    
}

# Advanced Functions============================

