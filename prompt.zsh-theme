# threshold (sec) for showing cmd exec time
CMD_MAX_EXEC_TIME=5

# displays the exec time of the last command if set threshold was exceeded
cmd_exec_time() {
    local stop=`date +%s`
    local start=${cmd_timestamp:-$stop}
    let local elapsed=$stop-$start
    [ $elapsed -gt $CMD_MAX_EXEC_TIME ] && echo ${elapsed}s
    unset cmd_timestamp
}

preexec() {
    cmd_timestamp=`date +%s`
}

PROMPT=$'%{$fg[blue]%}%~%{$reset_color%} %{$fg_bold[black]%}$(git_prompt_info)%{$reset_color%} %{$fg_bold[black]%}%n@%m%{$reset_color%} %{$fg[yellow]%}`cmd_exec_time`%{$reset_color%}\
%(?.%F{magenta}.%F{red})❯%f '

ZSH_THEME_GIT_PROMPT_PREFIX="%{$fg[black]%}"
ZSH_THEME_GIT_PROMPT_SUFFIX="%{$reset_color%}"
ZSH_THEME_GIT_PROMPT_DIRTY="*"
ZSH_THEME_GIT_PROMPT_CLEAN=""
