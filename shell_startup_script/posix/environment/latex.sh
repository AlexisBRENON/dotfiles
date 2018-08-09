#!/bin/sh

export TEXMFHOME="${HOME}/.local/share/texmf"

if [ -d "${HOME}/.local/texlive/2018/bin" ]; then
  export PATH="${HOME}/.local/texlive/2018/bin/x86_64-linux:${HOME}/.local/texlive/2018/bin:${PATH}"
fi
