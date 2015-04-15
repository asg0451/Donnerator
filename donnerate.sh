#!/bin/bash
# run program until get a donnerism not in the dictionary

function getism () {
    word=$(./Donnerator.rb)
    if [[ -z $(grep "$word" donnerisms.txt) ]]
    then echo "$word"
    else getism
    fi
}

getism
