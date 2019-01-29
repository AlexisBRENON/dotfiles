#!/bin/sh

endpoint="${PB_ENDPOINT:-https://ptpb.pw}"
jq_args="${PB_JSON:--r .url}"
private="${PB_PRIVATE:-0}"
clipboard="${PB_CLIPBOARD}"
clipboard_tool="${PB_CLIPBOARD_TOOL:-xclip}"

_pb () {
  local filename extension

  filename="${1:--}"
  extension="${2:-}"

  shift 2

  data=$(curl -sF "c=@$filename" -F "f=-$extension" -F "p=$private" \
           -H 'accept: application/json' "$@" "$endpoint" | jq $jq_args)
  if [[ ! -z $clipboard ]]; then
    printf "${data}" | "${clipboard_tool}"
  fi
  echo "${data}"
}

_pb_png () {
  maim -s | _pb - .png
}

_pb_gif () {
  capture gif - | _pb - .gif
}

_pb_webm () {
  capture webm - | _pb - .webm
}

pastebin () {
  local command="$1"

  case $command in
    png)
      shift
      _pb_png "$@"
      ;;
    gif)
      shift
      _pb_gif "$@"
      ;;
    webm)
      shift
      _pb_webm "$@"
      ;;
    private)
      shift
      private=1
      _pb "$@"
      ;;
    *)
      _pb "$@"
      ;;
  esac
}

