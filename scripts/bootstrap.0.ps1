$env:chocolateyVersion = '0.9.10.3'
iex ((new-object net.webclient).DownloadString('https://chocolatey.org/install.ps1'))
refreshenv
choco install powershell -y
