function CreateCertificate() {
    bash -c "openssl req -x509 -newkey rsa:4096 -keyout key.pem -out cert.pem -days 365 -subj '/CN=localhost' -sha256 < <(echo 'asdf' 'asdf')"
}