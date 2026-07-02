function t --wraps='flatpak list | grep' --description 'alias t=flatpak list | grep'
    flatpak list | grep $argv
end
