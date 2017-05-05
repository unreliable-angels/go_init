function go_init -d 'Initialize Go environment along with setting GOPATH'
    type go >/dev/null ^/dev/null
    set -l rc $status

    set -l filename (basename (status -f))

    if not test $rc = 0
        echo $filename: (set_color red)go executable is not found.(set_color normal)
        return 1
    end

    if not set -q GOPATH
        set -l default_location "$HOME/go"
        echo $filename: (set_color yellow)GOPATH is not set.(set_color normal)
        echo $filename: (set_color green)Setting GOPATH to the default location [$default_location](set_color normal)
        set -U GOPATH $default_location
    end

    if not test -d "$GOPATH"
        echo $filename: (set_color green)Creating the GOPATH directory [$default_location](set_color normal)
        mkdir "$GOPATH"
    end

    for path in "$GOPATH" "$GOPATH/bin"
    	if not contains "$path" $fish_user_paths
            set -U fish_user_paths "$path" $fish_user_paths
    	end
    end
end
