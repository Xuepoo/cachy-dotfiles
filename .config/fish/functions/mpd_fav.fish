# ~/.config/fish/functions/mpd_fav.fish
function mpd_fav --description "Add current MPD song to a playlist with deduplication"
    # 1. 变量初始化
    set -l playlist_dir "$HOME/.config/mpd/playlists"
    set -l playlist_name "Vocal"
    
    # 2. 处理参数：如果提供参数则使用，否则默认为 Favorites
    if set -q argv[1]
        set playlist_name $argv[1]
    end
    
    set -l target_file "$playlist_dir/$playlist_name.m3u"
    
    # 3. 获取当前歌曲路径 (相对于 MPD music_directory)
    set -l current_song (mpc current -f "%file%")
    
    # 安全检查：如果没有音乐在播放则退出
    if test -z "$current_song"
        notify-send "MPD Error" "No song is currently playing." -u critical
        return 1
    end

    # 4. 环境准备：确保目录存在
    if not test -d "$playlist_dir"
        mkdir -p "$playlist_dir"
    end

    # 5. 核心逻辑：查重与添加
    # 使用 grep -qFx 确保匹配整行且不使用正则解析文件名中的特殊字符
    if test -f "$target_file"
        if rg -qFx "$current_song" "$target_file"
            notify-send "MPD" "Song already exists in [$playlist_name]"
            return 0
        end
    end

    # 追加写入并发送通知
    echo "$current_song" >> "$target_file"
    notify-send "MPD" "Added to [$playlist_name]:\n$current_song"
end
