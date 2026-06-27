set -gx XDG_DATA_DIRS $XDG_DATA_DIRS /var/lib/flatpak/exports/share/
set -gx EDITOR nvim
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
zoxide init fish | source
set -gx SPICETIFY_INSTALL "/home/helminth/.spicetify"
fish_add_path $SPICETIFY_INSTALL

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
