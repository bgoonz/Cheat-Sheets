#!/usr/bin/env bash
wget --quiet 'http://api.randomuser.me/' -O - | python -m json.tool
