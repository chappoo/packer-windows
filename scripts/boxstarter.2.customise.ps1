$ErrorActionPreference = "Stop"

Disable-InternetExplorerESC
Disable-MicrosoftUpdate
Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar

try
{
    Write-BoxstarterMessage "Set power plan to high performance"
    $HighPerf = powercfg -l | %{if($_.contains("High performance")) {$_.split()[3]}}
    $CurrPlan = $(powercfg -getactivescheme).split()[3]
    if ($CurrPlan -ne $HighPerf) {powercfg -setactive $HighPerf}
}
catch
{
    Write-BoxstarterMessage "Unable to set power plan to high performance"
}

Write-BoxstarterMessage "Installing windows features"
choco install DotNet4.5 -y --ignore-checksums
choco install DotNet3.5 -y --ignore-checksums
choco install IIS-WebServerRole -source windowsfeatures
choco install IIS-ISAPIFilter -source windowsfeatures
choco install IIS-ISAPIExtensions -source windowsfeatures
choco install NetFx4Extended-ASPNET45 -source windowsfeatures
choco install IIS-NetFxExtensibility45 -source windowsfeatures
choco install IIS-ASPNet45 -source windowsfeatures
choco install IIS-HttpCompressionDynamic -source windowsfeatures
choco install IIS-ManagementScriptingTools -source windowsfeatures
choco install IIS-WindowsAuthentication -source windowsfeatures

Write-BoxstarterMessage "Installing dev tools"
#choco install visualstudio2015community -y --ignore-checksums
choco install visualstudiocode -y --ignore-checksums
#choco install mssqlserver2014express -y --ignore-checksums
#choco install mssqlservermanagementstudio2014express -y --ignore-checksums
choco install webpi -y --ignore-checksums
choco install resharper -y --ignore-checksums
choco install fiddler4 -y --ignore-checksums
choco install 7zip -y --ignore-checksums
choco install conemu -y --ignore-checksums
choco install git -y --ignore-checksums
choco install gitkraken -y --ignore-checksums
#choco install sourcetree -y --ignore-checksums
choco install putty -y --ignore-checksums
choco install SublimeText3 -y --ignore-checksums
choco install google-chrome-x64 -y --ignore-checksums
#choco install firefox -y --ignore-checksums
choco install dotpeek -y --ignore-checksums
#choco install lastpass -y --ignore-checksums
choco install NuGet.CommandLine -y --ignore-checksums
#choco install slack -y --ignore-checksums
#choco install teamviewer -y --ignore-checksums
#choco install royalts -y --ignore-checksums
#choco install dropbox -y --ignore-checksums
choco install linqpad -y --ignore-checksums

if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Installing WMF 5.0"
choco install powershell -y --ignore-checksums

if(Test-PendingReboot){ Invoke-Reboot }

choco install awstools.powershell -y --ignore-checksums

if(Test-PendingReboot){ Invoke-Reboot }

#choco install windowsazurepowershell -y --ignore-checksums
#if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Enabling HTTP firewall rules"
netsh advfirewall firewall add rule name="Open Port 80" dir=in action=allow protocol=TCP localport=80

Write-BoxstarterMessage "Enabling file sharing firewall rules"
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=yes

Write-BoxstarterMessage "Enabling remote desktop"
Enable-RemoteDesktop

if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Customisation complete"
