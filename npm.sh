#!/usr/bin/env bash

cwd="$(cd -P -- "$(dirname -- "$0")" && pwd -P)"
# npmRegistry='https://registry.npm.taobao.org'
npmRegistry='http://localhost:5080'
npmInstall="npm i --registry=${npmRegistry} --cache-min Infinity"

function aliasNpn {
  echo "alias npm='npm --registry="${npmRegistry}"'"
}

function cleanRn {
  dirNames=(
    $cwd/android
    $cwd/ios/
    $cwd/.flowconfig
    $cwd/.watchmanconfig
  )
  for dirName in "${dirNames[@]}"
  do
    rm -rf $dirName
  done
}

function cleanPrj {
  dirNames=(
    $cwd/npm-debug.log*
    $cwd/build
    $cwd/.tmp
    $cwd/dist
    $cwd/dest
  )
  for dirName in "${dirNames[@]}"
  do
    rm -rf $dirName
  done
}

function install {
  ${npmInstall}
}

function reinstall {
  rm -rf $cwd/node_modules
  install
}

function build {
  coffee -bo $cwd/build $cwd/src
}

function rebuild {
  cleanPrj
  build
}

function start {
  npm cache clean
  node $cwd/node_modules/react-native/local-cli/cli.js start
}

function update {
  env NPM_CHECK_INSTALLER=npm npm-check -su
}

function watchman {
  watchman watch-del $cwd
  watchman watch-project $cwd
}

function helper {
  echo 'Usage: ./npm.sh COMMAND'
  echo '       ./npm.sh [ h | -h | help | --help ]'
  echo ''
  echo 'Bash scripts for npm run tasks.'
  echo ''
  echo 'Commands:'
  echo '  clean:rn:       clean dirctorys about react-native'
  echo '  clean:prj:      clean dirctorys without push to git'
  echo '  install:        install require packages'
  echo '  reinstall:      reinstall require packages'
  echo '  build:          build project'
  echo '  rebuild:        rebuild project'
  echo '  start:          start dev server of RN'
  echo '  update:         check local pkgs version'
  echo '  watchman:       rewatch use watchman command'
}

function main {
  case $1 in

    h | '-h' | help | '--help' )
      helper
      echo 'hello'
      ;;

    clean:rn )
      cleanRn
      ;;

    clean:prj )
      cleanPrj
      ;;

    install )
      install
      ;;

    reinstall )
      reinstall
      ;;

    build )
      build
      ;;

    rebuild )
      rebuild
      ;;

    start )
      start
      ;;

    update: )
      update
      ;;

    watchman )
      watchman
      ;;

    * )
      helper
      ;;
  esac
}

main $@
