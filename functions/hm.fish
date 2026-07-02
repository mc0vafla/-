function hm --wraps='noctalia msg --help | grep' --description 'alias hm=noctalia msg --help | grep'
    noctalia msg --help | grep $argv
end
