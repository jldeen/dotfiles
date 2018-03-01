# Silent Install 7-Zip
# http://www.7-zip.org/download.html
# https://forum.pulseway.com/topic/1939-install-7-zip-with-powershell/ 
Function install7z {
	# Path for the workdir
	$workdir = "c:\installer\"

	# Check if work directory exists if not create it
	If (Test-Path -Path $workdir -PathType Container)
	{ Write-Host "$workdir already exists" -ForegroundColor Red}
	ELSE
	{ New-Item -Path $workdir  -ItemType directory }

	# Download the installer
	$source = "http://www.7-zip.org/a/7z1801-x64.msi"
	$destination = "$workdir\7-Zip.msi"

	# Check if Invoke-Webrequest exists otherwise execute WebClient
	if (Get-Command 'Invoke-Webrequest')
	{
		Invoke-WebRequest $source -OutFile $destination
	}
	else
	{
		$WebClient = New-Object System.Net.WebClient
		$webclient.DownloadFile($source, $destination)
	}

	Invoke-WebRequest $source -OutFile $destination 

	# Start the installation
	msiexec.exe /i "$workdir\7-Zip.msi" /qb
	# Wait XX Seconds for the installation to finish
	Start-Sleep -s 35

	# Remove the installer
	rm -Force $workdir\7*
}

# Check for 7z install
$7z = 'C:\Program Files\7-Zip\7z.e'
if (-NOT (Test-Path $7z)) {
	Write-Host "7zip not found, installing now..."
	install7z
	}

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
$wslTerminal = "wsl-terminal-0.8.8.7z"

# Get bits for WSL terminal
[Net.ServicePointManager]::SecurityProtocol = [Net.SecurityProtocolType]::Tls12
Invoke-WebRequest -Uri 'https://github.com/goreliu/wsl-terminal/releases/download/v0.8.8/wsl-terminal-0.8.8.7z' -OutFile $env:USERPROFILE\$wslTerminal

# Extract WSL terminal and remove after complete
Get-ChildItem $wslTerminal -Filter *.7z | ForEach-Object {
	Expand-Archive -Path $_.FullName -Destination $env:USERPROFILE -RemoveSource
}

# Check if symlink exists. If not, create it
$symlink = "$env:USERPROFILE\Desktop\wsl.lnk"
If (Test-Path -Path $symlink)
	{ Write-Host "$symlink already exists" -ForegroundColor Red }
ELSE
	{ New-Item -ItemType SymbolicLink -Path "$env:USERPROFILE\Desktop\" -Name "wsl.lnk" -Value "$env:USERPROFILE\wsl-terminal\open-wsl.exe" }