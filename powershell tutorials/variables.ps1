# everything in ps is a object
# '$' variable start with this, $var

<#
Objects are more than just data
- Properties - attributes of the object
- method - functions that can be used by the object

#>

$string="this is a variable"
$string

# find out all the members of this string
$string | Get-Member

$datetime = Get-Date
$datetime
$datetime | gm
$datetime.Day
$datetime.DayOfWeek
$datetime.DayOfYear
$datetime.ToUniversalTime()

#files
$file = New-Item -ItemType File -Path 'D:\Downloads\junkfile.txt'
$file | gm
$file.Name
$file.FullName
$file.Extension
$file.CreationTime
$file.LastWriteTime
$file.Exists


# Pipelines=========================

[string]$String = 'Earl Grey, hot'
$string | gm


# use the pipeline to write the file out 
New-Item -ItemType Directory -path "D:\Downloads\Test"
'The quick i have the quickly i can' | Out-File -FilePath "D:\Downloads\Test\dummy.txt"
notepad "D:\Downloads\Test\dummy.txt"


# we can also use it for removing things
New-item -ItemType File -path "D:\Downloads\Test\dummy1.txt"
New-item -ItemType File -path "D:\Downloads\Test\dummy2.txt"
New-item -ItemType File -path "D:\Downloads\Test\dummy3.txt"

# to remove all files from a folder
dir D:\Downloads\Test | Remove-Item



