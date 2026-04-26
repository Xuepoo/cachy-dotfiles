function osu --description 'Launch osu!lazer on Discrete GPU'
    # 纯独显模式下，直接启动即可，它会自然而然地获得最高性能
    uwsm app -- osu-lazer > /dev/null 2>&1 &
end