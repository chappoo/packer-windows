$ErrorActionPreference = "Stop"

Write-BoxstarterMessage "Copying auto unattend file"
mkdir C:\Windows\Panther\Unattend
copy-item a:\postunattend.xml C:\Windows\Panther\Unattend\unattend.xml

Write-BoxstarterMessage "Recreate pagefile after sysprep"
$System = GWMI Win32_ComputerSystem -EnableAllPrivileges
if ($system -ne $null) {
  $System.AutomaticManagedPagefile = $true
  $System.Put()
}

if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Post-compact complete"
