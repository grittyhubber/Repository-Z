#Set-ExecutionPolicy unrestricted
#Set-ExecutionPolicy -Scope Process -ExecutionPolicy Bypass -Force
get-pssnapin citrix* -ErrorAction SilentlyContinue | add-pssnapin citrix* -ErrorAction SilentlyContinue | Out-Null
Add-PSSnapin Citrix.*.Admin.V* -PassThru -ErrorAction SilentlyContinue | Out-Null
#-------------------------------------------------------------------------------------------------------------------------------------------------

# Custom variables.
$servernamefile = get-content .\Server-List-Group1.txt
$maintmode = $True
# Custom variables.

$printrecord = "MachineName" + "`t`t" + "InMaintenanceMode"
Write-Host $printrecord
$printrecord = "------------------" + "`t" + "------------------" + "`r`n"
Write-Host $printrecord

foreach ($servernamerec in $servernamefile) 
{
#write-host "SeverName: " $servernamerec

Set-BrokerMachineMaintenanceMode -InputObject datacenter\$servernamerec -MaintenanceMode $maintmode

$serverstatus = get-brokermachine -machinename "datacenter\$servernamerec" | Select MachineName, InMaintenanceMode

$printrecord = ($serverstatus.MachineName | ForEach-Object {$_ -Replace "datacenter\\",""}) + "`t`t" + $serverstatus.InMaintenanceMode
Write-Host $printrecord

}

$printrecord = "`r`n"
Write-Host $printrecord

Read-Host "End of Script."
