import-module Activedirectory
$ReadTargetUser = Read-Host 'Please enter username for the target user '
$TargetUser = Get-ADUser -Filter {sAMAccountName -eq $ReadTargetUser} -Properties *
if($TargetUser -eq $Null){
    Write-Host "User $TargetUser does not exist, exiting..."
    Start-Sleep -s 4
    exit
}

$ReadCopyUser = Read-Host 'Please enter username for user to copy '
$CopyUser = Get-ADUser -Filter {sAMAccountName -eq $ReadCopyUser} -Properties *
if($CopyUser -eq $Null){
    Write-Host "User $CopyUser does not exist, exiting..."
    Start-Sleep -s 4
    exit
}


Set-ADUser $TargetUser -Description $CopyUser.Description
Set-ADUser $TargetUser -Office $CopyUser.Office
Set-ADUser $TargetUser -HomePage $CopyUser.HomePage
Set-ADUser $TargetUser -StreetAddress $CopyUser.StreetAddress
Set-ADUser $TargetUser -City $CopyUser.City
Set-ADUser $TargetUser -State $CopyUser.State
Set-ADUser $TargetUser -PostalCode $CopyUser.PostalCode
Set-ADUser $TargetUser -Country $CopyUser.Country
Set-ADUser $TargetUser -Title $CopyUser.Title
Set-ADUser $TargetUser -Department $CopyUser.Department
Set-ADUser $TargetUser -Company $CopyUser.Company
Set-ADUser $TargetUser -Manager $CopyUser.Manager

$CopyUser.MemberOf | Where{$TargetUser.MemberOf -notcontains $_} | Add-ADGroupMember -Members $TargetUser