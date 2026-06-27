function p --wraps='nvim /etc/apk/work' --wraps='doas nvim /etc/apk/work' --wraps='nvim /etc/apk/world' --description 'alias p=nvim /etc/apk/world'
    nvim /etc/apk/world $argv
end
