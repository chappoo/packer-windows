$WinlogonPath = "HKLM:\Software\Microsoft\Windows NT\CurrentVersion\Winlogon"
Remove-ItemProperty -Path $WinlogonPath -Name AutoAdminLogon
Remove-ItemProperty -Path $WinlogonPath -Name DefaultUserName

$env:chocolateyVersion = '0.9.10.3'

iex ((new-object net.webclient).DownloadString('https://raw.githubusercontent.com/mwrock/boxstarter/master/BuildScripts/bootstrapper.ps1'))
Get-Boxstarter -Force

$secpasswd = ConvertTo-SecureString "vagrant" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("vagrant", $secpasswd)

Import-Module $env:appdata\boxstarter\boxstarter.chocolatey\boxstarter.chocolatey.psd1

New-PackageFromScript a:\boxstarter.package.0.ps1 WindowsUpdate
New-PackageFromScript a:\boxstarter.package.1.ps1 WinRM-LetPackerGoDoItsThang
New-PackageFromScript a:\boxstarter.package.2.ps1 InstallYoShnizzle

New-PackageFromScript a:\vm-guest-tools.ps1 vm-guest-tools
New-PackageFromScript a:\compile-dotnet-assemblies.ps1 compile-dotnet-assemblies
New-PackageFromScript a:\pre-compact.ps1 pre-compact
New-PackageFromScript a:\compact.ps1 compact
New-PackageFromScript a:\post-compact.ps1 post-compact

Install-BoxstarterPackage -PackageName "WindowsUpdate","InstallYoShnizzle","vm-guest-tools","compile-dotnet-assemblies","pre-compact","compact","post-compact","WinRM-LetPackerGoDoItsThang" -Credential $cred
