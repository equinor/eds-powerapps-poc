import-module powershell-yaml
[string[]]$fileContent = Get-Content .\config.yaml
$content = ''
foreach ($line in $fileContent) { $content = $content + "`n" + $line }
$config = ConvertFrom-YAML $content -Ordered

$msapp = $config.msapp
$srcDir = $config.msappSrc

#echo $config.msapp 

Write-Host "Export solution from environment"
if (Test-Path "in") { Remove-Item "in" -Recurse }
mkdir "in"
pac solution export --path in\solution.zip --name EDSTemplate --managed false --include general

Write-Host "Extract solution to src"
if (Test-Path src) { Remove-Item src -Recurse }
mkdir "src"
SolutionPackager /action Extract /ZipFile .\in\solution.zip /Folder .\src\ /PackageType UnManaged
Remove-Item "in" -Recurse

Write-Host "Unpack msapp file"
PASopa -unpack .\src\CanvasApps\$msapp
Remove-Item .\src\CanvasApps\$msapp