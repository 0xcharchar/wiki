#!/bin/sh

mkdir -p /github/workspace/public_html
cp /github/workspace/templates/style.css /github/workspace/public_html/

vim --not-a-term +VimwikiAll2HTML +quit /github/workspace/index.wiki
