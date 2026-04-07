# Init Starship prompt
Invoke-Expression (&starship init powershell)

# Import git-aliases module (installed via Scoop)
Import-Module git-aliases -DisableNameChecking

# eza aliases
Function ll($path) { eza -lg --icons=auto --group-directories-first $path }
Function la($path) { eza -lag --icons=auto --group-directories-first $path }
Function l($path) { eza -lg $path }
Set-Alias -Name ls -Value eza -Option AllScope

# lazygit alias
Set-Alias -Name lg -Value lazygit

# Replace cat with bat
Set-Alias -Name cat -Value bat -Option AllScope

# Replace grep with ugrep
Set-Alias -Name grep -Value ug

# Clear alias
Set-Alias -Name clr -Value clear

# Fake function to fix a Junie bug
# Junie sometimes calls 'true' which isn't a valid PowerShell command.
# This leads to Junie killing its own session with error code 127.
# This fake function fixes this.
Function true { echo "" }

# Init zoxide
Invoke-Expression (& { (zoxide init powershell | Out-String) })

# Init atuin
(&atuin init powershell) | Out-String | Invoke-Expression

# Yazi function
function y {
  $tmp = [System.IO.Path]::GetTempFileName()
  yazi $args --cwd-file="$tmp"
  $cwd = Get-Content -Path $tmp
  if (-not [String]::IsNullOrEmpty($cwd) -and $cwd -ne $PWD.Path) {
      Set-Location -LiteralPath $cwd
  }
  Remove-Item -Path $tmp
  # Reset cursor to underline
  $esc = [char]27
  Write-Host -NoNewline "$esc[4 q"
}

# mise activate
(&mise activate pwsh) | Out-String | Invoke-Expression
