#powershell script for menageing updates in 720 network
$continue = 'y'
while ($continue -eq 'y') {
 
write-host "Welcome to the system update of 720 network tool

select:
1: export updates from online Wsus server to: (C:\wsus\export\)
2: import updates to offline Wsus server from: (C:\wsus\export\)
3: start a manual Synchronization in the online server
4: add new server to OU in the offline server
5: report of update status in the last 30 days
" -BackgroundColor Cyan -ForegroundColor Black


        
$selection = Read-Host "enter the disarable commamd" 

Switch ($selection){

1 {&"C:\Program Files\Update Services\Tools\wsusutil.exe" export C:\wsus\export\export_updates.cab C:\wsus\export\export_updates.log}

2 {&"C:\Program Files\Update Services\Tools\wsusutil.exe" import C:\wsus\export\export_updates.cab C:\wsus\export\export_updates.log} 

3 {$wsus.GetSubscription().StartSynchronization();}

4 { $newlocation = Read-Host "enter server identity"
    Move-ADObject -Identity $newlocation -TargetPath "OU=Managed,DC=Fabrikam,DC=Com"}

5 { Get-HotFix | Where-Object { $_.InstalledOn -gt ((Get-Date).AddDays(-30)) } |
    Select-Object -Property PSComputerName, Description, InstalledOn | Format-Table -AutoSize  }

default {Write-Host ":( error is:"} 

}
$continue = Read-Host "Continue? y/n"}

if ($continue -eq 'n') {
    write-host "thanks for using the system update of 720 network tool" -BackgroundColor Cyan -ForegroundColor Black
}