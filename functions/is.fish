function is --wraps='apk list | grep' --wraps='apk search --allow-untrusted' --description 'alias is=apk list | grep'
    apk list | grep $argv
end
