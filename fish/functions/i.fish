function i --wraps='doas apk add' --wraps='doas apk add --allow-untrusted' --description 'alias i=doas apk add --allow-untrusted'
    doas apk add --allow-untrusted $argv
end
