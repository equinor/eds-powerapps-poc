# Fill in Details so you won't need to enter them every time
param (    
    [Parameter(Mandatory=$True)][ValidateNotNull()][string]$solutionShortName,      
    [string]$username = "you@somewhere.com",    
    [string]$password = "password",    
    [string]$exportLocation = "C:\DEV\readyxrm",    
    [string]$instance = "https://<<orgname>>.crm3.dynamics.com/",
    [string]$region = "CAN",    
    [string]$type = "Office365",
    [string]$organisation = "<<orgname>>" 
    ) 

# Make sure we have modules imported
Import-Module Microsoft.Xrm.Data.Powershell

# Get Credentials
$securePassword = ConvertTo-SecureString $password -AsPlainText -Force
$credentials = New-Object System.Management.Automation.PSCredential ($username, $securePassword)

# Connect to PowerApps/Dynamics 365
$CRMConn = Get-CrmConnection -Credential $credentials -DeploymentRegion $region –OnlineType $type –OrganizationName $organisation

# Export both Managed and UnManaged Solutions
Write-Host "Exporting Solution, please wait."

Export-CrmSolution $solutionShortName $exportLocation -SolutionZipFileName $solutionShortName"_Unmanaged.zip" -conn $CRMConn

Export-CrmSolution $solutionShortName $exportLocation -SolutionZipFileName $solutionShortName"_Managed.zip" -Managed -conn $CRMConn

# Unpack Solution
Write-Host "Expanding Solution, please wait."

Expand-CrmSolution -ZipFile $solutionShortName"_Unmanaged.zip" -PackageType Unmanaged -Folder $solutionShortName

# Add to Local Repository
Write-Host "Staging Changes to Source Control"

git add -A

# Commit Changes to Local Repository
Write-Host "Committing Changes to Source Control"

# Get today's date
$today = Get-Date -Format g

# Commit with today's date & message
git commit -m "D365 Solution $($today)"

# Push to AzureDevOps
Write-Host "Syncing changes to Source Control"

git push