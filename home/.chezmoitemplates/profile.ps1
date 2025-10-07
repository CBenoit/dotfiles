# Shows navigable menu of all options when hitting Tab.
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Enable IntelliSense based on history.
Set-PSReadLineOption -PredictionSource History

# Define default editor.
$Env:EDITOR = "hx"
$Env:GIT_EDITOR = $Env:EDITOR

# Editor alias.
New-Alias -Name e -Value $Env:EDITOR

# Starship prompt.
Invoke-Expression (starship init powershell)

# Zoxide.
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})
