ZSH_THEME_GIT_PROMPT_PREFIX="git("
ZSH_THEME_GIT_PROMPT_SUFFIX=")tig"
ZSH_THEME_GIT_PROMPT_DIRTY=":dirty:"
ZSH_THEME_GIT_PROMPT_CLEAN=":clean:"
ZSH_THEME_GIT_PROMPT_STASHED=":stashed:"
ZSH_THEME_GIT_PROMPT_UNTRACKED=":untracked:"
ZSH_THEME_GIT_PROMPT_MODIFIED=":modified:"
ZSH_THEME_GIT_PROMPT_ADDED=":added:"
ZSH_THEME_GIT_PROMPT_DELETED=":deleted:"

ZSH_THEME_GIT_PROMPT_BEHIND_REMOTE=":behind-remote:"
ZSH_THEME_GIT_PROMPT_AHEAD_REMOTE=":ahead-remote:"
ZSH_THEME_GIT_PROMPT_DIVERGED_REMOTE=":diverged-remote:"

function contains () {
    local string="$1"
        local substring="$2"
        if test "${string#*$substring}" != "$string"
            then
            echo "true"    # $substring is in $string
            return 0
        else
            echo "false"    # $substring is not in $string
            return 1
        fi

}

function enrich_append {
    local flag=$1
    local text=$2
    local color=$3
    if [[ $flag != "true" ]]; then text=' '; fi

    echo -n "${color}${text}  "
}

function separating_line {
    local prompt=""
    echo $prompt
}

function last_command_status_line {
    local prompt="%{%(?.%F{green}.%F{red})%}⚡%{%f%} "
    echo $prompt
}

function working_dir_line {
    local prompt="%n@%m %{%F{green}%}%~%{%f%}"
    echo $prompt
}

