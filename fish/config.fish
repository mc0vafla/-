set -gx XDG_DATA_DIRS $XDG_DATA_DIRS /var/lib/flatpak/exports/share/
set -gx EDITOR nvim
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx XDG_CURRENT_DESKTOP=wlroots
set -gx XDG_SESSION_TYPE=wayland
zoxide init fish | source
set -gx SPICETIFY_INSTALL "/home/helminth/.spicetify"
fish_add_path $SPICETIFY_INSTALL

function jj
    set container_name "alpine-permanent"
    if not podman ps -a --format "{{.Names}}" | grep -q "^$container_name\$"
        echo "❌ container $container_name was not started yet."
        return 1
    end
    
    if not podman ps --format "{{.Names}}" | grep -q "^$container_name\$"
        podman start $container_name > /dev/null 2>&1
    end
    echo "📊 Size of container (no host dirs)"
    echo "--------------------------------------------------------"
    podman exec -u root -it $container_name sh -c "
        find / -maxdepth 1 \
        -path /home -prune -o \
        -path /run -prune -o \
        -path /proc -prune -o \
        -path /sys -prune -o \
        -path /dev -prune -o \
        -exec du -sh {} + 2>/dev/null | sort -h
    "
    echo "--------------------------------------------------------"
    echo -n "📦 size of container: "
    podman ps -as --format "{{.Names}}: {{.Size}}" | grep "^$container_name:" | cut -d':' -f2
end

function j
    set container_name "alpine-permanent"
    if not podman ps -a --format "{{.Names}}" | grep -q "^$container_name\$"
        if type -q xhost
            xhost +local: > /dev/null 2>&1
            xhost +local:root > /dev/null 2>&1
        end
        podman create -it --name $container_name \
            --net=host \
            --device /dev/dri \
            --device /dev/snd \
            -v "$HOME:$HOME" \
            -v "$XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR" \
            -v "$XDG_RUNTIME_DIR/bus:$XDG_RUNTIME_DIR/bus" \
            -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
            -w "$PWD" \
            -e LANG=$LANG \
            -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
            -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
            -e DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
            -e GSETTINGS_BACKEND=keyfile \
            alpine:latest tail -f /dev/null > /dev/null 2>&1
    end
    if test (count $argv) -gt 0
        set package $argv[1]
        
        if type -q xhost
            xhost +local: > /dev/null 2>&1
            xhost +local:root > /dev/null 2>&1
        end
        if not podman ps --format "{{.Names}}" | grep -q "^$container_name\$"
            podman start $container_name > /dev/null 2>&1
        end
        podman exec -u root -it $container_name sh -c "
            if ! grep -q 'testing' /etc/apk/repositories; then
                echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories
            fi && \
            apk update && \
            apk add --no-cache hicolor-icon-theme mesa mesa-egl wayland libxkbcommon font-noto glfw $package
        "
        podman exec -it \
            -e LANG=$LANG \
            -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
            -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
            -e DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
            -e GSETTINGS_BACKEND=keyfile \
            -e HOME=$HOME \
            $container_name $package
    else
        if not podman ps --format "{{.Names}}" | grep -q "^$container_name\$"
            podman start $container_name > /dev/null 2>&1
        end
        podman exec -it -e HOME=$HOME $container_name sh
    end
end

function s
    set container_name "alpine-temporary"
    if podman ps -a --format "{{.Names}}" | grep -q "^$container_name\$"
        podman rm -f $container_name > /dev/null 2>&1
    end
    if test (count $argv) -gt 0
        set package $argv[1]
        
        if type -q xhost
            xhost +local: > /dev/null 2>&1
            xhost +local:root > /dev/null 2>&1
        end
        podman create -it --name $container_name \
            --net=host \
            --device /dev/dri \
            --device /dev/snd \
            -v "$HOME:$HOME" \
            -v "$XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR" \
            -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
            -w "$PWD" \
            -e LANG=$LANG \
            -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
            -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
            -e DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
            -e GSETTINGS_BACKEND=keyfile \
            alpine:latest tail -f /dev/null > /dev/null 2>&1
        podman start $container_name > /dev/null 2>&1
        podman exec -u root -it $container_name sh -c "
            echo 'https://dl-cdn.alpinelinux.org/alpine/edge/testing' >> /etc/apk/repositories && \
            apk update > /dev/null 2>&1 && \
            apk add --no-cache hicolor-icon-theme $package > /dev/null 2>&1
        "
        podman exec -it \
            -e LANG=$LANG \
            -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
            -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
            -e DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
            -e GSETTINGS_BACKEND=keyfile \
            -e HOME=$HOME \
            $container_name $package
        podman rm -f $container_name > /dev/null 2>&1
    else
        echo ":)"
        podman run --rm -it \
            --userns=keep-id \
            --net=host \
            --device /dev/dri \
            --device /dev/snd \
            -v "$HOME:$HOME" \
            -v "$XDG_RUNTIME_DIR:$XDG_RUNTIME_DIR" \
            -v /var/run/dbus/system_bus_socket:/var/run/dbus/system_bus_socket \
            -w "$PWD" \
            -e LANG=$LANG \
            -e WAYLAND_DISPLAY=$WAYLAND_DISPLAY \
            -e XDG_RUNTIME_DIR=$XDG_RUNTIME_DIR \
            -e DBUS_SESSION_BUS_ADDRESS=$DBUS_SESSION_BUS_ADDRESS \
            -e GSETTINGS_BACKEND=keyfile \
            alpine:latest sh
    end
end

function w
  flatpak run com.interversehq.qView $argv
end

function z
    __zoxide_z $argv
    if test $status -eq 0
        lsd -a
    end
end

function fish_prompt
    set -l last_status $status
    set -l cyan (set_color cyan)
    set -l magenta (set_color magenta)
    set -l terracotta (set_color brred)
    set -l normal (set_color normal)
    set -l prompt_status ""
    if test $last_status -ne 0
        set prompt_status (set_color red)"❯"$normal
    else
        set prompt_status "$terracotta❯$normal"
    end
    echo -n -s "$magenta"$USER" "$cyan(prompt_pwd)" "$prompt_status" "
end

function fish_right_prompt
    set -l last_status $status
    set -l cyan (set_color cyan)
    set -l normal (set_color normal)
    if fish_git_prompt > /dev/null
        echo -n -s "$cyan"(fish_git_prompt)"$normal"
    end
end

set -g fish_greeting ""
clear
fastfetch
echo ""
