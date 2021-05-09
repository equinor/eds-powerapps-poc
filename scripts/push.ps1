Write-Host "Declare variables"
.\scripts\config.ps1

Write-Host "Clean up temporary folder"
if (Test-Path dist) { Remove-Item dist -Recurse }
if (Test-Path out) { Remove-Item out -Recurse }
mkdir dist
mkdir out

Write-Host "Duplicate src folder"
Copy-Item -Path ".\src\*" -Destination ".\out\" -Recurse -Container

Write-Host "Pack msapp"
PASopa.exe -pack .\out\CanvasApps\$global:msapp .\out\CanvasApps\$global:msappSrc
Remove-Item .\out\CanvasApps\$global:msappSrc -Recurse

Write-Host "Pack Solution"
SolutionPackager /action Pack /ZipFile .\dist\solution.zip /Folder .\out\ /PackageType UnManaged
Remove-Item -R out

Write-Host "Import into environment"
pac solution import --path dist\solution.zip
Remove-Item "dist" -Recurse