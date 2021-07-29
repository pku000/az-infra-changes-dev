
#Import sql module

Import-Module SqlServer

Get-Command -Module SqlServer

# List all of your current provider
Get-PSDrive

#change to SQLServer provider
cd SQLSERVER:\
dir # find all the items in this dir

# browse sql sever
cd sql\SURFACEPRO7\
dir 

#lookup inside this dir
cd DEFAULT
dir 

# find the list of databases
dir databases | Format-Table -AutoSize

#everything is an object 
dir databases | gm

#get the list of dbs and their size
dir databases -Force | Select-object name,createDate, @{ name='DatasizeMB';expression={$_.dataspaceusage/1024} }


#get the table list of database
dir databases\AdventureWorks2019\Tables

#practical use
$instances = @('localhost')

$instances | foreach-object {Get-ChildItem "SQLSERVER:\SQL\$_\DEFAULT\Databases" -Force} |
    Sort-Object Size -Descending |
    Select-object @{n='server';e={$_.parent.name}},name,LastBackupDate,Size

$sqlcmd = @'
SELECT 
    sp.name,count(1) db_count
FROM sys.server_principals sp
join sys.databases d on sp.sid = d.owner_sid
group by sp.name
'@

$sqlout= Invoke-sqlcmd -Query $sqlcmd -ServerInstance SURFACEPRO7 -Database tempdb

    
$sqlout | GM

#doing some backukp

Backup-sqldatabase -ServerInstance SURFACEPRO7 -Database AdventureWorks2019 -BackupFile 'D:\Documents\Test\AdventureWorks2019.bak' -Initialize -CopyOnly # -Script    # this will show you the command, but will not execute


# run all our systemdb backup
cd C:\
$servers = @('SURFACEPRO7')

foreach ($S in $servers) {
    
    $dbs = dir SQLSERVER:\SQL\$s\DEFAULT\DATABASES -Force | Where-Object {$_.IsSystemObject -eq $true }
    $pathname = "D:\Documents\Test\Backup\"+$s.Replace('\','_')
    if(!(test-path $pathname)){New-Item $pathname -ItemType Directory }
    $dbs | ForEach-Object { Backup-sqldatabase -ServerInstance $s -Database $_.name -BackupFile $pathname }
}



#============SMO===============================================
# SQL SERVER MANAGMENT OBJECTS

#smo - create new instance of smo

$smoserver = new-object Microsoft.sqlserver.Management.smo.server SURFACEPRO7

$smoserver | GM

$smoserver.VersionString

#get dbs
$smoserver.databases

$sysjobs = $smoserver.databases["msdb"].Tables["sysjobs"]
$sysjobs|GM

$sysjobs.indexes

$sysjobs.script()
$sysjobs.logins













