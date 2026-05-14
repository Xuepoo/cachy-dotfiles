complete -c opencode -f

function _opencode_prepare_completions
    set -l tokens (commandline -opc)
    
    # 如果当前正在输入一个新 token（末尾有空格），添加一个空字符串代表当前位置
    if commandline -ct | string match -qv ""
    else
        set tokens $tokens ""
    end

    opencode --get-yargs-completions $tokens
end

complete -c opencode -a "(_opencode_prepare_completions)"
