<#
.Synopsis 
	Powershell script that will detect the OS and run a set of scripts based of which OS is detected for data transfer
.Notes 
	Author - Kylar Ainsworth - https://kylarainsworth.com
	Notable Help - Rob Ainsworth - https://ainsey11.com
#> 



# Sets the variables for the scripts
$excusrdir = ("Administrator","Default","Public","All Users","QB*")
$userdir = (Get-ChildItem -Path 'C:\users\' -name -exclude $excusrdir)
$userdirxp = (Get-ChildItem -Path 'C:\documents and settings' -name -exclude $excusrdir)
$getos = (Get-WmiObject Win32_OperatingSystem).Name

# Sets customer folder via compudeploy in powershell, does not work on anything less than 4.0 so net use is used.  
# $pass = "P@ssw0rd!"|ConvertTo-SecureString -AsPlainText -Force
# $cred = New-Object System.Management.Automation.PsCredential('custdata',$pass)
# New-PSDrive –Name “Z” –PSProvider FileSystem –Root "\\compudeploy.\customers" -Credential $cred -Persist
net use Z: \\compudeploy.\customers /user:custdata P@ssw0rd!
# Sets variable for customer folder
$setclientname = Read-host -Prompt 'Input Customer First and last name'

# Change to the \\compudeploy.\customers folder"
Z:

# makes the client name directory
mkdir Z:\$setclientname

# changes to the new client folder
cd $setclientname

# Pipe the contents of $userdir(xp) and make a directory

foreach ($user in $userdir) {mkdir $user} 




if ( $getos -like "Microsoft Windows 10")
{
 
#Do commands here

}
 
 
if ( $getos -like "Microsoft Windows 8")
 
{

#Do commands here
 foreach ($user in $userdir) {robocopy C:\users\$user\documents\  /e /zb /dcopy:T /MT:25 /r:3 /r:3 /w:3 /v /eta /log:C:\robocopy.txt}
}
 
if ( $getos -like "Microsoft Windows 7*")
 
{
 
#Do commands here
 foreach ($user in $userdir) {robocopy C:\users\$user\documents\ Z:\$setclientname\$user\ /e /zb /dcopy:T /MT:25 /r:3 /r:3 /w:3 /v /eta /log:C:\robocopy.txt}
 foreach ($user in $userdir) {robocopy C:\users\$user\contacts\ Z:\$setclientname\$user\ /e /zb /dcopy:T /MT:25 /r:3 /r:3 /w:3 /v /eta /log:C:\robocopy.txt}
 foreach ($user in $userdir) {robocopy C:\users\$user\downloads\ Z:\$setclientname\$user\ /e /zb /dcopy:T /MT:25 /r:3 /r:3 /w:3 /v /eta /log:C:\robocopy.txt}
 foreach ($user in $userdir) {robocopy C:\users\$user\videos\ Z:\$setclientname\$user\ /e /zb /dcopy:T /MT:25 /r:3 /r:3 /w:3 /v /eta /log:C:\robocopy.txt}
 foreach ($user in $userdir) {robocopy C:\users\$user\pictures\ Z:\$setclientname\$user\ /e /zb /dcopy:T /MT:25 /r:3 /r:3 /w:3 /v /eta /log:C:\robocopy.txt}
 foreach ($user in $userdir) {robocopy C:\users\$user\desktop\ Z:\$setclientname\$user\ /e /zb /dcopy:T /MT:25 /r:3 /r:3 /w:3 /v /eta /log:C:\robocopy.txt}
}

if ( $getos -like "Microsoft Windows Vista")
 
{
 
#Do commands here
 
}

if ( $getos -like "Microsoft Windows XP")
 
{
 
#Do commands here
 
}
 
Else {
Write-Host "OS Not Supported"
}
 
 