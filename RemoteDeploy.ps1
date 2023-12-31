# Define the static file path
$filePath = "\\fileshare\path\to\OctopusTentacle.msi"

# Get server names from user
$serverNames = Read-Host -Prompt "Enter server names, separated by commas"

# Get the RunAs user credentials
$credentials = Get-Credential -Message "Enter the credentials of the user to run the command as"

# Convert the server names string to an array
$serverNames = $serverNames -split ','

foreach($serverName in $serverNames) {
    # Trim any leading or trailing spaces
    $serverName = $serverName.Trim()

    # Display a message indicating the server where the installation is starting
    Write-Host "Starting installation on $serverName"

    # Run the installation on the remote server
    Invoke-Command -ComputerName $serverName -Credential $credentials -ScriptBlock {
        param($filePath)

        # Run msiexec command with quiet mode, no user interface
        Start-Process -FilePath "msiexec.exe" -ArgumentList "/i `"$filePath`" /qn" -Wait
    } -ArgumentList $filePath

    # Display a message indicating the server where the installation has completed
    Write-Host "Installation completed on $serverName"
}
