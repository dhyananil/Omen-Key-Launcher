$PressCount = 0
$LastPress = [datetime]::MinValue
$Waiting = $false
$Delay = 500

$player = New-Object System.Media.SoundPlayer
$player.SoundLocation = "path-to-your-Omen-Key-Sound.wav"
$player.Load()

$errorPlayer = New-Object System.Media.SoundPlayer
$errorPlayer.SoundLocation = "path-to-your-Omen-Key-Error.wav"
$errorPlayer.Load()

Register-WmiEvent -Namespace root\wmi -Class hpqBEvnt -SourceIdentifier OmenKey -Action {
    $e = $Event.SourceEventArgs.NewEvent

    if ($e.EventID -eq 29 -and $e.EventData -eq 8613 -and $e.Active) {
        $global:PressCount++
        $global:LastPress = Get-Date
        $global:Waiting = $true
    }
} | Out-Null

while ($true) {
    if ($Waiting -and ((Get-Date) - $LastPress).TotalMilliseconds -ge $Delay) {
        $Count = $PressCount

        $PressCount = 0
        $Waiting = $false

        if ($Count -eq 1) {
            $player.PlaySync()
            Start-Process -FilePath "path-to-launch-first-application-exe" -WorkingDirectory "path-to-first-application's-directory"
        }
        elseif ($Count -eq 2) {
            $player.PlaySync()
            Start-Process -FilePath "path-to-launch-second-application-exe" -WorkingDirectory "path-to-second-application's-directory"
        }
        elseif ($Count -eq 3) {
            $player.PlaySync()
            Start-Process -FilePath "path-to-launch-third-application-exe" -WorkingDirectory "path-to-third-application's-directory"
        }
        elseif ($Count -ge 4) {
            $errorPlayer.PlaySync()
        }
    }

    Start-Sleep -Milliseconds 50
}