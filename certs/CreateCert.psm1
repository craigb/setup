$junkPassword = 'foobar';

function Create-JunkCert() {
    # https://www.ibm.com/support/knowledgecenter/en/SSWHYP_4.0.0/com.ibm.apimgmt.cmc.doc/task_apionprem_gernerate_self_signed_openSSL.html
    bash -c "openssl req -newkey rsa:4096 -nodes -keyout key.pem -x509 -days 1 -out certificate.pem -sha256 -passin pass:$junkPassword -passout pass:$junkPassword -subj `"/CN=localhost`""
    bash -c "openssl pkcs12 -inkey key.pem -in certificate.pem -export -out certificate.p12 -passin pass:$junkPassword -passout pass:$junkPassword"
    $PSCommandPath | Write-Host
    $PSScriptRoot | Write-Host
    Start-Process powershell -ArgumentList "-Command { Import-Module $PSCommandPath; pushd $PSScriptRoot; Import-JunkCert(); pause; }" -Verb runas
}

function Import-JunkCert() {
    Import-PfxCertificate -FilePath .\certificate.p12 -CertStoreLocation 'Cert:\localmachine\my' -Password (ConvertTo-SecureString -string 'foobar' -AsPlainText -force)
}