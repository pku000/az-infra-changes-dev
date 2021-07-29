<#

Powershell is case insensitive

comment based help
#>

function Verb-Noun {
    [CmdletBinding()]
    param (
        # 
        [parameter(ValueFromPipeline =$true)]
        [string]$MyString
        # [Parameter()][string]$MyInt
    )
    
    begin { "Begin $MyString"      
    }
    process {   "process $MyString"
    }
    end {   "end $MyString"
    }
}

