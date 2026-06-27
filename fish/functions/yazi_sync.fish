if not test -p ~/.cache/sidebar_pipe
    mkdir -p ~/.cache
    mkfifo ~/.cache/sidebar_pipe
end

function yazi_sync --on-variable PWD
    if set -q ZELLIJ
        echo "$PWD" > ~/.cache/sidebar_pipe &
    end
end

if set -q ZELLIJ; and not set -q SIDEBAR_INITIALIZED
    set -g SIDEBAR_INITIALIZED 1
    sleep 0.2
    zellij action write-chars --pane-name yazi_sidebar "clear; while read -l target_dir < ~/.cache/sidebar_pipe; clear; lsd --color=always -G \$target_dir; end
"
    sleep 0.2
    echo "$PWD" > ~/.cache/sidebar_pipe &
end
