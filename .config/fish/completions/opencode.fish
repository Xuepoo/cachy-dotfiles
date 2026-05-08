# 禁用默认的文件补全 (若 yargs 未返回匹配项则不显示文件)
# 如果希望在没有命令匹配时显示文件名，可以移除 -f 参数
complete -c opencode -f

# 定义补全函数
function _opencode_prepare_completions
    # 获取当前命令行已输入的 token 列表
    set -l tokens (commandline -opc)
    
    # 如果当前正在输入一个新 token（末尾有空格），添加一个空字符串代表当前位置
    if commandline -ct | string match -qv ""
        # 正在输入某个 token 中
    else
        set tokens $tokens ""
    end

    # 调用 opencode 获取 yargs 补全建议
    opencode --get-yargs-completions $tokens
end

# 注册补全
complete -c opencode -a "(_opencode_prepare_completions)"
