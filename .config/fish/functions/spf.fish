function spf --description "Launch superfile and cd to the last directory on quit"
    # 定义临时文件路径
    set -gx SPF_LAST_DIR "$HOME/.local/state/superfile/lastdir"
    
    # 确保目录存在
    mkdir -p (dirname "$SPF_LAST_DIR")

    # 运行真正的 spf 二进制文件
    command spf $argv

    # 检查临时文件是否存在
    if test -f "$SPF_LAST_DIR"
        # 这里的临时文件内容实际上是 'cd "/your/path"'
        # 在 Fish 中直接 source 它即可执行 cd 命令
        source "$SPF_LAST_DIR"
        
        # 清理临时文件
        rm -f "$SPF_LAST_DIR"
    end
end
