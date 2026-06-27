function i --wraps='doas apk add' --description 'alias i=doas apk add'
    doas apk add $argv
end
