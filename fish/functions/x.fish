function x --wraps=ncdu --wraps='ping 1.1.1.1' --description 'alias x=ping 1.1.1.1'
    ping 1.1.1.1 $argv
end
