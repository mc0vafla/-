function ii --wraps='flatpak install' --wraps='flatpak install -u' --description 'alias ii=flatpak install'
    flatpak install $argv
end
