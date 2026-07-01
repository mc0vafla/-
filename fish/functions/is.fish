function is --wraps='apk list | grep' --wraps='apk search --allow-untrusted' --description 'alias is=apk search --allow-untrusted'
    apk search --allow-untrusted $argv
end
