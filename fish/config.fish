set -gx XDG_DATA_DIRS $XDG_DATA_DIRS /var/lib/flatpak/exports/share/
set -x XDG_DATA_DIRS $XDG_DATA_DIRS ~/.local/share/flatpak/exports/share:/var/lib/flatpak/exports/share
set -gx EDITOR nvim
set -gx LANG en_US.UTF-8
set -gx LC_ALL en_US.UTF-8
set -gx XDG_CURRENT_DESKTOP=wlroots
set -gx XDG_SESSION_TYPE=wayland
zoxide init fish | source
set -gx SPICETIFY_INSTALL "/home/helminth/.spicetify"
fish_add_path $SPICETIFY_INSTALL

if test "$TERM" = "linux"
    echo -en "\e]P02d353b" 
    echo -en "\e]P1e67e80" 
    echo -en "\e]P2a7c080" 
    echo -en "\e]P3dbbc7f" 
    echo -en "\e]P47fbbb3" 
    echo -en "\e]P5d699b6" 
    echo -en "\e]P683c092" 
    echo -en "\e]P7d3c6aa" 
    echo -en "\e]P83d484d" 
    echo -en "\e]P9e67e80" 
    echo -en "\e]PAa7c080" 
    echo -en "\e]PBdbbc7f"
    echo -en "\e]PC7fbbb3" 
    echo -en "\e]PDd699b6"
    echo -en "\e]PE83c092" 
    echo -en "\e]PFe6e2cc" 
    clear
end

function 321
    sync
    doas sh -c "echo u > /proc/sysrq-trigger"
    sleep 0.5
    doas sh -c "echo b > /proc/sysrq-trigger"
end

function mm 
    if test (count $argv) -gt 0
        nvim $argv -c "lua vim.schedule(function() vim.lsp.buf.format({async = true}); vim.cmd('Telescope find_files hidden=true no_ignore=true') end)"
    else
        nvim -c "lua vim.defer_fn(function() vim.cmd('Telescope find_files hidden=true no_ignore=true') end, 10)"
    end
end

function z
    __zoxide_z $argv
    if test $status -eq 0
        lsd -a
    end
end

function fish_prompt
    set -l last_status $status
    set -l blue (set_color blue)
    set -l magenta (set_color magenta)
    set -l terracotta (set_color brred)
    set -l normal (set_color normal)
    set -l prompt_status ""
    if test $last_status -ne 0
        set prompt_status (set_color red)"❯"$normal
    else
        set prompt_status "$terracotta❯$normal"
    end
    echo -n -s "$magenta"$USER" "$blue(prompt_pwd)" "$prompt_status" "
end

function fish_right_prompt
    set -l last_status $status
    set -l pink (set_color FF69B4)
    set -l normal (set_color normal)
    if fish_git_prompt > /dev/null
        echo -n -s "$pink"(fish_git_prompt)"$normal"
    end
end

set -g fish_greeting ""
clear
fastfetch
echo ""
