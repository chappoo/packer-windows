$ErrorActionPreference = "Stop"

if (Test-Path -Path "$env:windir\microsoft.net\framework\v4.0.30319\ngen.exe")
{
	Write-BoxstarterMessage "Running ngen for framework..."
	Start-Process -FilePath "$env:windir\microsoft.net\framework\v4.0.30319\ngen.exe" -ArgumentList "update /force /queue" -Wait
	Start-Process -FilePath "$env:windir\microsoft.net\framework\v4.0.30319\ngen.exe" -ArgumentList "executequeueditems" -Wait
}

if (Test-Path -Path "$env:windir\microsoft.net\framework64\v4.0.30319\ngen.exe")
{
	Write-BoxstarterMessage "Running ngen for framework64..."
	Start-Process -FilePath "$env:windir\microsoft.net\framework64\v4.0.30319\ngen.exe" -ArgumentList "update /force /queue" -Wait
	Start-Process -FilePath "$env:windir\microsoft.net\framework64\v4.0.30319\ngen.exe" -ArgumentList "executequeueditems" -Wait
}

if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Optimisation complete"
