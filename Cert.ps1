Write-Host "Listing all certificates in LocalMachine/My..."
Get-ChildItem Cert:\LocalMachine\My

$thumbprint = "CERT_THUMBPRINT_HERE" # Replace with actual thumbprint

Write-Host "Searching for certificate with thumbprint: $thumbprint"
$cert = Get-ChildItem Cert:\LocalMachine\My | Where-Object {$_.Thumbprint -eq $thumbprint}

if ($cert) {
    Write-Host "Certificate found: $($cert.Thumbprint)"
} else {
    Write-Host "Certificate not found. Check the thumbprint and ensure the certificate is installed."
}