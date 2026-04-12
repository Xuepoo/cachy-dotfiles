function proxy --description "Toggle network proxy for current session"
    # 根据你的代理软件设置端口（常用：Clash 7897, V2Ray 1080）
    set -l proxy_host "127.0.0.1"
    set -l proxy_port "7897"
    set -l proxy_addr "http://$proxy_host:$proxy_port"

    if test "$argv[1]" = "on"
        # 设置环境变量 (使用 -gx 代表 Global 和 Export)
        set -gx http_proxy  $proxy_addr
        set -gx https_proxy "https://$proxy_host:$proxy_port"
        set -gx ftp_proxy   $proxy_addr
        set -gx all_proxy   "socks5://$proxy_host:$proxy_port"
        set -gx no_proxy    "localhost,127.0.0.1,localaddress,.localdomain.com"

	git config --global http.proxy $proxy_addr
	git config --global https.proxy $proxy_addr
        
        echo "✅ Proxy enabled: $proxy_addr"
        # 测试连接速度 (可选)
	# curl -I --connect-timeout 2 https://www.google.com > /dev/null
	# if test $status -eq 0
	# echo "🚀 Connection to Google successful!"
	# else
	# echo "⚠️ Proxy set but Google is unreachable."
	# end

    else if test "$argv[1]" = "off"
        # 清除环境变量
        set -e http_proxy
        set -e https_proxy
        set -e ftp_proxy
        set -e all_proxy
        set -e no_proxy
        echo "❌ Proxy disabled"

    else
        echo "Usage: proxy [on|off]"
        echo "Current status: "(set -q http_proxy; and echo "ON ($http_proxy)"; or echo "OFF")
    end
end
