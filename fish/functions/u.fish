function u --wraps='doas apk update; doas apk upgrade' --description 'alias u=doas apk update; doas apk upgrade'
    doas apk update; doas apk upgrade $argv
end
