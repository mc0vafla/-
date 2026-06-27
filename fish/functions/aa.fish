function aa --wraps='doas umount /dev/sda1' --wraps='cd ~/; doas umount /dev/sda1' --description 'alias aa=cd ~/; doas umount /dev/sda1'
    cd ~/; doas umount /dev/sda1 $argv
end
