#! /bin/sh

# Pacman - https://wiki.archlinux.org/index.php/Pacman_Tips
if command -v pacman > /dev/null ; then
  alias pacupg='sudo pacman -Syu'
  alias pacin='sudo pacman -S'
  alias pacins='sudo pacman -U'
  alias pacre='sudo pacman -R'
  alias pacrem='sudo pacman -Rns'
  alias pacrep='pacman -Si'
  alias pacreps='pacman -Ss'
  alias pacloc='pacman -Qi'
  alias paclocs='pacman -Qs'
  alias pacinsd='sudo pacman -S --asdeps'
  alias pacmir='sudo pacman -Syy'
  alias paclsorphans='sudo pacman -Qdt'
  alias pacrmorphans='sudo pacman -Rs $(pacman -Qtdq)'
  alias pacupd='sudo pacman -Sy'

  paclist() {
    # Source: https://bbs.archlinux.org/viewtopic.php?id=93683
    LC_ALL=C pacman -Qei $(pacman -Qu | cut -d " " -f 1) | \
      awk 'BEGIN {FS=":"} /^Name/{printf("\033[1;36m%s\033[1;37m", $2)} /^Description/{print $2}'
  }
  pacdisowned() {
    emulate -L zsh

    tmp=${TMPDIR-/tmp}/pacman-disowned-$USER-$$
    db=$tmp/db
    fs=$tmp/fs

    mkdir "$tmp"
    trap  'rm -rf "$tmp"' EXIT

    pacman -Qlq | sort -u > "$db"

    find /bin /etc /lib /sbin /usr ! -name lost+found \
      \( -type d -printf '%p/\n' -o -print \) | sort > "$fs"

    comm -23 "$fs" "$db"
  }
fi
