Import-Module ServerManager

# Get the roles and features from Server1
$Server1 = Get-WindowsFeature | Where-Object { $_.Installed -eq $True }

# Get the roles and features from Server2
$Server2 = Invoke-Command -ComputerName 'Server2_Name' -ScriptBlock { Get-WindowsFeature | Where-Object { $_.Installed -eq $True } }

# Compare the results
Compare-Object $Server1 $Server2 -Property Name, DisplayName, Installed | Format-Table -AutoSize