#! /bin/sh

py_activate() {
  version="${1:-""}"
  project="${2:-.}"

  venvs="venv:.venv"
  for venv in $(echo "${venvs}" | tr ":" " "); do
      if [ -e "${project}/${venv}${version}/bin/activate" ]; then
            . "${project}/${venv}${version}/bin/activate"
            found=true
            break
      fi
  done
  if [[ "${found}" != "true" ]]; then
    echo "No virtual environment found." >&2
  fi
  unset version project venvs found
}

# Serve the directory locally
alias http-serve='python3 -m http.server'
