$ErrorActionPreference = "Stop"

Write-BoxstarterMessage "Installing local packages"

Set-WindowsExplorerOptions -EnableShowHiddenFilesFoldersDrives -EnableShowProtectedOSFiles -EnableShowFileExtensions -EnableShowFullPathInTitleBar

choco install DotNet4.5 -y
# choco install DotNet3.5 -y
choco install IIS-WebServerRole -source windowsfeatures
choco install IIS-ISAPIFilter -source windowsfeatures
choco install IIS-ISAPIExtensions -source windowsfeatures
choco install NetFx4Extended-ASPNET45 -source windowsfeatures
choco install IIS-NetFxExtensibility45 -source windowsfeatures
choco install IIS-ASPNet45 -source windowsfeatures
choco install IIS-HttpCompressionDynamic -source windowsfeatures
choco install IIS-ManagementScriptingTools -source windowsfeatures
choco install IIS-WindowsAuthentication -source windowsfeatures

# Write-BoxstarterMessage "Installing Client SDKs"
# choco install awstools.powershell -y
# choco install windowsazurepowershell -y

# Write-BoxstarterMessage "Installing dev tools"
# choco install webpi -y
# choco install visualstudio2015community -y
choco install visualstudiocode -y
# choco install mssqlservermanagementstudio2014express -y
# choco install resharper -y
# choco install fiddler4 -y
# choco install 7zip -y
# choco install conemu -y
# choco install git -y
# choco install gitkraken -y
# choco install sourcetree -y
# choco install putty -y
# choco install SublimeText3 -y
# choco install google-chrome-x64 -y
# choco install firefox -y
# choco install dotpeek -y
# choco install lastpass -y
# choco install NuGet.CommandLine -y
# choco install slack -y
# choco install teamviewer -y
# choco install royalts -y
# choco install dropbox -y
# choco install linqpad -y

Write-BoxstarterMessage "Enabling HTTP firewall rules"
netsh advfirewall firewall add rule name="Open Port 80" dir=in action=allow protocol=TCP localport=80

Write-BoxstarterMessage "Enabling file sharing firewall rules"
netsh advfirewall firewall set rule group="File and Printer Sharing" new enable=yes
