.\scripts\config.ps1
Remove-Item -R src -Force
mkdir src
SolutionPackager /action Extract /ZipFile .\exports\solution.zip /Folder .\src\ /PackageType UnManaged
PASopa -unpack .\src\CanvasApps\$global:msapp .\src\CanvasApps\$global:msappSrc
Remove-Item .\src\CanvasApps\$global:msapp