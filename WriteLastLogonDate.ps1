
Remove-Variable * -ErrorAction SilentlyContinue; Remove-Module *; $error.Clear();

#Test and Set Username from Environment Variable
$Username = $ENV:USERNAME

If (!$Username) {
    $Username = [Environment]::UserName
}

#The below checks for the user profile path
$testUserProfilepath = Test-Path -Type Container "C:\Users\$($Username)"

#If the path exists then it will write the date to the file
If ($testUserProfilepath -eq $true)
{	
	$NTUSERDat = Get-Item "C:\Users\$($Username)\NTUSER.DAT" -Force
    $NTUSERDatLastModified = $NTUSERDat.LastWriteTime
	
	$UsrClassDat = Get-Item "C:\Users\$($Username)\AppData\Local\Microsoft\Windows\UsrClass.dat" -force
	"$(Get-Date -Date $USRClassDat.LastWriteTime -uformat "%Y/%m/%d")" | Out-File -FilePath "C:\Users\$($Username)\LastLogonDate.txt" -Encoding ascii
    $UsrClassDatLastModified = $UsrClassDat.LastWriteTime
	
	if ($NTUSERDatLastModified -ne $UsrClassDatLastModified)
    {
        $NTUSERDat.LastWriteTime = $UsrClassDatLastModified
        Write-Host "$($Username) - NTUSER.dat Last Modified date updated to match UsrClass.dat"
    }
    else
    {
        Write-Host "$($Username) - NTUSER.dat Last Modified date already matches UsrClass.dat"
    }
}