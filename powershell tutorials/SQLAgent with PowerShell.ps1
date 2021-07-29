#SQL Agent job example

#backup job

$dbs = Invoke-sqlcmd -ServerInstance localhost -Database tempdb -Query "SELECT name from SYS.databases WHERE recovery_model_desc = 'SIMPLE' AND NAME NOT IN ('DWDiagnostics','DWConfiguration','DWQueue')"

$dbs.name


$datestring = Get-Date -Format "yyyyMMddHHmm"
$datestring


#loop through the dbs
foreach ($db in $dbs.name) {
 
    $dir = "D:\Documents\Test\Backup\$db"
    # check if backup already exists?,if not create one
    if(!(test-path $dir )) {new-Item -ItemType Directory -path $dir }

    #get a name and backup of db
    $filename = "$db-$datestring.bak"
    $backup = join-path -Path $dir -ChildPath $filename
    Backup-sqldatabase -ServerInstance localhost -Database $db -BackupFile $backup -compressionOption On -CopyOnly 
    #delete old backups
    # Get-ChildItem $dir\*.bak | where {$_.LastWriteTime -lt (Get-Date).addminutes(-1) } | Remove-Item 
}


<#
use above script in the management studio
- create the sql agent job
- copy and paste the above code - command ps
- set up the agent job
- run the job

#>



# restore database=========================================
#create a point in time restore

$db = 'AdventureWorks2019'
$lastFull = Get-ChildItem 'D:\Documents\Test\Backup\$db\*.bak' | Sort-Object LastWriteTime -Descending | Select-Object -First 1
$logs = Get-ChildItem 'D:\Documents\Test\Backup\$db\*.trn' | Where-Object {$_.LastWriteTime -gt $lastFull } | Sort-Object LastWriteTime

Restore-sqlDatabase -ServerInstance 'localhost' -Database $db -BackupFile $lastFull.FullName -RestoreAction Database -NoRecovery


