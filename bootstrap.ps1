function New-Symlink {
    param (
        [string]$Path,
        [string]$Target,
        [string]$ItemType
    )
    if (Test-Path $Path) {
        Write-Host "Removing existing $Path"
        Remove-Item -Path $Path -Recurse -Force
    }
    $ResolvedTarget = (Get-Item $Target | Resolve-Path).ProviderPath
    Write-Host "Linking $Path -> $ResolvedTarget as $ItemType"
    New-Item -Path $Path -ItemType $ItemType -Value $ResolvedTarget
}

# Verify Nuget version is installed
$version = "2.8.5.208"
Write-Host "Verifying NuGet $version or later is installed"
$nuget = Get-PackageProvider -Name NuGet -ListAvailable -ErrorAction SilentlyContinue |
                Sort-Object -Property {[version]$_.version} | Select-Object -Last 1

if(-not $nuget -or [version]$nuget.version -lt [version]$version){
    Write-Host "Installing NuGet $($nuget.Version)"
    $null = Install-PackageProvider -Name NuGet -MinimumVersion $nuget.version -Force
}

# Install Required Modules
Install-Module PSReadLine -Repository PSGallery -Scope CurrentUser -Force -Confirm:$false
Install-Module Terminal-Icons -Repository PSGallery -Scope CurrentUser -Force -Confirm:$false

# Komorebi
New-Symlink -Path "${env:USERPROFILE}/.config/komorebi" -Target ".\.config\komorebi\" -ItemType "Junction"

# Git Config
New-Symlink -Path "${env:USERPROFILE}/.config/.gitconfig" -Target ".\.config\.gitconfig" -ItemType "HardLink"

# Powershell Profile
New-Symlink -Path "$PROFILE" -Target "./PowerShell/Microsoft.PowerShell_profile.ps1" -ItemType "HardLink"

# Wakatime config
New-Symlink -Path "${env:USERPROFILE}/.config/.wakatime.cfg" -Target ".\.config\.wakatime.cfg" -ItemType "HardLink"

# Starship
New-Symlink -Path "${env:USERPROFILE}/.config/starship.toml" -Target ".\.config\starship.toml" -ItemType "HardLink"

# wezterm
New-Symlink -Path "${env:USERPROFILE}/.config/wezterm" -Target ".\.config\wezterm\" -ItemType "Junction"

# lazygit
New-Symlink -Path "${env:USERPROFILE}/AppData/Local/lazygit/config.yml" -Target ".\.config\lazygit\config.yml" -ItemType "HardLink"

# nvim
New-Symlink -Path "${env:LOCALAPPDATA}/nvim" -Target ".\.config\nvim\" -ItemType "Junction"
