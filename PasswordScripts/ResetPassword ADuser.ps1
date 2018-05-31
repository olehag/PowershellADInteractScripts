$ErrorActionPreference = 'stop'
#Authenticate with AD Admincredentials.
$creds = Get-Credential $env:USERDOMAIN\$env:USERNAME-admin 
#Info about the user.
$username = Read-Host -Prompt 'User to reset password!'
$newpassword = Read-Host -AsSecureString -Prompt 'Enter your new password!'
#Password reset execution.
Set-ADAccountPassword  -Identity $username -Credential $creds -Reset -NewPassword $newpassword
Set-ADUser -Identity $username -ChangePasswordAtLogon $true
#Exit
Write-Host "`tPress any key to exit..."
$x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
