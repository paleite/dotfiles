function load_goroot() {
  local _PWD=$1
  source $_PWD/paths-goroot 2> /dev/null || \
  (
    export GOROOT="$(brew --prefix golang)/libexec" && \
    echo "export GOROOT=\"$(brew --prefix golang)/libexec\"" > $_PWD/paths-goroot
  )
}

export NODE_PATH=/usr/local/lib/node_modules
export GOPATH="${HOME}/go"
# echo 'eval "$(rbenv init -)"' >> ~/.bash_profile # Slow
# export GOROOT="$(brew --prefix golang)/libexec" # Slow
load_goroot ${0:a:h}
# export GOROOT="/usr/local/opt/go/libexec" # Fast

# Composer
export PATH="${PATH}:${HOME}/.composer/vendor/bin"

# PHP 5
export PATH="${PATH}:/usr/local/php5/bin"

# Go
export PATH="${PATH}:${GOPATH}/bin"
export PATH="${PATH}:${GOROOT}/bin"
export PATH="${PATH}:${HOME}/.rbenv/shims"
