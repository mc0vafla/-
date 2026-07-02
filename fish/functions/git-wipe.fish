function git-wipe --wraps='rm -rf .git; git init' --description 'alias git-wipe=rm -rf .git; git init'
    rm -rf .git; git init $argv
end
