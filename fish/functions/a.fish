function a --wraps='doas mount /dev/sda1 /mnt; cd /mnt/data' --description 'alias a=doas mount /dev/sda1 /mnt; cd /mnt/data'
    doas mount /dev/sda1 /mnt; cd /mnt/data $argv
end
