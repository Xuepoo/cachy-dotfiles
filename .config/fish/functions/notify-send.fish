function notify-send --description 'Wrap notify-send to forward to ntfy.sh'
    # 1. 调用系统原生的 notify-send
    command notify-send $argv

    # 2. 提取参数：过滤掉以 '-' 开头的 flag
    set -l msg_parts
    for arg in $argv
        # 【关键修复】使用 -- 强制中止选项解析，使 "-*" 作为纯字符串模式传入
        if not string match -q -- "-*" $arg
            set -a msg_parts $arg
        end
    end

    # 3. 解析标题和正文
    set -l title "Terminal"
    set -l body "Task completed"
    
    if test (count $msg_parts) -ge 2
        set title $msg_parts[1]
        set body $msg_parts[2]
    else if test (count $msg_parts) -eq 1
        set body $msg_parts[1]
    end

    # 4. 异步调用 curl 发送到 ntfy (请替换 YOUR_TOPIC_NAME)
    curl -s -H "Title: $title" -d "$body" "ntfy.sh/xuepoo" > /dev/null 2>&1 &
end
