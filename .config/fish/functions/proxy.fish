function proxy --description "Toggle network proxy for current session"
    set -l proxy_host "127.0.0.1"
    if test "$argv[1]" = "on"
        # 默认端口设置 (如果不加任何参数，默认使用 clash 的 7897)
        set -l proxy_port "7897"
        # 如果传入了第二个参数，判断是具体端口号还是别名
        if test (count $argv) -ge 2
            switch "$argv[2]"
                case clash
                    set proxy_port "7897"
                case xxf
                    set proxy_port "6294"
                case v2ray
                    set proxy_port "7890"
                case '*'
                    # 如果不是上面的别名，就假设传入的是具体的数字端口号
                    set proxy_port $argv[2]
            end
        end
        set -l proxy_addr "http://$proxy_host:$proxy_port"
        # 设置环境变量 (使用 -gx 代表 Global 和 Export)
        set -gx http_proxy  $proxy_addr
        set -gx https_proxy $proxy_addr
        set -gx ftp_proxy   $proxy_addr
        set -gx all_proxy   "socks5://$proxy_host:$proxy_port" # 很多现代工具更喜欢走 socks5，这里顺便帮你把 all_proxy 优化为 socks5
        set -gx no_proxy    "localhost,127.0.0.1,localaddress,.localdomain.com"
        git config --global http.proxy  $proxy_addr
        git config --global https.proxy $proxy_addr
        echo "✅ Proxy enabled: $proxy_addr"
    else if test "$argv[1]" = "off"
        # 清除环境变量
        set -e http_proxy
        set -e https_proxy
        set -e ftp_proxy
        set -e all_proxy
        set -e no_proxy
        git config --global --unset http.proxy
        git config --global --unset https.proxy
        echo "❌ Proxy disabled"
    else
        echo "Usage: proxy [on [port|clash|xxf|v2ray] | off]"
        echo "Current status: "(set -q http_proxy; and echo "ON ($http_proxy)"; or echo "OFF")
    end
end
