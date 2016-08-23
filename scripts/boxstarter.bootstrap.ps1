$secpasswd = ConvertTo-SecureString "vagrant" -AsPlainText -Force
$cred = New-Object System.Management.Automation.PSCredential ("vagrant", $secpasswd)

Import-Module $env:appdata\boxstarter\boxstarter.chocolatey\boxstarter.chocolatey.psd1

$scriptPath = "a:\{0}" -f @($env:BOXSTARTER_SCRIPTPATH)

Install-BoxstarterPackage -PackageName $scriptPath -Credential $cred -DisableReboots