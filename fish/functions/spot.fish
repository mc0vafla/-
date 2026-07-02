function spot --wraps='flatpak run com.spotify.Client --audio-api=pulseaudio' --description 'alias spot=flatpak run com.spotify.Client --audio-api=pulseaudio'
    flatpak run com.spotify.Client --audio-api=pulseaudio $argv
end
