$answer = $null

Enable-PSRemoting -Force
if ((Get-WmiObject -Class Win32_ComputerSystem).partofdomain -eq $false) {
  winrm set winrm/config/service/Auth @{Basic="true"}
  write-host "This PC isn't domain joined, so local accounts have been granted authorization to authenticate remotely."
  }
  else {
  write-host "This PC is domain joined. Use an account authorized for remote access."
  }
if ((Get-Item WSMan:\localhost\client\Allowunencrypted) -eq $false) {
  $answer = Read-Host "Allow unencrypted is currently not enabled. Is connection failing? Y/N"
    while("yes","no","y","n" -notcontains $answer)
      {
	    $answer = Read-Host "Allow unencrypted is currently not enabled. Is connection failing? Y/N"
      }
    if ($answer -eq "yes" -or $answer -eq "y") {
      winrm set winrm/config/service @{AllowUnencrypted="true"}
      }
    else {
      write-host "Congratulations!"
      }
    }
  else {
  write-host "This computer is already setup to allow unencrypted connections."
  }
