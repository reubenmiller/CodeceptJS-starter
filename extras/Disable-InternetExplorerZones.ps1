Param(
    [string[]] $ComputerName = "127.0.0.1",

    [int] $IEMode = 3
)

foreach ($Computer in $ComputerName) {
    #Test connectivity first
    $Connected = Test-Connection -computer $Computer -quiet -count 2
    
    if ($Connected)
    {
        Write-Host "Checking Internet Explorer Zone settings on [$Computer]"
        #
        # Check if the remote registry service is running (required for the script to work)
        #
        $RemoteRegistryService = Get-Service -Name RemoteRegistry -ComputerName $Computer -ErrorAction SilentlyContinue
        
        if ($RemoteRegistryService) {
            if ($RemoteRegistryService.Status -ne "running") {
                Write-Host "Starting Windows RemoteRegistry Service because it was not already running"
                $RemoteRegistryService.Start()
                $RemoteRegistryService.WaitForStatus("running", "00:00:05")
            }
        }

        # Collecting all users that are currently having Registry hives loaded
        $reg = Get-WmiObject -List -Namespace root\default -ComputerName $Computer | Where-Object {$_.Name -eq "StdRegProv"}
        $HKEY_USERS = 2147483651
        $Users = $reg.EnumKey($HKEY_USERS, "") | Select-Object -ExpandProperty sNames

        foreach ($User in $Users)
        {
            #$User.Length

            # We are only intersted in AD users. Their SID lengh is 44 or 45 symbols
            # if ($User -ne $null)
            if (($User.Length -eq 45) -or ($User.Length -eq 44))
            {
                Write-Host "User: $User"

                # [Microsoft.Win32.RegistryHive]::Users
                $reg = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey($HKEY_USERS, $Computer)
                $pathV = $User + "\Volatile Environment"
                $regkey = $reg.OpenSubkey($pathV)

                # If a user does not have the registry key, then we are not going to check him
                if ($regkey -ne $null)
                {

                    # Getting User name
                    $Username = $regkey.GetValue("USERNAME")
                    "User:" + $Username

                    # Getting Zones
                    $pathZ = $User + "\Software\Microsoft\Windows\CurrentVersion\Internet Settings\Zones\"
                    $regkey11 = $reg.OpenSubkey($pathZ)
                    $Zones = $regkey11.GetSubKeyNames()

                    # For each zone extract "Protected Mode" state
                    if ($regkey11 -ne $null)
                    {
                        $Modes = @()
                        foreach ($Zone in $Zones)
                        {
                            $DPath = $pathZ + '\' + $Zone;
                            $regN = [Microsoft.Win32.RegistryKey]::OpenRemoteBaseKey($HKEY_USERS, $Computer).OpenSubkey($DPath, $true)  # Open key in writable mode, hence the $true
                            [int] $CurrentMode = $regN.GetValue("2500")
                            'Zone ' + $Zone + ': ' + $regN.GetValue("2500")
                            $Modes += $regN.GetValue("2500")

                            if (($Zone -gt 0) -and ($CurrentMode -ne $IEMode)) {
                                Write-Host "Setting Zone [$Zone] to Mode [$IEMode], current Mode is [$CurrentMode]"
                                $regN.SetValue("2500", $IEMode, [Microsoft.Win32.RegistryValueKind]::DWORD)
                            }
                            
                        }
                    }
                }

            }

        }
    }

}
