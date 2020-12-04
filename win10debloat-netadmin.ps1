##########
# Network Tools Script
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
	"InstallNetAdminTools"
)


Function InstallNetAdminTools {
	Write-Output "Installing Network Admin Tools"
	choco install network-miner -y
	Function InstallAtom {
	choco install atom -y
	choco install wireshark -y
	choco install vcredist140 -y
	choco install openssh -y
	choco install python3 -y
	choco install putty -y
	choco install sysinternals -y
	choco install dotnet4.5.2 -y
	choco install winscp -y
	choco install virtualbox -y
	choco install microsoft-windows-terminal -y
	choco install rufus -y
	choco install vmrc -y
	choco install pingplotter -y
	choco install tftpd32 -y
	set-shortcut "c:\users\Public\desktop\Putty.lnk" "C:\ProgramData\chocolately\bin\putty.exe"
	set-shortcut "c:\users\Public\desktop\NetMiner.lnk" "C:\ProgramData\chocolately\bin\NetMiner.exe"
	set-shortcut "c:\users\Public\desktop\TFTPD64.lnk" "C:\ProgramData\chocolately\bin\tftpd64.exe"
	set-shortcut "c:\users\Public\desktop\Rufus.lnk" "C:\ProgramData\chocolately\bin\rufus.exe"
	set-shortcut "c:\users\Public\desktop\Wireshark.lnk" "C:\Program Files\Wireshark\Wireshark.exe"
}

##########
# Auxiliary Functions
##########

function set-shortcut {
param ( [string]$SourceLnk, [string]$DestinationPath )
    $WshShell = New-Object -comObject WScript.Shell
    $Shortcut = $WshShell.CreateShortcut($SourceLnk)
    $Shortcut.TargetPath = $DestinationPath
    $Shortcut.Save()
}


# Relaunch the script with administrator privileges
Function RequireAdmin {
	If (!([Security.Principal.WindowsPrincipal][Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole]"Administrator")) {
		Start-Process powershell.exe "-NoProfile -ExecutionPolicy Bypass -File `"$PSCommandPath`" $PSCommandArgs" -WorkingDirectory $pwd -Verb RunAs
		Exit
	}
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