function git_line {
    # Don't display anything if not in a git repo
    local repo_url="$(current_repository)"
    if test -z ${repo_url}
        then
        return 1
    fi
    
    : ${git_prompt_is_a_git_repo_symbol:=''}
    : ${git_prompt_has_stashes_symbol:=''}
    : ${git_prompt_has_untracked_files_symbol:=''}
    : ${git_prompt_has_modifications_symbol:=''}
    : ${git_prompt_has_deletions_symbol:=''}
    : ${git_prompt_has_adds_symbol:=''}
    : ${git_prompt_has_cached_deletions_symbol:=''}
    : ${git_prompt_has_cached_modifications_symbol:=''}
    : ${git_prompt_ready_to_commit_symbol:=''}

    : ${git_prompt_has_diverged_symbol:=''}
    : ${git_prompt_should_push_symbol:=''}
    : ${git_prompt_is_on_a_tag_symbol:=''}
#    : ${git_prompt_needs_to_merge_symbol:=''}
#    : ${git_prompt_detached_symbol:=''}
#    : ${git_prompt_can_fast_forward_symbol:=''}
#    : ${git_prompt_not_tracked_branch_symbol:=''}
#    : ${git_prompt_rebase_tracking_branch_symbol:=''}
#    : ${git_prompt_merge_tracking_branch_symbol:=''}
#    : ${git_prompt_has_action_in_progress_symbol:=''}

    local git_status=$(git_prompt_status)
    local has_stashes=$(contains $git_status \
                                ${ZSH_THEME_GIT_PROMPT_STASHED})
    local has_untracked_files=$(contains $git_status \
                                ${ZSH_THEME_GIT_PROMPT_UNTRACKED})
    local has_modifications=$(contains $git_status \
                            ${ZSH_THEME_GIT_PROMPT_MODIFIED})
    local has_deletions=$(contains $git_status \
                        ${ZSH_THEME_GIT_PROMPT_DELETED})
    local has_adds=$(contains $git_status \
                    ${ZSH_THEME_GIT_PROMPT_ADDED})
    local has_modifications_cached="false" # TODO
    local has_deletions_cached="false" # TODO
    local ready_to_commit="false" # TODO
#    local action=${24}
    
    local detached="false" # TODO
    local remote_git_status=$(git_remote_status)
    local has_upstream=$(contains $remote_git_status \
                        "-remote:")
    local has_diverged=$(contains $remote_git_status \
                        ${ZSH_THEME_GIT_PROMPT_DELETED})
    local commits_ahead=$(git_commits_ahead)
    local commits_behind="?" # TODO
    local current_branch=$(current_branch)
    local will_rebase="false" # TODO

    local is_on_a_tag="false" #TODO
    #local tag_at_current_commit="false" # TODO

    local prompt=""

    local black_on_white="%K{white}%F{black}"
    local yellow_on_white="%K{white}%F{yellow}"
    local red_on_white="%K{white}%F{red}"
    local red_on_black="%K{black}%F{red}"
    local black_on_red="%K{red}%F{black}"
    local white_on_red="%K{red}%F{white}"
    local yellow_on_red="%K{red}%F{yellow}"

## on filesystem
    prompt="${black_on_white} ${git_prompt_is_a_git_repo_symbol}  "
    prompt+=$(enrich_append $has_stashes \
            ${git_prompt_has_stashes_symbol} \
            "${black_on_white}")
    prompt+=$(enrich_append $has_untracked_files \
            ${git_prompt_has_untracked_files_symbol} \
            "${red_on_white}")
    prompt+=$(enrich_append $has_modifications \
            ${git_prompt_has_modifications_symbol} \
            "${red_on_white}")
    prompt+=$(enrich_append $has_deletions \
            ${git_prompt_has_deletions_symbol} \
            "${red_on_white}")

## ready
    prompt+=$(enrich_append $has_adds \
            ${git_prompt_has_adds_symbol} \
            "${black_on_white}")
    prompt+=$(enrich_append $has_modifications_cached \
            ${git_prompt_has_cached_modifications_symbol} \
            "${black_on_white}")
    prompt+=$(enrich_append $has_deletions_cached \
            ${git_prompt_has_cached_deletions_symbol} \
            "${black_on_white}")

## next operation
    prompt+=$(enrich_append $ready_to_commit \
            ${git_prompt_ready_to_commit_symbol} \
            "${red_on_white}")
#                prompt+=$(enrich_append $action "${git_prompt_has_action_in_progress_symbol} $action" "${red_on_white}")

## where
    prompt="${prompt} ${white_on_red} ${black_on_red}"
    if [[ $detached == "true" ]]; then
        prompt+=$(enrich_append $detached \
                ${git_prompt_detached_symbol} \
                "${white_on_red}")

                prompt+=$(enrich_append $detached \
                        "(${current_commit_hash:0:7})"
                        "${black_on_red}")
    else            
        if [[ $has_upstream != "true" ]]; then
            prompt+=$(enrich_append "true" \
                    "-- ${git_prompt_not_tracked_branch_symbol}  --  (${current_branch})" \
                    "${black_on_red}")
        else
            if [[ $will_rebase == "true" ]]; then
                local type_of_upstream=${git_prompt_rebase_tracking_branch_symbol}
            else
                local type_of_upstream=${git_prompt_merge_tracking_branch_symbol}
            fi

            if [[ $has_diverged == "true" ]]; then
                prompt+=$(enrich_append "true" \
                        "-${commits_behind} ${git_prompt_has_diverged_symbol} +${commits_ahead}" \
                        "${white_on_red}")
            else
                if [[ $commits_behind -gt 0 ]]; then
                    prompt+=$(enrich_append "true" \
                            "-${commits_behind} %F{white}${git_prompt_can_fast_forward_symbol}%F{black}--" \
                            "${black_on_red}")
                fi
                if [[ $commits_ahead -gt 0 ]]; then
                    prompt+=$(enrich_append "true" \
                            "-- %F{white}${git_prompt_should_push_symbol}%F{black}  +${commits_ahead}" \
                            "${black_on_red}")
                fi
                if [[ $commits_ahead == 0 && $commits_behind == 0 ]]; then
                    prompt+=$(enrich_append "true" \
                            " --   -- " \
                            "${black_on_red}")
                fi
            fi
            prompt+=$(enrich_append "true" \
                    "(${current_branch} ${type_of_upstream} ${upstream//\/$current_branch/})" \
                    "${black_on_red}")
        fi
    fi
    prompt+=$(enrich_append ${is_on_a_tag} \
            "${git_prompt_is_on_a_tag_symbol} ${tag_at_current_commit}" \
            "${black_on_red}")
    prompt+="%k%F{red}%k%f"

    echo ${prompt}
    return 0
}


function echo_prompt {
   separating_line
   git_line
   working_dir_line
   last_command_status_line
}

function update_prompt {
    PS1="$(echo_prompt)"
}

autoload -U add-zsh-hook
add-zsh-hook precmd update_prompt
