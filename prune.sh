#!/bin/sh

# 
# https://cjohansen.no/git-subtree-multiple-dirs/
# 
# > ./prune.sh
# > git remote -v
# > git remote set-url origin https://github.com/whoopsjohnnie/gremlinfssvc.git
# > git remote -v
# 

git filter-branch \
    --tree-filter 'find . ! \( -path "./config*" -o \
                               -path "./docker/Dockerfile.orientdb" -o \
                               -path "./docker-compose.services.yaml" -o \
                               -path "." \) \
                        -exec rm -fr {} +' \
    --prune-empty \
    HEAD
