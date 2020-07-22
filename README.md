# Download and Install latest VLC Media Player

Create folder C:\IntuneLogs (if not exist)
Logfile = C:\IntuneLogs\log_install-VLCPlayer.txt
Check and Download latest VLC media player from:
Download link = https://download.videolan.org/vlc/last/win64/
Install VLC player
Remove all default icons from start menu and desktop
Create startmenu icon:
Link is Start Menu = "C:\Program Files\VideoLAN\VLC\vlc.exe" --no-qt-privacy-ask --no-qt-updates-notif
When starting VLC Media Player no questions asked (privacy and updates)

Intune:
Install Command: powershell.exe -ExecutionPolicy Bypass -File VLCplayer-installer.ps1 -Customer Algemeen
Uninstall command: %PROGRAMFILES%\VideoLAN\VLC\uninstall.exe /S
Install behavior: System
Manual Detection rules: %PROGRAMFILES%\VideoLAN\VLC\vlc.exe

Disable 'first run' on Internet Explorer (GPO or Administration Tepmlate)

 
