$ErrorActionPreference = "Stop"

Update-ExecutionPolicy -Policy Unrestricted

Install-WindowsUpdate -AcceptEula

if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Windows Updates finished"