Import-Module posh-git
Import-Module -Name Terminal-Icons
Import-Module oh-my-posh
#Import-Module PoshColor
Set-PSReadLineOption -PredictionSource History
Set-PoshPrompt -Theme bubblesline
$env:POSH_GIT_ENABLED = $true
Set-PSReadLineOption -HistorySearchCursorMovesToEnd
Set-PSReadLineKeyHandler -Key UpArrow -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key DownArrow -Function HistorySearchForward
Set-PSReadlineKeyHandler -Key Tab -Function Complete
