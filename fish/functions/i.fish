function i --wraps='doas apk add' --wraps='doas apk add --allow-untrusted' --description 'alias i=doas apk add'
    doas apk add $argv
end
