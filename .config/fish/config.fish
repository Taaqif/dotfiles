set fish_greeting # disable fish greeting
set -Ux EDITOR nvim
set -Ux TERM xterm-256color
set -Ux NEOVIM_WIN_DIR "/mnt/c/Program Files/Neovim"
fish_add_path ~/.cargo/bin
fish_add_path /usr/local/go/bin
fish_add_path ~/.local/bin
fish_add_path ~/go/bin
fish_add_path ~/.dotnet/tools
fish_add_path ~/.local/share/bob/nvim-bin
fish_add_path /mnt/c/Program\ Files/WezTerm
fish_add_path /mnt/c/Windows/System32
fish_add_path /mnt/c/Windows/System32/WindowsPowershell/v1.0
if status is-interactive
    # Commands to run in interactive sessions can go here
    zoxide init fish | source
end

set -Ux LS_COLORS "di=34:ln=35:so=32:pi=33:ex=37:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"
alias lg='lazygit'
alias ssh='ssh.exe'
alias ssh-add='ssh-add.exe'

test -s /home/tye/.nvm/nvm.fish; and source /home/tye/.nvm/nvm.fish
set --universal nvm_default_version v18

# bun
set --export BUN_INSTALL "$HOME/.bun"
set --export PATH $BUN_INSTALL/bin $PATH

# Android
set -xg ANDROID_HOME_WIN /mnt/c/Users/TyePeck/AppData/Local/Android/Sdk
set -xg ANDROID_HOME $HOME/android
# set -xg ANDROID_HOME $ANDROID_HOME_WIN
set -xg ANDROID_SDK_ROOT $ANDROID_HOME
# set -xg PATH $ANDROID_HOME/cmdline-tools/latest/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $PATH
set -xg PATH $ANDROID_HOME/cmdline-tools/bin $ANDROID_HOME/platform-tools $ANDROID_HOME/tools $ANDROID_HOME/tools/bin $PATH

# yazi
function y
    set tmp (mktemp -t "yazi-cwd.XXXXXX")
    yazi $argv --cwd-file="$tmp"
    if read -z cwd <"$tmp"; and [ -n "$cwd" ]; and [ "$cwd" != "$PWD" ]
        builtin cd -- "$cwd"
    end
    rm -f -- "$tmp"
end

# pnpm
set -gx PNPM_HOME "/home/tye/.local/share/pnpm"
if not string match -q -- $PNPM_HOME $PATH
    set -gx PATH "$PNPM_HOME" $PATH
end
# pnpm end
