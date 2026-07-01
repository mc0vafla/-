function del --wraps='doas apk del --allow-untrusted' --description 'alias del=doas apk del --allow-untrusted'
    doas apk del --allow-untrusted $argv
end
