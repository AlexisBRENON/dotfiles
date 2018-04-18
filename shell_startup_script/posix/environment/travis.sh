#! /bin/sh

if test -n "${TRAVIS_HOME}" -a -f "${TRAVIS_HOME}/travis.sh"; then

  DEBUG "Sourcing travis init script: ${TRAVIS_HOME}/travis.sh"
  . "${TRAVIS_HOME}/travis.sh"
fi
