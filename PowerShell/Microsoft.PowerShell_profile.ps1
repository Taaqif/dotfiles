Invoke-Expression (&starship init powershell)
Import-Module -Name Terminal-Icons
# Import-Module posh-git
# Import-Module oh-my-posh
# #Import-Module PoshColor
# Set-PoshPrompt -Theme bubblesline
# $env:POSH_GIT_ENABLED = $true

Import-Module -Name PSReadLine
Set-PSReadLineOption -PredictionSource History
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

#env 
$env:STARSHIP_DISTRO = ""

# zoxide
Invoke-Expression (& {
    $hook = if ($PSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})
Set-Alias -Name cd -Value z -Option AllScope -Scope Global -Force
