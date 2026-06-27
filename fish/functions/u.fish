function u --wraps='doas apk update; doas apk upgrade; flatpak update' --description 'alias u=doas apk update; doas apk upgrade; flatpak update'
    doas apk update; doas apk upgrade; flatpak update $argv
end
