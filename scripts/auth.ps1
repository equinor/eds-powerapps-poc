import-module powershell-yaml
[string[]]$fileContent = Get-Content .\config.yaml
$content = ''
foreach ($line in $fileContent) { $content = $content + "`n" + $line }
$config = ConvertFrom-YAML $content -Ordered

pac auth clear
Write-Host "Authenticate for EDS Prod"
pac auth create --url $config.prod

Write-Host "Authenticate for EDS Dev"
pac auth create --url $config.dev

Write-Host "Authenticate for EDS Dev Fre"
pac auth create --url $config.fre

Write-Host "Authenticate for EDS Dev Vnys"
pac auth create --url $config.vnys

Write-Host "Select EDS Dev environment as default"
pac auth select --index 2
pac auth list