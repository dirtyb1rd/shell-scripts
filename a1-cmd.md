# a1-cmd

### Commands, often with arguments, that I might easily forget, but wish to remember.

- `tree -aI .git`
    - `a`: show hidden files (. prefix)
    - `I`: exclude the following directory (.git)
- `tail -f /some/file | bat --paging=never -l log`
    - follow logs (or anything) with syntax highlighting
- `cd -`
    - `-` acts as an alias to `$OLDPWD`
    - `$OLDPWD` returns the previous working directory
- `python3 -m http.server --bind 127.0.0.1 8080`
    - serves working directory via http, only available to localhost/loopback
        - to serve to local network, omit `--bind 127.0.0.1`
    - `python3 -m http.server` runs python3 http.server module
    - `--bind 127.0.0.1` restricts the server to localhost/loopback
    - `8080` specifies port number
