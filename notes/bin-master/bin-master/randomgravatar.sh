#!/usr/bin/env bash
wget --quiet "http://fr.gravatar.com/naereen.json" -O - | python -m json.tool | grep -o "[a-zA-Z.]*@[a-zA-Z.]*"
