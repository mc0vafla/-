function u --wraps='doas apk update; doas apk upgrade; flatpak update' --wraps='doas apk update --allow-untrusted; doas apk upgrade --allow-untrusted; flatpak update' --description 'alias u=doas apk update --allow-untrusted; doas apk upgrade --allow-untrusted; flatpak update'
    doas apk update --allow-untrusted; doas apk upgrade --allow-untrusted; flatpak update $argv
end
