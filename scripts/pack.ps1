.\scripts\config.ps1
Write-Host Remove dist and out folder
if (Test-Path dist) { Remove-Item dist -Recurse }
if (Test-Path out) { Remove-Item out -Recurse }
mkdir dist
mkdir out
Copy-Item -Path ".\src\*" -Destination ".\out\" -Recurse -Container
PASopa.exe -pack .\out\CanvasApps\$global:msapp .\out\CanvasApps\$global:msappSrc
Remove-Item -R .\out\CanvasApps\$global:msappSrc
SolutionPackager /action Pack /ZipFile .\dist\solution.zip /Folder .\out\ /PackageType UnManaged
Remove-Item -R out