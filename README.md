# win10scripts
This is a new version of the Ultimate Windows 10 Script from a creation from multiple debloat scripts and gits from github (big thanks to ChrisTitus for the original). Added a few versions for debloat and business apps for automation with auto-reboot. See descriptions below or and use the scripts at the bottom. I also added a network admin tools section to just install network admin tools. 

## Windows 10 Update Manager
- A simple Powershell script to manage windows updates

## CORE: Debloat Plus Installs
- O&O Shutup10 CFG and Run is almost the recommended list
- Disable Telemetry, Trackers
- Network Tweaks
- Leave IE in place
- Using Winget instead of Chocolately
- Debloat Windows - disable xbox, remove fax, remove xps, and more...
- Install 7-zip, VLC, Foxit, Office 365, Greenshot, Browsers, more

## Or just run the script from here...
Manage Win10 Updates -
```
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://git.io/JTb3s')"
```
CORE Script -
```
powershell -nop -c "iex(New-Object Net.WebClient).DownloadString('https://raw.githubusercontent.com/jtekjam/win10scripts/master/new-installer.ps1')"
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
