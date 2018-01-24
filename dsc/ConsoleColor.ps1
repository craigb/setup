
Configuration ConsoleColor {

    # Import the module that contains the resources we're using.
    Import-DscResource -ModuleName PsDesiredStateConfiguration

    # The Node statement specifies which targets this configuration will be applied to.
    Node 'localhost' {
        Registry AddRedColor #ResourceName
        {
            Key = "HKCU:\Console"
            ValueName = "ColorTable04"
            Ensure = "Present"
            Force = $true
            Hex = $false
            ValueData = 4915455
            ValueType = "Dword"
            #PsDscRunAsCredential = Get-Credential # problem is credentials for HKCU
        }
    }
}