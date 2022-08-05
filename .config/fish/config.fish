set fish_greeting # disable fish greeting
set -Ux EDITOR nvim
fish_add_path /home/tye/.cargo/bin
if status is-interactive
  # Commands to run in interactive sessions can go here
  zoxide init fish | source
end

set -Ux LS_COLORS "di=34:ln=35:so=32:pi=33:ex=37:bd=34;46:cd=34;43:su=30;41:sg=30;46:tw=30;42:ow=30;43"



test -s /home/tye/.nvm/nvm.fish; and source /home/tye/.nvm/nvm.fish
