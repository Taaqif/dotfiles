using namespace System.Management.Automation

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
Set-PSReadLineKeyHandler -Key "Ctrl+p" -Function HistorySearchBackward
Set-PSReadLineKeyHandler -Key "Ctrl+n" -Function HistorySearchForward
Set-PSReadLineKeyHandler -Key Tab -Function MenuComplete

#env 
$env:STARSHIP_DISTRO = ""
$env:EDITOR = "nvim"
$env:LANG = "en_US.UTF-8"

$prompt = ""

function Invoke-Starship-PreCommand {
    $current_location = $executionContext.SessionState.Path.CurrentLocation
    $ansi_escape = [char]27
    # Set cwd OSC7
    if ($current_location.Provider.Name -eq "FileSystem") {
        $provider_path = $current_location.ProviderPath -replace "\\", "/"
        $prompt = "$ansi_escape]7;file://${env:COMPUTERNAME}/${provider_path}$ansi_escape\"
    }
    # Set OSC1337 os_icon
    $os_icon_base64 = [Convert]::ToBase64String([System.Text.Encoding]::UTF8.GetBytes($env:STARSHIP_DISTRO))

    $host.ui.Write("$ansi_escape]1337;SetUserVar=os_icon=$os_icon_base64$ansi_escape`a")
    $host.ui.Write($prompt)
}

Invoke-Expression (& starship init powershell)

# bartib
$env:BARTIB_FILE = "./time.bartib"

# helpful https://github.com/Seekatar/PSDynamicParameter
$bartibCompletion = {
    param($wordToComplete, $commandAst, $cursorPosition)
    # only react to -p 
    if ($commandAst.CommandElements[-1] -match "^-p$") {
        bartib projects
    }

    if ($commandAst.CommandElements[-2] -match "^-p$") {
        bartib projects | Where-Object {
            $_ -like ("*$wordToComplete*" -replace '"', "")
        } | ForEach-Object {
            "$_"
        }
    }
}

Register-ArgumentCompleter -CommandName bartib -Native -ScriptBlock $bartibCompletion

# zoxide
Invoke-Expression (& {
    $hook = if ($kSVersionTable.PSVersion.Major -lt 6) { 'prompt' } else { 'pwd' }
    (zoxide init --hook $hook powershell | Out-String)
})

# Set-Alias -Name cd -Value z -Option AllScope -Scope Global -Force

# lf
Function Invoke-Lfcd {
    $tmp = [System.IO.Path]::GetTempFileName()
    lf -last-dir-path="$tmp" $args
    if (Test-Path -PathType Leaf "$tmp") {
        $dir = Get-Content "$tmp"
        Remove-Item -Force "$tmp"
        if (Test-Path -PathType Container "$dir") {
            if ("$dir" -ne "$pwd") {
                cd "$dir"
            }
        }
    }
}

Set-Alias -Name lfcd -Value Invoke-Lfcd -Option AllScope -Scope Global -Force
Set-Alias -Name lg -Value lazygit -Option AllScope -Scope Global -Force
