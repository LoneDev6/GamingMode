$OptimizeKey = 'HKCU:\HKEY_CURRENT_USER\SOFTWARE\Microsoft\GameBar'
$SteamGameIdKey = 'HKCU:\HKEY_CURRENT_USER\SOFTWARE\Valve\Steam'

While ( $true )
{
    Set-ItemProperty -Path $OptimizeKey -Name "AllowAutoGameMode" -Value '1'

    $SteamId = (Get-ItemProperty -Path $SteamGameIdKey).RunningAppID
    if($SteamId -eq '0')
    {
        Write-Host "No Steam game running" -ForegroundColor Gray
        Set-ItemProperty -Path $OptimizeKey -Name "AutoGameModeEnabled" -Value '0'
    } 
    else
    {
        $GameName = (Get-Item -LiteralPath ("HKCU:\HKEY_CURRENT_USER\SOFTWARE\Valve\Steam\Apps\" + $SteamId)).GetValue("Name", $null)
        if($GameName -ne $null)
        {
            #TODO: better way to find the game executable.
            $GameProcess = Get-Process | Where-Object { $_.MainWindowTitle -eq $GameName }
            if($GameProcess -eq $null)
            {
                $GameProcess = Get-Process | Where-Object { $_.Path -like ("*\common\" + $GameName + "*") }
            }

            if($GameProcess -ne $null)
            {
                Write-Host ("Steam game running: " + $GameName + ". Setting High process priority.") -ForegroundColor Green
                $GameProcess.PriorityClass = [System.Diagnostics.ProcessPriorityClass]::High
            }
            else
            {
                Write-Host ("Steam game running. Can't set High process priority (unknown exe path).") -ForegroundColor Green
            }
        }
        else
        {
            Write-Host ("Steam game running. Can't set High process priority (unknown exe path).") -ForegroundColor Green
        }

        Set-ItemProperty -Path $OptimizeKey -Name "AutoGameModeEnabled" -Value '1'
    }

    Start-Sleep -Seconds 5
}