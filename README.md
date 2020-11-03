# win10scripts
This is a new version of the Ultimate Windows 10 Script from a creation from multiple debloat scripts and gits from github (big thanks to ChrisTitus for the original). Just added my flare and a Win10 update manage scripts. See descriptions below or [go straight to running the scripts below](https://git.io/JUUFn)

## Windows 10 Update Manager
- A simple Powershell script to manage windows updates

## CORE: Debloat Only Script
- O&O Shutup10 CFG and Run is almost the recommended list
- Leave IE in place
- Install Chocolately
- Debloat Windows - disable xbox, remove fax, remove xps, and more...
- Install 7-z7ip

## BIZ: Debloat Plus Useful Business Apps
- Everything in CORE plus...
- Install Foxit PDF instead of Adobe
- Install Atom text editor
- Install Firefox
- Install Chrome
- Install Draw.io
- Install SetDefaultBrowser (set default to firefox)
- Install Microsoft Teams
- Install Microsoft Office 365 Business
- Install GIMP
- Install TeamViewer
- Install greenshot

## NETADMIN: network admin tools
-- Just installs following --
- Install network-miner
- Install wireshark
- Install vcredist140
- Install openssh
- Install python3
- Install putty
- Install sysinternals
- Install dotnet4.5.2
- Install winscp
- Install virtualbox
- Install microsoft-windows-terminal
- Install rufus
- Install vmrc
- Install pingplotter
- Install TFTP32/64

## Or just run the script from here...
Manage Win10 Updates -
```
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://git.io/JUUFv')"
```
CORE Script -
```
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://git.io/JJNyn')"
```
BIZ Script -
```
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://git.io/JJNyZ')"
```
NETADMIN Script -
```
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://git.io/JJNy8')"
```

## Modifications
I encourage people to fork this project and comment out things they don't like!

Comment any thing you don't want out... Example:

```
########## NOTE THE # SIGNS! These disable lines This example shows UACLow being set and Disabling SMB1
### Security Tweaks ###
	"SetUACLow",                  # "SetUACHigh",
	"DisableSMB1",                # "EnableSMB1",

########## NOW LETS SWAP THESE VALUES AND ENABLE SMB1 and Set UAC to HIGH
### Security Tweaks ###
	"SetUACHigh",
	"EnableSMB1",
```
