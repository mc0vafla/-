function del --description 'alias del=doas apk del'
    doas apk del $argv
end
