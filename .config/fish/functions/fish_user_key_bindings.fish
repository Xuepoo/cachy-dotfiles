function fish_user_key_bindings
    # 将 jk 绑定为切换到 default (Normal) 模式
    # -M insert: 指定在 Insert 模式下生效
    # -m default: 动作完成后切换到 default 模式
    bind -M insert -m default jk backward-char force-repaint
    bind -M insert \cf accept-autosuggestion
    bind -M insert \ca beginning-of-line
    bind -M insert \ce end-of-line
    bind -M insert \cp up-or-search
    bind -M insert \cn down-or-search

    bind -M insert \ch backward-char
    bind -M insert \cl forward-char

    bind -M insert \cb backward-word
    bind -M insert \cn forward-word

    bind -M insert \cw kill-word
end
