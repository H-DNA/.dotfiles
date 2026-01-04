#!/usr/bin/env bash
case "$1" in
  zsh|bash|sh|fish) printf '\uf489' ;;
  nvim|vim|vi) printf '\ue62b' ;;
  node) printf '\ue718' ;;
  npm) printf '\ue71e' ;;
  pnpm) printf '\uf487' ;;
  yarn) printf '\ue6a7' ;;
  bun) printf '\uf487' ;;
  python|python3|python2) printf '\ue606' ;;
  ruby|irb) printf '\ue21e' ;;
  git|lazygit|tig) printf '\ue702' ;;
  docker|podman) printf '\uf308' ;;
  ssh|scp) printf '\uf489' ;;
  man|less|more) printf '\uf7d9' ;;
  htop|btop|top) printf '\uf85a' ;;
  make|cmake) printf '\ue615' ;;
  cargo) printf '\ue7a8' ;;
  go) printf '\ue626' ;;
  rustc) printf '\ue7a8' ;;
  lua) printf '\ue620' ;;
  deno) printf '\ue628' ;;
  *) printf '\uf120' ;;
esac
