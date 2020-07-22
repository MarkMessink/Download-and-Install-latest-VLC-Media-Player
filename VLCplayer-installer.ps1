<#
.SYNOPSIS
    Download and Install latest VLC player
	Mark Messink 21-07-2020

.DESCRIPTION
 
.INPUTS
  None

.OUTPUTS
  Log file: log_install-VLCPlayer.txt
  
.NOTES
 
  
.EXAMPLE
  .\VLCplayer-installer.ps1

#>

# Create logpath (if not exist)
$logpath = "C:\IntuneLogs"
If(!(test-path $logpath))
{
      New-Item -ItemType Directory -Force -Path $logpath
}

$logFile = "$logpath\log_install-VLCPlayer.txt"

#Start logging
Start-Transcript $logFile -Append -Force

	Write-Output "-------------------------------------------------------------------"
    Write-Output "Check latest VLC Player"
    $downloadLocation = "https://download.videolan.org/vlc/last/win64/"
	$getIndex = Invoke-Webrequest -Uri $downloadLocation
	$name = ($getIndex.ParsedHtml.getElementsByTagName("a") | Where {$_.innerhtml -like 'vlc-*.exe'}).innertext
	Write-Output "Bestandnaam: $Name"
	
	Write-Output "-------------------------------------------------------------------"
    Write-Output "Download latest VLC Player"
	$downloadLocation = "https://download.videolan.org/vlc/last/win64/$name"
	Write-Output "URL: $downloadLocation"
	$downloadDestination = "$($env:TEMP)\vlcplayer.exe"
	$webClient = New-Object System.Net.WebClient 
	$webClient.DownloadFile($downloadLocation, $downloadDestination)
	
	Write-Output "-------------------------------------------------------------------"
	Write-Output "Install VLC Player"
	$installProcess = Start-Process $downloadDestination -ArgumentList "/S" -WindowStyle Hidden -PassThru
	$installProcess.WaitForExit()
	
	Write-Output "-------------------------------------------------------------------"
	Write-Output "Remove Default Icons"
	$StartMenuFolder = "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs\VideoLAN" 
	if (Test-Path $StartMenuFolder) { Remove-Item $StartMenuFolder -Recurse; }
	$DesktopIcon = "$env:public\Desktop\VLC media player.lnk"
	if (Test-Path $DesktopIcon) { Remove-Item $DesktopIcon; }
	
	Write-Output "-------------------------------------------------------------------"
	Write-Output "Copy Icon"
	copy-item VLC*.lnk "$env:ALLUSERSPROFILE\Microsoft\Windows\Start Menu\Programs" -force
	
#Stop Logging
Stop-Transcript
