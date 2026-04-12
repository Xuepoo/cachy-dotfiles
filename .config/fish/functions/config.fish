function config --wraps='config=/usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME' --wraps=git --description 'alias config git --git-dir=$HOME/.cfg/ --work-tree=$HOME'
    /usr/bin/git --git-dir=$HOME/.cfg/ --work-tree=$HOME $argv
end
