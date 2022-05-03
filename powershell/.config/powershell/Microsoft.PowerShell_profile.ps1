# Shows navigable menu of all options when hitting Tab
Set-PSReadlineKeyHandler -Key Tab -Function MenuComplete

# Enable IntelliSense based on history
Set-PSReadLineOption -PredictionSource History

# Starship prompt
Invoke-Expression (starship init powershell)
