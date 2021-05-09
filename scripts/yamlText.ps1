import-module powershell-yaml
[string[]]$fileContent = Get-Content .\config.yaml
$content = ''
foreach ($line in $fileContent) { $content = $content + "`n" + $line }
$config = ConvertFrom-YAML $content -Ordered
Write-Output $config.prod