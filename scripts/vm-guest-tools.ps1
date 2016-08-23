Write-BoxstarterMessage "Downloading VMware Tools"
(New-Object System.Net.WebClient).DownloadFile("http://softwareupdate.vmware.com/cds/vmw-desktop/ws/12.0.0/2985596/windows/packages/tools-windows.tar", "C:\Windows\Temp\vmware-tools.tar")

Write-BoxstarterMessage "Extracting VMware Tools"
&C:\ProgramData\Chocolatey\tools\7z.exe x "C:\Windows\Temp\vmware-tools.tar" -oC:\Windows\Temp\VMWare -aoa | Out-Host
Get-ChildItem -Filter "VMware-tools-windows-*.iso" -Path "C:\Windows\Temp\VMWare" | Move-Item -Destination C:\Windows\Temp\VMWare\windows.iso -Force
&C:\ProgramData\Chocolatey\tools\7z.exe x "C:\Windows\Temp\VMWare\windows.iso" -oC:\Windows\Temp\VMWare -aoa | Out-Host

Write-BoxstarterMessage "Installing VMware Tools"
&C:\Windows\Temp\VMWare\setup.exe /S /v`"/qn REBOOT=R`" | Out-Host

Write-BoxstarterMessage "Finished with VMware Tools"
exit 0