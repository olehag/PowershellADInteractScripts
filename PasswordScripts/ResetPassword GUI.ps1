<# This form was created using POSHGUI.com  a free online gui designer for PowerShell
.NAME
    Untitled
#>
$creds = Get-Credential $env:USERDOMAIN\$env:USERNAME-admin 

Add-Type -AssemblyName System.Windows.Forms
[System.Windows.Forms.Application]::EnableVisualStyles()

#region begin GUI{ 
$Form                            = New-Object system.Windows.Forms.Form
$Form.ClientSize                 = '277,192'
$Form.text                       = "Password reset"
$Form.TopMost                    = $false

$usernameBox                     = New-Object system.Windows.Forms.TextBox
$usernameBox.multiline           = $false
$usernameBox.width               = 100
$usernameBox.height              = 20
$usernameBox.location            = New-Object System.Drawing.Point(150,15)
$usernameBox.Font                = 'Microsoft Sans Serif,10'

$Execute                         = New-Object system.Windows.Forms.Button
$Execute.text                    = "Execute"
$Execute.width                   = 65
$Execute.height                  = 30
$Execute.location                = New-Object System.Drawing.Point(93,118)
$Execute.Font                    = 'Microsoft Sans Serif,10'

$Passwordlabel                   = New-Object system.Windows.Forms.Label
$Passwordlabel.text              = "New password"
$Passwordlabel.AutoSize          = $true
$Passwordlabel.width             = 25
$Passwordlabel.height            = 10
$Passwordlabel.location          = New-Object System.Drawing.Point(24,56)
$Passwordlabel.Font              = 'Microsoft Sans Serif,10'
$Passwordlabel.ForeColor         = "#000000"

$passwordBox                     = New-Object system.Windows.Forms.MaskedTextBox
$passwordBox.multiline           = $false
$passwordBox.width               = 100
$passwordBox.height              = 20
$passwordBox.PasswordChar        = "*"
$passwordBox.location            = New-Object System.Drawing.Point(150,56)
$passwordBox.Font                = 'Microsoft Sans Serif,10'

$Usernamelabel                   = New-Object system.Windows.Forms.Label
$Usernamelabel.text              = "Username"
$Usernamelabel.AutoSize          = $true
$Usernamelabel.width             = 25
$Usernamelabel.height            = 10
$Usernamelabel.location          = New-Object System.Drawing.Point(24,15)
$Usernamelabel.Font              = 'Microsoft Sans Serif,10'
$Usernamelabel.ForeColor         = "#000000"

$Form.controls.AddRange(@($usernameBox,$Execute,$Passwordlabel,$passwordBox,$Usernamelabel))

#region gui events {
$Execute.Add_Click({ 
    [string]$username = $usernameBox.text
    $newpassword = ConvertTo-SecureString $passwordBox.text -AsPlainText -Force
    Set-ADAccountPassword  -Identity $username -Credential $creds -Reset -NewPassword $newpassword
    Set-ADUser -Identity $username -Credential $creds -ChangePasswordAtLogon $true
 })
#endregion events }

#endregion GUI }


#Write your logic code here

[void]$Form.ShowDialog()