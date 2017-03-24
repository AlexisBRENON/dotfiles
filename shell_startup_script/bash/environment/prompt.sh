#! /usr/bin/env bash

# TODO: uniformize with ZSH prompt

working_directory() {
  dir="$PWD"
  if [[ ${PWD} =~ ^"$HOME"(/|$) ]]; then
    dir="~${dir#$HOME}"
  fi

  workingdir=""
  first="/$(echo "${dir}" | cut -d / -f 2)"
  beginning="${first}"
  end=$(echo "${dir}" | rev | cut -d / -f1 | rev)
  if [[ "$dir" =~ "~"$ ]]; then
    workingdir="$dir"
  elif [[ "$first" =~ /$end ]]; then
    workingdir="$dir"
  elif [[ "$dir" =~ $first/$end ]]; then
    workingdir="$dir"
  else
    workingdir="$beginning/…/$end"
  fi

  echo -e "$workingdir"
}

create_prompt()
{
  lastCommandReturn=$?
  fullWidth=${COLUMNS}
  myUsername=${USER}
  myHostname=${HOSTNAME}
  if [ ${fullWidth} -gt 80 ]; then
    currentDate="$(date +'%x %X')"
  else
    myUsername="${myUsername:0:1}$(echo "${myUsername:1}" | tr -d "AaEeIiOoUuYy")"
    myHostname="${myHostname:0:1}$(echo "${myHostname:1}" | tr -d "AaEeIiOoUuYy")"
    currentDate="$(date +'%d/%m %R')"
  fi

  # Without Colors
  leftPart="${myUsername}@${myHostname} "
  middlePart=" $(working_directory) "
  rightPart=" ${currentDate}"

  let fillSize="${fullWidth}-(\
    ${#leftPart}+\
    ${#middlePart}+\
    ${#rightPart})"

  # Add colors
  leftPart="${SU}${myUsername}${ColorReset}@${CNX}${myHostname}${ColorReset} "
  middlePart=" ${Yellow}$(working_directory)${ColorReset} "
  rightPart=" ${Black}${currentDate}${ColorReset}"
  if [ $lastCommandReturn -eq 0 ]; then
    fillColor="${Green}"
  else
    fillColor="${Red}"
  fi

  fullFill="---------------------------------------------------------------------------------------------------------------------------------------------------------------------------"
  if [ "$fillSize" -gt 0 ]
  then
    #   It's theoretically possible someone could need more 
    #   dashes than above, but very unlikely!  HOWTO users, 
    #   the above should be ONE LINE, it may not cut and
    #   paste properly
    fillLeft=$(( ( fillSize / 2 ) - 1 ))
    fillRight=$(( fillSize - fillLeft ))

    fill="${fullFill:0:${fillLeft}}"
    PS1="\n${leftPart}${fillColor}${fill}${ColorReset}${middlePart}"
    fill="${fullFill:0:${fillRight}}"
    PS1="${PS1}${fillColor}${fill}${ColorReset}${rightPart}\n: "
  else
    fill="${fullFill:0:${fullWidth}}"
    PS1="\n${fillColor}${fill}${ColorReset}\n\[${leftPart}:${middlePart}]\$\n"
  fi
}  

PROMPT_COMMAND="create_prompt"
