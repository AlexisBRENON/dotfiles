function enrich_append {
    local flag=$1
    local text=$2
    local color=$3
    if [[ $flag != "true" ]]; then text=$(echo ${text}|sed 's/./ /g'); fi

    echo -n "${color}${text}"
}

function separating_line {
    local prompt=""
    echo $prompt
}

function last_command_status_line {
    local prompt="%{%(?.%F{green}.%F{red})%}⚡ %{%f%} "
    echo $prompt
}

function working_dir_line {
    local prompt="%n@%m %{%F{green}%}%~%{%f%}"
    echo $prompt
}

function git_line {
  build_prompt
}

# Called by Oh-my-git build_prompt function
function custom_build_prompt {
  local enabled=${1}
  local current_commit_hash=${2}
  local is_a_git_repo=${3}
  local current_branch=${4}
  local detached=${5}
  local just_init=${6}
  local has_upstream=${7}
  local has_modifications=${8}
  local has_modifications_cached=${9}
  local has_adds_cached=${10}
  local has_deletions=${11}
  local has_deletions_cached=${12}
  local has_untracked_files=${13}
  local ready_to_commit=${14}
  local tag_at_current_commit=${15}
  local is_on_a_tag=${16}
  local has_upstream=${17}
  local commits_ahead=${18}
  local commits_behind=${19}
  local has_diverged=${20}
  local should_push=${21}
  local will_rebase=${22}
  local has_stashes=${23}
  local action="${24}"
  local has_pending_action=$([[ -n "${action}" ]] && echo "true")

  local laptop_git_symbols="   :: : : :  : : : : : : : : : : : : : : :⭐ :🔧 : : : : : : : : : :⏩ : : : : : : : : : 
  local hector2_git_symbols="   :▓▒░: : : :  : : : : : : : : : : : : : : :⭐ :🔧 : : :  : : : : : :⏩ : : : : : : : :   
  if [[ $HOST = "hector2" ]]
  then
    git_symbols_array=(${(s/:/)hector2_git_symbols})
  else
    git_symbols_array=(${(s/:/)laptop_git_symbols})
  fi
  : ${omg_is_a_git_repo_symbol:=${git_symbols_array[1]}}
  : ${omg_separator_symbol:=${git_symbols_array[2]}}

  : ${omg_has_stashes_symbol:=${git_symbols_array[6]}}
  : ${omg_has_untracked_files_symbol:=${git_symbols_array[7]}}

  : ${omg_has_modifications_symbol:=${git_symbols_array[11]}}
  : ${omg_has_deletions_symbol:=${git_symbols_array[12]}}
  
  : ${omg_has_cached_modifications_symbol:=${git_symbols_array[16]}}
  : ${omg_has_cached_adds_symbol:=${git_symbols_array[17]}}
  : ${omg_has_cached_deletions_symbol:=${git_symbols_array[18]}}

  : ${omg_ready_to_commit_symbol:=${git_symbols_array[21]}}
  : ${omg_pending_action_symbol:=${git_symbols_array[22]}}

  : ${omg_detached_symbol:=${git_symbols_array[26]}}
  : ${omg_not_tracked_branch_symbol:=${git_symbols_array[27]}}

  : ${omg_has_diverged_symbol:=${git_symbols_array[31]}}
  : ${omg_can_fast_forward_symbol:=${git_symbols_array[32]}}
  : ${omg_should_push_symbol:=${git_symbols_array[33]}}

  : ${omg_rebase_tracking_branch_symbol:=${git_symbols_array[36]}}
  : ${omg_merge_tracking_branch_symbol:=${git_symbols_array[37]}}

  : ${omg_is_on_a_tag_symbol:=${git_symbols_array[41]}}

  local prompt=""

  # foreground
  local black='\e[0;30m' #]
  local red='\e[0;31m' #]
  local green='\e[0;32m' #]
  local yellow='\e[0;33m' #]
  local blue='\e[0;34m' #]
  local purple='\e[0;35m' #]
  local cyan='\e[0;36m' #]
  local white='\e[0;37m' #]
  local default='\e[0;39m' #]

  # background
  local background_black='\e[40m' #]
  local background_red='\e[41m' #]
  local background_green='\e[42m' #]
  local background_yellow='\e[43m' #]
  local background_blue='\e[44m' #]
  local background_purple='\e[45m' #]
  local background_cyan='\e[46m' #]
  local background_white='\e[47m' #]
  local background_default='\e[49m' #]

  local reset='\e[0m'     # Text Reset]'

  local black_on_white="${black}${background_white}"
  local red_on_white="${red}${background_white}"
  local white_on_yellow="${white}${background_yellow}"

  local black_on_yellow="${black}${background_yellow}"
  local red_on_yellow="${red}${background_yellow}"
  local yellow_on_red="${yellow}${background_red}"

  local black_on_red="${black}${background_red}"
  local white_on_red="${white}${background_red}"
  local red_on_default="${red}${background_default}"

  if [[ $is_a_git_repo == true ]]; then

    # on filesystem
    prompt="${black_on_white} "
    prompt+=$(enrich_append $is_a_git_repo $omg_is_a_git_repo_symbol "${black_on_white}")
    
    prompt+=$(enrich_append $has_stashes $omg_has_stashes_symbol "${black_on_white}")
    prompt+=$(enrich_append $has_untracked_files $omg_has_untracked_files_symbol "${red_on_white}")

    prompt+=$(enrich_append $has_modifications $omg_has_modifications_symbol "${red_on_white}")
    prompt+=$(enrich_append $has_deletions $omg_has_deletions_symbol "${red_on_white}")

    prompt="${prompt} ${white_on_yellow}${omg_separator_symbol}${black_on_yellow} "

    # in index
    prompt+=$(enrich_append $has_modifications_cached $omg_has_cached_modifications_symbol "${black_on_yellow}")
    prompt+=$(enrich_append $has_adds_cached $omg_has_cached_adds_symbol "${black_on_yellow}")
    prompt+=$(enrich_append $has_deletions_cached $omg_has_cached_deletions_symbol "${black_on_yellow}")

    # Operation
    prompt+=$(enrich_append $ready_to_commit $omg_ready_to_commit_symbol "${black_on_yellow}")
    prompt+=$(enrich_append $has_pending_action $omg_pending_action_symbol "${red_on_yellow}")

    prompt="${prompt} ${yellow_on_red}${omg_separator_symbol}${black_on_red} "

    # Remote
    if [[ $detached == true ]] # Detached state
    then
      prompt+=$(enrich_append $detached $omg_detached_symbol "${white_on_red}")
      prompt+=$(enrich_append $detached "(${current_commit_hash:0:7})" "${black_on_red}")
    elif [[ $has_upstream == false ]] # No upstream set
    then
      prompt+=$(enrich_append true "-- ${omg_not_tracked_branch_symbol} -- (${current_branch})" "${black_on_red}")
    else # Standard branch
      if [[ $commits_behind -gt 0 ]]; then
        prompt+=$(enrich_append true " -${commits_behind} " "${black_on_red}")
      else
        prompt+=$(enrich_append true " -- " "${black_on_red}")
      fi

      if [[ $has_diverged == true ]]
      then
        prompt+=$(enrich_append true "${omg_has_diverged_symbol}" "${white_on_red}")
      elif [[ $commits_behind -gt 0 ]]; then
        prompt+=$(enrich_append true "${omg_can_fast_forward_symbol}" "${white_on_red}")
      elif [[ $commits_ahead -gt 0 ]]; then
        prompt+=$(enrich_append true "${omg_should_push_symbol}" "${white_on_red}")
      elif [[ $commits_ahead == 0 && $commits_behind == 0 ]]; then
        prompt+=$(enrich_append true "  " "${white_on_red}")
      fi

      if [[ $commits_ahead -gt 0 ]]; then
        prompt+=$(enrich_append true " +${commits_ahead} " "${black_on_red}")
      else
        prompt+=$(enrich_append true " -- " "${black_on_red}")
      fi

      if [[ $will_rebase == true ]]
      then
        local type_of_upstream=${omg_rebase_tracking_branch_symbol}
      else
        local type_of_upstream=${omg_merge_tracking_branch_symbol}
      fi
      prompt+=$(enrich_append true "(${current_branch} ${type_of_upstream} ${upstream//\/$current_branch/})" "${black_on_red}")
    fi
    prompt+=$(enrich_append ${is_on_a_tag} "${omg_is_on_a_tag_symbol} ${tag_at_current_commit}" "${black_on_red}")

    prompt+="${red_on_default}${omg_separator_symbol}${reset}"
    echo "${prompt}"
    return 0
  else
    return 1
  fi
}

function echo_prompt {
   local prompt=""
   prompt+="$(git_line)\n"
   prompt+="$(working_dir_line)\n"
   prompt+="$(last_command_status_line)"
   prompt=$(echo $prompt | sed '/^\s*$/d')

   separating_line
   echo "$prompt"
}

function update_prompt {
    PS1="$(echo_prompt)"
}

autoload -U add-zsh-hook
add-zsh-hook precmd update_prompt
