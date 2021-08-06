#!/bin/bash

function install_formula {
    brew list $1 2> /dev/null
    if [[ $? == 0 ]] ; then
        brew list "$1" && brew uninstall "$1"
    fi
    brew install "$1.rb"
}

function main {
    # go to formulas
    pushd "Scripts/Formulas"

    # disable homebrew auto update
    export HOMEBREW_NO_AUTO_UPDATE=1

    # install (or reinstall) swiftlint
    install_formula swiftlint

    # install (or reinstall) swiftformat
    install_formula swiftformat

    # go back
    popd
}

main
