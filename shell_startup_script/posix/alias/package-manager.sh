#! /bin/sh

aptitude_aliases() {
  alias pkg-search="aptitude search"
  alias pkg-install="sudo aptitude install"
  alias pkg-local-install="sudo dpkg -i"
  alias pkg-update="sudo aptitude update"
  alias pkg-upgrade="sudo aptitude update && sudo aptitude dist-upgrade"
  alias pkg-list="dpkg -l"
  alias pkg-remove="sudo aptitude remove"
  alias pkg-clean="sudo aptitude clean"
}
apt_get_aliases() {
  alias pkg-search="apt-cache search"
  alias pkg-install="sudo apt-get install"
  alias pkg-local-install="sudo dpkg -i"
  alias pkg-update="sudo apt-get update"
  alias pkg-upgrade="sudo apt-get update && sudo apt-get dist-upgrade"
  alias pkg-list="dpkg -l"
  alias pkg-remove="sudo apt-get remove"
  alias pkg-clean="sudo apt-get clean"
}
yaourt_aliases() {
  alias pkg-search="yaourt -Ss"
  alias pkg-install="yaourt -S"
  alias pkg-local-install="sudo pacman -U"
  alias pkg-update="yaourt -Sy"
  alias pkg-upgrade="yaourt -Syua"
  alias pkg-list="yaourt -Q"
  alias pkg-remove="yaourt -Rns"
  alias pkg-clean='yaourt -Rs $(yaourt -Qtdq)'
}
aurman_aliases() {
  alias pkg-search="aurman -Ss"
  alias pkg-install="aurman -S"
  alias pkg-local-install="sudo pacman -U"
  alias pkg-update="aurman -Sy"
  alias pkg-upgrade="aurman -Syua"
  alias pkg-list="aurman -Q"
  alias pkg-remove="aurman -Rns"
  alias pkg-clean='aurman -Rs $(aurman -Qtdq)'
}
pacman_aliases() {
  alias pkg-search="pacman -Ss"
  alias pkg-install="sudo pacman -S"
  alias pkg-local-install="sudo pacman -U"
  alias pkg-update="sudo pacman -Sy"
  alias pkg-upgrade="sudo pacman -Syu"
  alias pkg-list="pacman -Q"
  alias pkg-remove="sudo pacman -Rns"
  alias pkg-clean='sudo pacman -Rs $(pacman -Qtdq)'
}

system_pkg_mgrs="aptitude:apt-get:aurman:yaourt:pacman"
for pkg_mgr in $(echo "${system_pkg_mgrs}" | tr ':' '\n'); do
  if command -v "${pkg_mgr}" > /dev/null; then
    INFO "Loading aliases for '${pkg_mgr}'"
    "$(echo "${pkg_mgr}" | sed 's/-/_/g')_aliases"
    break
  fi
done

unset system_pkg_mgrs
unset pkg_mgr

