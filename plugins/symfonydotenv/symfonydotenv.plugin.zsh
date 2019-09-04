load_symfony_dotenv() {
  if [[ -f $1 ]]; then
    # test .env syntax
    zsh -fn $1 || echo "dotenv: error when sourcing '$1' file" >&2
    if [[ -o a ]]; then
      source $1
    else
      set -a
      source $1
      set +a
    fi
  fi
}

source_symfony_env() {
  load_symfony_dotenv ".env"
  load_symfony_dotenv ".env.local"
  APP_ENV=${APP_ENV:=dev}
  load_symfony_dotenv ".env.${APP_ENV}"
  load_symfony_dotenv ".env.${APP_ENV}.local"
}

autoload -U add-zsh-hook
add-zsh-hook chpwd source_symfony_env

source_symfony_env
