#Import modules used:
Clear-Host
Import-Module ActiveDirectory
Write-Host "Imported modules..." -ForegroundColor Cyan


#Find the ADUser
function find-aduser ( [string]$queryUser) {
    try{
        $aduser = Get-ADUser -LDAPFilter "(anr=$queryUser)" -SearchBase "OU=,OU=,DC=,DC="
    } Catch {
        $errormsg = $_.Exception.Message
        Write-Host $errormsg
        Break
    }
    if( $aduser -isnot [Microsoft.ActiveDirectory.Management.ADAccount] ) {
        if ( $aduser ) {
            write-host "Multiple users found: " $aduser.length
            for( $i=0; $i -lt $aduser.length ) {
                Write-Host "                                       "
                Write-Host "-------------------$i---------------------------------" -ForegroundColor Magenta
                Write-Host ""
                write-host "`t"$aduser[$i].DistinguishedName
                Write-Host ""
                Write-Host "`t"$aduser[$i].Name
                Write-Host ""
                write-Host "`t"$aduser[$i].SAMAccountName
                Write-Host "_____________________________________________________" -ForegroundColor Magenta
                $i++
            }

        } else {
            return $null
        }
    } else {

        Write-Host "                                       "
        Write-Host "-------------------$i---------------------------------" -ForegroundColor Magenta
        Write-Host ""
        write-host "`tOU-Path: " $aduser.DistinguishedName
        Write-Host ""
        Write-Host "`tUsername: " $aduser.Name
        Write-Host ""
        Write-Host "`tName: " $aduser.GivenName $aduser.Surname
        Write-Host ""
        Write-Host "`tE-Mail: " $aduser.UserPrincipalName
        Write-Host "______________________________________________________" -ForegroundColor Gray
    }
    return $aduser
}


While($true) {
    Write-Host "-------------------------------------------------------------------" -ForegroundColor Red
    $userInput = Read-Host -Prompt "Enter Name"
    $search = find-aduser $userInput
    if( $null -eq $search) {
        Invoke-Expression .\find-aduser.ps1 #LAZY AF
    }
    Write-Host "`tPress any button to Reload..." -ForegroundColor Yellow
    $x = $host.UI.RawUI.ReadKey("NoEcho,IncludeKeyDown")
    Clear-Host
    
}
