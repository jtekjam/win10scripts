##########
# Tweaked Win10 Initial Setup Script
# Primary Author: Disassembler <disassembler@dasm.cz>
# Primary Author Source: https://github.com/Disassembler0/Win10-Initial-Setup-Script
# Tweaked Source: https://gist.github.com/alirobe/7f3b34ad89a159e6daa1/
# Tweaked Sournce: https://github.com/ChrisTitusTech/win10script
# Note from author: Never run scripts without reading them & understanding what they do.
#	jtekjam additions - see README.md
#
##########
# Default preset
$tweaks = @(
	### Require administrator privileges ###
	"RequireAdmin",

	### External Program Setup
	"InstallJtekProgs", #REQUIRED FOR OTHER PROGRAM INSTALLS!
	"InstallFoxitPDF",
	"Install7Zip",
	"InstallVLC",
	"InstallDrawIO",
	"InstallDefaultBrowser",
	"InstallChrome",
	"InstallFirefox",
	"InstallOffice365Business",
	"InstallMSTeams",
	"InstallGIMP",
	"InstallTeamViewer",
	"InstallGreenshot",
	"SecureScreenSaver",
	"Restart"
)


Function InstallJtekProgs {
	Write-Output "Installing Chocolatey"
	Set-ExecutionPolicy Bypass -Scope Process -Force; [System.Net.ServicePointManager]::SecurityProtocol = [System.Net.ServicePointManager]::SecurityProtocol -bor 3072; iex ((New-Object System.Net.WebClient).DownloadString('https://chocolatey.org/install.ps1'))
	choco install chocolatey-core.extension -y
	Write-Output "Running O&O Shutup with Recommended Settings"
	Import-Module BitsTransfer
	Start-BitsTransfer -Source "https://raw.githubusercontent.com/jtekjam/win10scripts/master/ooshutup10.cfg" -Destination ooshutup10.cfg
	Start-BitsTransfer -Source "https://dl5.oo-software.com/files/ooshutup10/OOSU10.exe" -Destination OOSU10.exe
	./OOSU10.exe ooshutup10.cfg /quiet
}

Function InstallGIMP {
	Write-Output "Installing GIMP"
	choco install gimp -y
}

Function InstallGreenshot{
	Write-Output "Installing GreenShot"
	choco install greenshot -y
}

Function InstallTeamViewer {
	Write-Output "Installing Teamviewer"
	choco install teamviewer -y
}

Function InstallFoxitPDF {
	Write-Output "Installing Foxit PDF Reader"
	choco install foxitreader -y /LANG=en
}

Function InstallJava {
	Write-Output "Installing Java"
	choco install jre8 -y
}

Function Install7Zip {
	Write-Output "Installing 7-Zip"
	choco install 7zip -y
}

Function InstallVLC {
	Write-Output "Installing VLC Media Player"
	choco install vlc -y
}

Function InstallDrawIO {
	Write-Output "Installing Draw.IO Diagram Editor"
	choco install drawio -y
}

Function InstallDefaultBrowser {
	Write-Output "Installing Default Browser"
	choco install setdefaultbrowser -y
}

Function InstallChrome {
	Write-Output "Installing Chrome"
	choco install googlechrome -y
}

Function InstallFirefox {
	Write-Output "Installing Firefox"
	choco install firefox -y
	Write-Output "Setting Firefox as Default Browser"
	SetDefaultBrowser.exe firefox
}

Function InstallOffice365Business {
	Write-Output "Installing Office365 Business"
	choco install office365business -y
}

Function InstallMSTeams {
	Write-Output "Installing Microsoft Teams"
	choco install microsoft-teams.install -y
}

Function SecureScreenSaver {
			$value = 900
			$path = 'HKCU:\Control Panel\Desktop'
			$name = 'ScreenSaveTimeOut'
			$secure = 'ScreenSaverIsSecure'
			$active = 'ScreenSaveActive'
			$save = 'SCRNSAVE.EXE'
			$ssaver = 'C:\Windows\system32\Mystify.scr'

			# resume to lock
			New-Item -Path $path -name $secure
			Set-ItemProperty -Path $path -name $secure -value 1

			# set active
			New-Item -Path $path -name $active
			Set-ItemProperty -Path $path -name $active -value 1

			# set to 15 min
			New-Item -Path $path -name $name
			Set-ItemProperty -Path $path -name $name -value $value

			# set to mystify
			New-Item -Path $path -name $save
			Set-ItemProperty -Path $path -name $save -value $ssaver
}

##########
# Auxiliary Functions
##########

# Relaunch the script with administrator privileges
Function RequireAdmin {
	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
		Exit
	}
}

# Wait for key press
Function WaitForKey {
	Write-Output "Press any key to continue..."
	[Console]::ReadKey($true) | Out-Null
}

# Restart computer
Function Restart {
	Write-Output "Restarting..."
	Restart-Computer
}


##########
# Parse parameters and apply tweaks
##########

# Normalize path to preset file
$preset = ""
$PSCommandArgs = $args
If ($args -And $args[0].ToLower() -eq "-preset") {
	$preset = Resolve-Path $($args | Select-Object -Skip 1)
	$PSCommandArgs = "-preset `"$preset`""
}

# Load function names from command line arguments or a preset file
If ($args) {
	$tweaks = $args
	If ($preset) {
		$tweaks = Get-Content $preset -ErrorAction Stop | ForEach { $_.Trim() } | Where { $_ -ne "" -and $_[0] -ne "#" }
	}
}

# Call the desired tweak functions
$tweaks | ForEach { Invoke-Expression $_ }
