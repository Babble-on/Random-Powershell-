$AppLocation = "Path to app"
$WshShell = New-Object -ComObject WScript.Shell
$Shortcut = $WshShell.CreateShortcut("location and name of .lnk")
$Shortcut.TargetPath = $AppLocation
$Shortcut.Description ="Safety Points"
$Shortcut.WorkingDirectory ="path to app"
$Shortcut.IconLocation = "location of icon.ico,0"
$Shortcut.Save()