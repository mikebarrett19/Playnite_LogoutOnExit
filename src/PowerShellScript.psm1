function OnApplicationStarted()
{
    Out-File "$env:APPDATA\Playnite\lock.txt"
}

function OnApplicationStopped()
{
    # Remove this process's file and Launch logout check in new process ( to allow fullscreen to announce itself )
    if (Test-Path -Path "$env:APPDATA\Playnite\lock.txt"){
  	Remove-Item -Path "$env:APPDATA\Playnite\lock.txt"
	Start-Process PowerShell -ArgumentList '
		$i=0
		while (1) 
		{
			Start-Sleep 1
			if (Test-Path "$env:APPDATA\Playnite\lock.txt") { Exit }
			if ($i -eq 3) { shutdown.exe -l }
			$i++
		}'
    }
}

