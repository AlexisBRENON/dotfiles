#! /bin/sh

extract() {
	remove_archive=""
	success=""
	extract_dir=""

	if [ $# -eq 0 ]; then
		cat >&2 <<-'EOF'
			Usage: extract [-option] [file ...]

			Options:
			    -r, --remove    Remove archive.
		EOF
	fi

	remove_archive="false"
	if [ "$1" = "-r" ] || [ "$1" = "--remove" ]; then
		remove_archive="true"
		shift
	fi

	while [ $# -gt 0 ]; do
		if [ ! -f "$1" ]; then
			echo "extract: '$1' is not a valid file" >&2
			shift
			continue
		fi

		success=0
    extract_dir="$(basename "$1")"
		case "$1" in
			(*.tar.gz|*.tgz) tar zxvf "$1" ;;
			(*.tar.bz2|*.tbz|*.tbz2) tar xvjf "$1" ;;
			(*.tar.xz|*.txz)
				if tar --xz --help > /dev/null 2>&1 ; then
          tar --xz -xvf "$1"
        else
          xzcat "$1" | tar xvf -
        fi
        ;;
			(*.tar.zma|*.tlz)
				if tar --lzma --help > /dev/null 2>&1 ; then
          tar --lzma -xvf "$1"
        else
          lzcat "$1" | tar xvf - 
        fi
        ;;
			(*.tar) tar xvf "$1" ;;
			(*.gz) gunzip "$1" ;;
			(*.bz2) bunzip2 "$1" ;;
			(*.xz) unxz "$1" ;;
			(*.lzma) unlzma "$1" ;;
			(*.Z) uncompress "$1" ;;
			(*.zip|*.war|*.jar|*.sublime-package|*.ipsw|*.xpi|*.apk) unzip "$1" -d "${extract_dir}" ;;
			(*.rar) unrar x -ad "$1" ;;
			(*.7z) 7za x "$1" ;;
			(*.deb)
				mkdir -p "$extract_dir/control"
				mkdir -p "$extract_dir/data"
        (cd "$extract_dir" || exit ; ar vx "../${1}" > /dev/null && \
				cd control || exit ; tar xzvf ../control.tar.gz && \
				cd ../data || exit ; extract ../data.tar.* && \
        cd .. || exit ; rm -- *.tar.* debian-binary )
			;;
			(*)
				echo "extract: '$1' cannot be extracted" >&2
				success=1
			;;
		esac

    [ "$success" -gt 0 ] && success=$success || success=$?
		[ "$success" -eq 0 ] && [ "$remove_archive" = "true" ] && rm -- "$1"
		shift
	done
}

alias x=extract

# Creates an archive (*.tar.gz) from given directory.
maketar() { tar cvzf "${1%%/}.tar.gz"  "${1%%/}/"; }

# Create a ZIP archive of a file or folder.
makezip() { zip -r "${1%%/}.zip" "$1" ; }
