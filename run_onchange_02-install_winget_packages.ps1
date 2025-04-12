# Install winget packages

# Self-elevate the script if required
if (-Not ([Security.Principal.WindowsPrincipal] [Security.Principal.WindowsIdentity]::GetCurrent()).IsInRole([Security.Principal.WindowsBuiltInRole] 'Administrator')) {
  if ([int](Get-CimInstance -Class Win32_OperatingSystem | Select-Object -ExpandProperty BuildNumber) -ge 6000) {
    $CommandLine = "-NoExit -File `"" + $MyInvocation.MyCommand.Path + "`" " + $MyInvocation.UnboundArguments
    Start-Process -Wait -FilePath PowerShell.exe -Verb Runas -ArgumentList $CommandLine
    Exit
  }
}

$packages = @(
  "Alacritty.Alacritty",
  "Dropbox.Dropbox",
  "7zip.7zip",
  "Piriform.CCleaner",
  "CPUID.CPU-Z",
  "Mozilla.Thunderbird.de",
  "Notepad++.Notepad++",
  "VideoLAN.VLC",
  "LGUG2Z.komorebi",
  "Cryptomator.Cryptomator",
  "LGUG2Z.whkd"
  "wez.wezterm",
  "PuTTY.PuTTY",
  "AmN.yasb",
  "Brave.Brave",
  "Microsoft.PowerToys",
  "WinFsp.WinFsp",
  "Foxit.FoxitReader",
  "Sinew.Enpass",
  "AutoHotkey.AutoHotkey",
  "Discord.Discord",
  "WinDirStat.WinDirStat",
  "Balena.Etcher"
  "Obsidian.Obsidian",
  "WinSCP.WinSCP",
  "SSHFS-Win.SSHFS-Win"
  "Microsoft.VisualStudioCode"
)

foreach ($package in $packages) {
  winget install -h $package
}
