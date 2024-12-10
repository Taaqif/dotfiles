function New-Symlink {
    param (
        [string]$Path,
        [string]$Target,
        [string]$ItemType
    )
    New-Item -Path $Path -ItemType $ItemType -Value (Get-Item $Target | Resolve-Path).ProviderPath -Force
}

# Komorebi
New-Symlink -Path "${env:USERPROFILE}/.config/komorebi" -Target ".\.config\komorebi\" -ItemType "Junction"

# Powershell Profile
New-Symlink -Path "$PROFILE" -Target "./PowerShell/Microsoft.PowerShell_profile.ps1" -ItemType "HardLink"

# Starship
New-Symlink -Path "${env:USERPROFILE}/.config/starship.toml" -Target ".\.config\starship.toml" -ItemType "HardLink"

# wezterm
New-Symlink -Path "${env:USERPROFILE}/.config/wezterm" -Target ".\.config\wezterm\" -ItemType "Junction"

# lazygit
New-Symlink -Path "${env:USERPROFILE}/.config/lazygit" -Target ".\.config\lazygit\" -ItemType "Junction"

# nvim
New-Symlink -Path "${env:LOCALAPPDATA}/nvim" -Target ".\.config\nvim\" -ItemType "Junction"
