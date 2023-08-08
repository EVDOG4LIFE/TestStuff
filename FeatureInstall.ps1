$filePath = "C:\temp\features.xml"

if (Test-Path $filePath) {
    $features = Import-Clixml -Path $filePath
    $features | ForEach-Object {
        if ($_.Name) {
            $feature = Get-WindowsFeature -Name $_.Name
            if ($null -eq $feature) {
                Write-Host "Feature $($_.Name) is not available on this server."
            } elseif (-not $feature.Installed) {
                try {
                    Install-WindowsFeature -Name $_.Name
                    # Re-check the feature
                    $feature = Get-WindowsFeature -Name $_.Name
                    if ($feature.Installed) {
                        Write-Host "Feature $($_.Name) installed successfully."
                    } else {
                        Write-Host "Feature $($_.Name) failed to install."
                    }
                } catch {
                    Write-Host "Failed to install feature $($_.Name). Error: $($_.Exception.Message)"
                }
            }
        } else {
            Write-Host "Feature name is missing. Skipping..."
        }
    }
} else {
    Write-Host "File $filePath does not exist."
}
