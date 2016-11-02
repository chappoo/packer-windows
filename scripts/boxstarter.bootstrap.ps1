$WinlogonPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
Remove-ItemProperty -Path $WinlogonPath -Name AutoAdminLogon
Remove-ItemProperty -Path $WinlogonPath -Name DefaultUserName

# $env:chocolateyVersion = '0.9.10.3'

iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mwrock/boxstarter/master/BuildScripts/bootstrapper.ps1'))
Get-Boxstarter -Force

Import-Module $env:appdata\boxstarter\boxstarter.chocolatey\boxstarter.chocolatey.psd1

New-PackageFromScript a:\boxstarter.0.windowsupdate.ps1 boxstarter.0.windowsupdate
New-PackageFromScript a:\boxstarter.1.virtualtools.ps1 boxstarter.1.virtualtools
New-PackageFromScript a:\boxstarter.2.customise.ps1 boxstarter.2.customise
New-PackageFromScript a:\boxstarter.0.windowsupdate.ps1 boxstarter.3.windowsupdate
New-PackageFromScript a:\boxstarter.5.optimise.ps1 boxstarter.5.optimise
New-PackageFromScript a:\boxstarter.6.compact.ps1 boxstarter.6.compact
New-PackageFromScript a:\boxstarter.7.compact.ps1 boxstarter.7.compact
New-PackageFromScript a:\boxstarter.8.compact.ps1 boxstarter.8.compact
New-PackageFromScript a:\boxstarter.9.winrm.ps1 boxstarter.9.winrm

$secpasswd = ConvertTo-SecureString "vagrant" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("vagrant", $secpasswd)

$manifest = @(
    "boxstarter.0.windowsupdate",
    "boxstarter.1.virtualtools",
    "boxstarter.2.customise",
    "boxstarter.3.windowsupdate",
    "boxstarter.5.optimise",
    "boxstarter.6.compact",
    "boxstarter.7.compact",
    "boxstarter.8.compact",
    "boxstarter.9.winrm"
)

Install-BoxstarterPackage -PackageName $manifest -Credential $cred
