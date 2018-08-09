#! /bin/sh

py_activate() {
  project="${1:-.}"
  if [ -e "${project}/venv/bin/activate" ]; then
    . "${project}/venv/bin/activate"
  else
    echo "No virtual environment found." >&2
  fi
  unset project
}

# Serve the directory locally
alias http-serve='python3 -m http.server'
