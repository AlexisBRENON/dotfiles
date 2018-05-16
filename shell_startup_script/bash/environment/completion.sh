#! /usr/bin/env bash

complete -A hostname   telnet ftp ping disk ssh
complete -A variable   export local readonly unset
complete -A enabled    builtin
complete -A alias      alias unalias
complete -A function   function
complete -A user       su mail finger

complete -A helptopic  help     # Currently same as builtins.
complete -A shopt      shopt
complete -A stopped -P '%' bg
complete -A job -P '%'     fg jobs disown

complete -A directory  mkdir rmdir
complete -A directory   -o default cd

# Compression
complete -f -o default -X '*.+(zip|ZIP)'  zip
complete -f -o default -X '!*.+(zip|ZIP)' unzip
complete -f -o default -X '*.+(z|Z)'      compress
complete -f -o default -X '!*.+(z|Z)'     uncompress
complete -f -o default -X '*.+(gz|GZ)'    gzip
complete -f -o default -X '!*.+(gz|GZ)'   gunzip
complete -f -o default -X '*.+(bz2|BZ2)'  bzip2
complete -f -o default -X '!*.+(bz2|BZ2)' bunzip2
complete -f -o default -X '!*.+(tar.gz|tgz|tar.bz2|tbz|tbz2|tar.xz|txz|tar.zma|tlz|tar|gz|bz2|xz|lzma|Z|zip|rar|7z|deb)' x


# Documents
complete -f -o default -X '!*.+(pdf|PDF)' evince
complete -f -o default -X '!*.tex' tex latex slitex

# Multimedia
complete -f -o default -X \
'!*.+(gif|GIF|jp*g|JP*G|bmp|BMP|xpm|XPM|png|PNG)' gimp eog
complete -f -o default -X '!*.+svg' inkscape
complete -f -o default -X '!*.+(mp3|MP3)' vlc
complete -f -o default -X '!*.+(ogg|OGG)' vlc


#  This is a 'universal' completion function - it works when commands have
#+ a so-called 'long options' mode , ie: 'ls --all' instead of 'ls -a'
#  Needs the '-o' option of grep
#+ (try the commented-out version if not available).

#  First, remove '=' from completion word separators
#+ (this will allow completions like 'ls --color=auto' to work correctly).

COMP_WORDBREAKS=${COMP_WORDBREAKS/=/}
_get_longopts()
{
  $1 --help | grep -o -e "--[^[:space:].,]*" | grep -e "$2" |sort -u
}

_longopts()
{
  local cur
  cur=${COMP_WORDS[COMP_CWORD]}

  case "${cur:-*}" in
    (-*) ;;
    (*) return ;;
  esac

  case "$1" in
    (\~*) eval cmd="$1" ;;
    (*) export cmd="$1" ;;
  esac
  COMPREPLY=( $(_get_longopts "${1}" "${cur}" ) )
}
complete  -o default -F _longopts configure bash
complete  -o default -F _longopts wget info ls recode

_tar()
{
  local cur ext regex tar untar

  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}

  # If we want an option, return the possible long options.
  case "$cur" in
    (-*)
      COMPREPLY=( $(_get_longopts "$1" "$cur" ) )
      return 0
      ;;
  esac

  if [ "$COMP_CWORD" -eq 1 ]; then
    COMPREPLY=( $( compgen -W 'c t x u r d A' -- "$cur" ) )
    return 0
  fi

  case "${COMP_WORDS[1]}" in
    "(?(-)c"*f)
      COMPREPLY=( $( compgen -f "$cur" ) )
      return 0
      ;;
    "+([^Izjy])f")
      ext='tar'
      regex=$ext
      ;;
    *z*f)
      ext='tar.gz'
      regex='t\(ar\.\)\(gz\|Z\)'
      ;;
    *[Ijy]*f)
      ext='t?(ar.)bz?(2)'
      regex='t\(ar\.\)bz2\?'
      ;;
    *)
      COMPREPLY=( $( compgen -f "$cur" ) )
      return 0
      ;;

    esac

    if [[ "$COMP_LINE" == "tar"*".$ext "*"" ]]; then
      # Complete on files in tar file.
      #
      # Get name of tar file from command line.
      tar=$(\
        echo "$COMP_LINE" | \
        sed -e "s|^.* \([^ ]*$regex\) .*$|\1|" \
        )
      # Devise how to untar and list it.
      untar=t${COMP_WORDS[1]//[^Izjyf]/}

      COMPREPLY=( $( \
        compgen -W "$( \
          tar "$untar" "$tar" 2>/dev/null \
        )" -- "$cur" )
      )
      return 0

    else
      # File completion on relevant files.
      COMPREPLY=( $( compgen -G "$cur*.$ext" ) )

    fi

    return 0

  }
complete -F _tar -o default tar

_make()
{
  local makef makef_dir="." makef_inc gcmd cur prev i;
  COMPREPLY=();
  cur=${COMP_WORDS[COMP_CWORD]};
  prev=${COMP_WORDS[COMP_CWORD-1]};
  case "$prev" in
    -*f)
      COMPREPLY=($(compgen -f "$cur" ));
      return 0
      ;;
  esac;
  case "$cur" in
    -*)
      COMPREPLY=($(_get_longopts "$1" "$cur" ));
      return 0
      ;;
  esac;

  # ... make reads
  #          GNUmakefile,
  #     then makefile
  #     then Makefile ...
  if [ -f ${makef_dir}/GNUmakefile ]; then
    makef=${makef_dir}/GNUmakefile
  elif [ -f ${makef_dir}/makefile ]; then
    makef=${makef_dir}/makefile
  elif [ -f ${makef_dir}/Makefile ]; then
    makef=${makef_dir}/Makefile
  else
    local mk=( ${makef_dir}/*.mk )         # Local convention.
    makef=${mk[1]}
  fi


  #  Before we scan for targets, see if a Makefile name was
  #+ specified with -f.
  for (( i=0; i < ${#COMP_WORDS[@]}; i++ )); do
    if [[ ${COMP_WORDS[i]} == -f ]]; then
      # eval for tilde expansion
      eval makef="${COMP_WORDS[i+1]}"
      break
    fi
  done
  [ ! -f "$makef" ] && return 0

  # Deal with included Makefiles.
  makef_inc=$(\
    grep -E '^-?include' "$makef" | \
    sed -e "s,^.* ,$makef_dir/," \
    )
  for file in $makef_inc; do
    [ -f "$file" ] && makef="$makef $file"
  done

  #  If we have a partial word to complete, restrict completions
  #+ to matches of that word.
  if [ -n "$cur" ]; then gcmd="grep '^$cur'" ; else gcmd=cat ; fi

  COMPREPLY=( $(\
    awk -F':' '
  /^[a-zA-Z0-9][^$#\/\t=]*:([^=]|$)/ {
    split($1,A,/ /);for(i in A)print A[i]
  }' \
    "$makef" 2>/dev/null | eval "$gcmd"  ))
}
complete -F _make -X '+($*|*.[cho])' make gmake pmake

_killall()
{
  local cur prev
  COMPREPLY=()
  cur=${COMP_WORDS[COMP_CWORD]}

  #  Get a list of processes
  #+ (the first sed evaluation
  #+ takes care of swapped out processes, the second
  #+ takes care of getting the basename of the process).
  COMPREPLY=( $( \
    ps -u "$USER" -o comm  | \
    sed -e '1,1d' -e 's#[]\[]##g' -e 's#^.*/##'| \
    awk '{if ($0 ~ /^'"$cur"'/) print $0}' ))

  return 0
}
complete -F _killall killall killps

