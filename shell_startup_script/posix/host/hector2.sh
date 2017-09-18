#! /bin/sh

. "${HOME}/torch/install/bin/torch-activate"
export LUA_PATH="./?.lua;./?/init.lua;$LUA_PATH"

export TEXMFHOME="${HOME}/.local/texlive/2016/texmf-dist/"
export PATH="/home/brenon/.local/texlive/2016/bin/x86_64-linux:${PATH}"
export PATH="/home/brenon/.local/bin:${PATH}"

export ARCADES_HOME="/home/brenon/Documents/thesis/SmartHome/Arcades/src"
arcades() {
  # Expand ARCADES_HOME on call
  TREPL_HISTORY="${TREPL_HISTORY:-${ARCADES_HOME}/.history}" th -i -e "package.path = '${ARCADES_HOME}/src/?.lua;${ARCADES_HOME}/src/?/init.lua;${ARCADES_HOME}/?/init.lua;' .. package.path"
}
