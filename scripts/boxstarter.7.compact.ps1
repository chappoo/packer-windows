$ErrorActionPreference = "Stop"

Write-BoxstarterMessage "Clearing out windows update downloads..."
Stop-Service -Name "wuauserv"
Remove-Item "C:\Windows\SoftwareDistribution\Download" -Recurse -Force
New-Item "C:\Windows\SoftwareDistribution\Download" -ItemType "directory" -Force
Start-Service -Name "wuauserv"

Write-BoxstarterMessage "Defragging..."
(New-Object System.Net.WebClient).DownloadFile("http://downloads.sourceforge.net/project/ultradefrag/stable-release/6.1.0/ultradefrag-portable-6.1.0.bin.amd64.zip", "ultradefrag.zip")
[System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem")
[System.IO.Compression.ZipFile]::ExtractToDirectory("ultradefrag.zip", ".") 
./ultradefrag-portable-6.1.0.amd64/udefrag.exe --optimize --repeat C:

Write-BoxstarterMessage "Zeroing..."
(New-Object System.Net.WebClient).DownloadFile("http://download.sysinternals.com/files/SDelete.zip", "sdelete.zip")
[System.Reflection.Assembly]::LoadWithPartialName("System.IO.Compression.FileSystem")
[System.IO.Compression.ZipFile]::ExtractToDirectory("sdelete.zip", ".") 
./sdelete.exe /accepteula -z c:

if(Test-PendingReboot){ Invoke-Reboot }

Write-BoxstarterMessage "Compact complete"
