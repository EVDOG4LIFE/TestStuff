# Initialize the server list
$servers = Get-Content -Path "C:\Path\to\servers.txt"

foreach ($server in $servers) {
    # Querying the OS information
    $os = Get-WmiObject -ComputerName $server -Class Win32_OperatingSystem

    # Output the server name, OS caption (name) and version
    Write-Output "Server: $server"
    Write-Output "OS: $($os.Caption)"
    Write-Output "Version: $($os.Version)"
    Write-Output "-----------------------------"
}
