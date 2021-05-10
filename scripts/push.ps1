import-module powershell-yaml
[string[]]$fileContent = Get-Content .\config.yaml
$content = ''
foreach ($line in $fileContent) { $content = $content + "`n" + $line }
$config = ConvertFrom-YAML $content -Ordered

$msapp = $config.msapp
$msappSrc = $config.msappSrc

$msappFile = Join-Path (Resolve-Path .\).Path src\CanvasApps\$msapp
$msappSrcDir = Join-Path (Resolve-Path .\).Path src\CanvasApps\$msappSrc 

Write-Host "Clean up temporary folder"
if (Test-Path dist) { Remove-Item dist -Recurse }
if (Test-Path out) { Remove-Item out -Recurse }
mkdir dist
mkdir out

Write-Host "Duplicate src folder"
Copy-Item -Path ".\src\*" -Destination ".\out\" -Recurse -Container

Write-Host "Pack msapp"
PASopa.exe -pack $msappFile $msappSrcDir
Remove-Item $msappSrcDir -Recurse

Write-Host "Pack Solution"
SolutionPackager /action Pack /ZipFile .\dist\solution.zip /Folder .\out\ /PackageType UnManaged
Remove-Item "out" -Recurse

Write-Host "Import into environment"
pac solution import --path dist\solution.zip
Remove-Item "dist" -Recurse