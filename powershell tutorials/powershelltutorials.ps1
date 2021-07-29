
#assign a variables
$MyVar = 3
$myVariables = "HelloWorld"

# output variables
Write-Host $MyVar  + $myVariables -backgroundColor "Cyan"


#strongly type a variable
[string]$myName="Prabhat"
[int]$age=18
#[string]$computerName=Read-Host "Enter Computer Name"
#Write-Host $myName " " $age "" $computerName

[string]$date = "2021/12/22"
$date.Replace("/","-")

[datetime]$datetime="2021/12/22"
$datetime.DayOfWeek
$datetime.Add(-10)

# Quotion Marks=================================

# Double quotes resolve/evaluates the variables
$i="PowerShell"

"This is the variable $i, and $i Rocks!!"
'This is the variable $i, and $i Rocks!!' # single quotes dont resolved
"This is the variable `$i, and $i Rocks!!"

$p = Get-Process lsass
#"Process id = $p.id"
"Process Id= $($p.Id)" # $() evaluates anything in the parenthesis

#"Process Id= $(Read-Host -Prompt "Whats the number?")"




# ObjectMembers ================================

#variables are very flexible
$service=Get-Service -Name BITS
$service | GM
$service.Status
#$service.start()
$msg="Service Name $($service.Name.ToUpper())" 
$msg

## multiple objects==============
$service=Get-Service
$service[0]
$service[0].Status
$service[0].DisplayName

"Service Name is $($service[1].DisplayName)"
"Service Name is $($service[2].Name.ToUpper())"

# ranges
$service.Count 
$service[1..5] # ascending order
$service[5..1] # descending order


#Parenthesis ===================================
#Create a txt and csv files
'DC','Client' | Out-File D:\Documents\Test\computers.txt
"ComputerName,IPAddress" | Out-File D:\Documents\Test\computers.csv
"DDC,1.2.3.4.5" | Out-File D:\Documents\Test\computers.csv -Append

#Getting names from a text file
#Get-Service -name Bits (Get-Content D:\Documents\Test\computers.txt)

#Get-Service -ComputerName (Import-Csv computers.csv | Select -ExpandProperty ComputerName)

#Get-Service -ComputerName (Import-Csv computers.csv).$computerName


# if statement=========================================================

if ($this -eq $that) {
    #comments
} elseif ($those -ne $them) {
    #comments
} elseif ($we -gt $they) {
    #comment
}else {
    #final commets
}

$status = (Get-Service -Name BITS).Status
if ($status -eq "Running") {
    Clear-Host
    Write-Host "Service is running!"
    
} else {
    Clear-Host
    Write-Host "Service is already stopped"
    $status
}

# another example
$x = if ($false) {1 
} else {2}
$x




# Switch ================================
# switch sometimes easier than if to maintain
$status = 3

Switch ($status) {
    0 {$status_text = 'OK'}
    1 {$status_text = 'error'}
    2 {$status_text = 'jammed'}
    3 {$status_text = 'overheated'}
    4 {$status_text = 'empty'}
    default {$status_text = 'Unknown'}
}
$status_text

# another way to write the above

$status_text = switch ($status) {
    0 { "Ok" }
    1 { "error" }
    2 { "jammed" }
    3 { "overheated" }
    Default {"unknown"}
}
$status_text


# Loops===========================================
#Do and while

$i =1
do {
    Write-Host "PowerShell is great! $i"
  #  $i = $i+1 
    $i++ #shorter way to write 
} while ($i -le 5)
;

# while loop
$i=5
while ($i -ge 1) {
    Write-Host "PowerShell is great! $i"
    $i--
}

# foreach loop=============
# Foreach - to iterate all the items in the list
# Do and While loop you should know how many times you want to iterate through

$services = Get-Service -Name B*
foreach ($service in $services) {
   Write-Host $service.Status , $service.DisplayName   
}

$services = Get-Service -Name B*
foreach ($s in $services) {
   Write-Host $s.Status , $s.DisplayName   
}


ForEach-Object -Process {
    start calc # opens the calculator
}

$services = Get-Service -Name B*
foreach ($s in $services) {
   Write-Host $s.Status , $s.DisplayName   
}


# ForEach-Object -Process {
#     start calc # opens the calculator
# }























