#!/bin/bash

while :
do
    ./minetest --server --gameid Solar_Plains --world world
    cd ../games/Solar_Plains && git pull
    cd ../../bin

done
