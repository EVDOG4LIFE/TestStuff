param (
    [string]$Server1_Name,
    [string]$Server2_Name
)

if (-not $Server1_Name -or -not $Server2_Name) {
    Write-Host "Please provide both Server1_Name and Server2_Name."
    return
}

# Function to get the roles and features
function Get-InstalledFeatures {
    param (
        [string]$ServerName
    )
    Invoke-Command -ComputerName $ServerName -ScriptBlock {
        Get-WindowsFeature | Where-Object { $_.Installed -eq $True }
    }
}

# Get the roles and features from both servers
$Server1 = Get-InstalledFeatures -ServerName $Server1_Name
$Server2 = Get-InstalledFeatures -ServerName $Server2_Name

# Compare the results
Compare-Object $Server1 $Server2 -Property Name, DisplayName, Installed | Format-Table -AutoSize