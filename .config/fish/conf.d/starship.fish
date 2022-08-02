
# find out which distribution we are running on
set -l _distro (awk '/^ID=/' /etc/""*-release | awk -F'=' '{ print tolower($2) }')

 # set an icon based on the distro
switch $_distro
  case kali 
    set -Ux STARSHIP_DISTRO "ﴣ"
  case arch 
    set -Ux STARSHIP_DISTRO ""
  case debian 
    set -Ux STARSHIP_DISTRO ""
  case raspbian 
    set -Ux STARSHIP_DISTRO ""
  case ubuntu 
    set -Ux STARSHIP_DISTRO ""
  case elementary 
    set -Ux STARSHIP_DISTRO ""
  case fedora 
    set -Ux STARSHIP_DISTRO ""
  case coreos 
    set -Ux STARSHIP_DISTRO ""
  case gentoo 
    set -Ux STARSHIP_DISTRO ""
  case mageia 
    set -Ux STARSHIP_DISTRO ""
  case centos 
    set -Ux STARSHIP_DISTRO ""
  case opensuse 
    set -Ux STARSHIP_DISTRO ""
  case sabayon 
    set -Ux STARSHIP_DISTRO ""
  case slackware 
    set -Ux STARSHIP_DISTRO ""
  case linuxmint 
    set -Ux STARSHIP_DISTRO ""
  case alpine 
    set -Ux STARSHIP_DISTRO ""
  case aosc 
    set -Ux STARSHIP_DISTRO ""
  case nixos 
    set -Ux STARSHIP_DISTRO ""
  case devuan 
    set -Ux STARSHIP_DISTRO ""
  case manjaro 
    set -Ux STARSHIP_DISTRO ""
  case rhel 
    set -Ux STARSHIP_DISTRO ""
  case *
    set -Ux STARSHIP_DISTRO ""
end
  
starship init fish | source
