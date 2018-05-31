$ErrorActionPreference = 'stop'

$creds = Get-Credential $env:USERDOMAIN\$env:USERNAME-admin

$username = Read-Host -Prompt 'User to change!'

$oldpassword = Read-Host -AsSecureString -Prompt 'Enter your old password!'

$newpassword = Read-Host -AsSecureString -Prompt 'Enter your new password!'

Set-ADAccountPassword  -Identity $username -Credential $creds -OldPassword $oldpassword -NewPassword $newpassword

#Exit
Write-Host "`tPress any key to exit..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")