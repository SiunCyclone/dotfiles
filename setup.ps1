setx HOME %USERPROFILE%

# firefox
if ((Test-Path 'C:\Program Files (x86)\Mozilla Firefox') -Or (Test-Path 'C:\Program Files\Mozilla Firefox')) {
  echo "firefox is already installed"
} else {
  echo "*** Downloading firefox ***"
  (New-Object System.Net.WebClient).DownloadFile("https://download.mozilla.org/?product=firefox-36.0.4-SSL&os=win&lang=ja", "$HOME/firefox_installer.exe")
  Start-Process $HOME/firefox_installer.exe
}

# msys2
if ((Test-Path 'C:\msys64') -Or (Test-Path 'C:\msys32')) {
  echo "msys2 is already installed"
} else {
  echo "*** Downloading msys2 ***"
  if ([System.Environment]::Is64BitOperatingSystem) {
    (New-Object System.Net.WebClient).DownloadFile("http://downloads.sourceforge.net/project/msys2/Base/x86_64/msys2-x86_64-20150202.exe?r=http%3A%2F%2Fsourceforge.net%2Fprojects%2Fmsys2%2Ffiles%2FBase%2Fx86_64%2Fmsys2-x86_64-20150202.exe%2Fdownload&ts=1427130794&use_mirror=jaist", "$HOME/msys2_installer.exe")
  } else {
    (New-Object System.Net.WebClient).DownloadFile("http://downloads.sourceforge.net/project/msys2/Base/i686/msys2-i686-20150202.exe?r=&ts=1427333443&use_mirror=jaist", "$HOME/msys2_installer.exe")
  }
  Start-Process $HOME/msys2_installer.exe -Wait
}

