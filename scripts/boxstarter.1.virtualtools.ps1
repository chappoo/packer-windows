$ErrorActionPreference = "Stop"

Write-BoxstarterMessage "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"
Write-BoxstarterMessage "TODO: Make this script independent of virtualisation platform"
Write-BoxstarterMessage ("      Packer build type : {0}" -f @($env:PACKER_BUILDER_TYPE))
Write-BoxstarterMessage "~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~~"

if (-not (Test-Path -Path "C:\Windows\Temp\windows.iso"))
{
    Write-BoxstarterMessage "Downloading VMware Tools"
    (New-Object System.Net.WebClient).DownloadFile("https://softwareupdate.vmware.com/cds/vmw-desktop/fusion/8.5.1/4543325/packages/com.vmware.fusion.tools.windows.zip.tar", "C:\Windows\Temp\com.vmware.fusion.tools.windows.zip.tar")
    Write-BoxstarterMessage "Extracting VMware Tools"
    &C:\ProgramData\Chocolatey\tools\7z.exe x "C:\Windows\Temp\com.vmware.fusion.tools.windows.zip.tar" -oC:\Windows\Temp\VMWare -aoa | Out-Host
    &C:\ProgramData\Chocolatey\tools\7z.exe x "C:\Windows\Temp\VMWare\com.vmware.fusion.tools.windows.zip" -oC:\Windows\Temp\VMWare -aoa | Out-Host
    Get-ChildItem -Filter "windows.iso" -Recurse -Path "C:\Windows\Temp\VMWare" | Move-Item -Destination C:\Windows\Temp\windows.iso -Force
    &C:\ProgramData\Chocolatey\tools\7z.exe x "C:\Windows\Temp\windows.iso" -oC:\Windows\Temp\VMWare -aoa | Out-Host
}

Write-BoxstarterMessage "Installing VMware Tools"
&C:\Windows\Temp\VMWare\setup.exe /S /v`"/qn REBOOT=R`" | Out-Host

if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Finished with VMware Tools"
