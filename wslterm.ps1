# Function to extract our 7z download
Function Expand-Archive([string]$Path, [string]$Destination, [switch]$RemoveSource) {
	$7z_Application = "C:\Program Files\7-Zip\7z.exe"
	$7z_Arguments = @(
		'x'							## eXtract files with full paths
		'-y'						## assume Yes on all queries
		"`"-o$($Destination)`""		## set Output directory
		"`"$($Path)`""				## <archive_name>
	)
	& $7z_Application $7z_Arguments
	If ($RemoveSource -and ($LASTEXITCODE -eq 0)) {
		Remove-Item -Path $Path -Force
	}
}

# Ensure in $HOME directory
cd $env:USERPROFILE

# Set variable for WSL terminal
$wslTerminal = "wsl-terminal-0.8.3.7z"

# Get bits for WSL terminal
wget https://github.com/goreliu/wsl-terminal/releases/download/v0.8.3/wsl-terminal-0.8.3.7z -OutFile $env:USERPROFILE\$wslTerminal

# Extract WSL terminal and remove after complete
Get-ChildItem $wslTerminal -Filter *.7z | ForEach-Object {
	Expand-Archive -Path $_.FullName -Destination $env:USERPROFILE -RemoveSource
}

# Add shortcut to desktop
$TargetFile = "$env:USERPROFILE\wsl-terminal\open-wsl.exe"
$ShortcutFile = "$env:USERPROFILE\Desktop\bash.lnk"
$WScriptShell = New-Object -ComObject WScript.Shell
$Shortcut = $WScriptShell.CreateShortcut($ShortcutFile)
$Shortcut.TargetPath = $TargetFile
$Shortcut.Save()