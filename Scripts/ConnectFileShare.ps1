<#
.SYNOPSIS
    This script is used to mount a fileshare in the CEA environment.

.DESCRIPTION
    The Azure file share must be pre-configured by the admin team with instructions located here: https://gcdocs.gc.ca/statcan/llisapi.dll/link/10803193

    If you have issues with the librries, try installing these:
    Install-Module -Name Az
    Install-Module -Name Azure

    Install-module Az -AllowClobber -Force
    Import-module Az

.PARAMETER saname
    The parameter DemoParam1 is storage account where the file share is found

.PARAMETER fsname
    The parameter DemoParam2 is the file share.

.EXAMPLE
    The example below does works for the PPE File Share that was previously created.
    PS C:\> .\ConnectFileShare.ps1  statppeintfi ppe 

.EXAMPLE
    Another example
    PS C:\Users\path\Documents\cae-eac\Scripts> .\ConnectFileShare.ps1
    Enter the name of the storage account where the file share is found: statppeintfi
    Enter the name of the file share: ppe

.NOTES
    Author: Michelle K
    Last Edit: 2021-01
    Version 1.0 - initial release of script to mount file share in CAE environment
#>

[CmdletBinding()]
param
(
    [string] $saname,
    [string] $fsname
)

if (-not($saname)) {
    $saname = Read-Host -Prompt "Enter the name of the storage account where the file share is found" 
}
if (-not($fsname)) {
    $fsname = Read-Host -Prompt "Enter the name of the file share"
}


$ModuleName = "az"
$module = Get-Module $ModuleName -ListAvailable -ErrorAction SilentlyContinue
$module
if (!$module) {
    Write-Host "Installing module $ModuleName ..."
    #Install-Module -Name $ModuleName -Force -Scope CurrentUser
    Write-Host "Module installed"
}

#connect to Azure
if ($null -eq $login) {
    Write-Host "Connect to Azure ($login) ..."
    $login = Login-AzAccount
    Write-Host "Connect to Azure Done ($login) ..."
}

Select-AzSubscription vdl

$rgname = Get-AzStorageAccount | Where-Object {$_.StorageAccountName -eq $saname} | Select-Object -ExpandProperty ResourceGroupName
$keys = Get-AzStorageAccountKey -ResourceGroupName $rgname -AccountName $saname
$key = $keys[0].value

$connectTestResult = Test-NetConnection -ComputerName "$saname.file.core.windows.net" -Port 445
if ($connectTestResult.TcpTestSucceeded) {
    Write-Host "Connection Successful to $saname.file.core.windows.net\$fsname"
    # Save the password so the drive will persist on reboot  - not sure if this is needed
    cmd.exe /C "cmdkey /add:`"$saname.file.core.windows.net`" /user:`"Azure\$saname`" /pass:`"$key`""
    # Mount the drive
    New-PSDrive -Name "S" -Root "\\$saname.file.core.windows.net\$fsname" -Persist -PSProvider "FileSystem"
    
    Write-Host "Finished  \\$saname.file.core.windows.net\$fsname"
} else {
    Write-Error -Message "Unable to reach the Azure storage account via port 445. Check to make sure your organization or ISP is not blocking port 445, or use Azure P2S VPN, Azure S2S VPN, or Express Route to tunnel SMB traffic over a different port."
}

#   TcpTestSucceeded