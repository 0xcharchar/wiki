#!/bin/sh

mkdir -p /github/workspace/public_html/images
cp /github/workspace/templates/style.css /github/workspace/public_html/
cp -R /github/workspace/images/* /github/workspace/public_html/images/

vim --not-a-term +VimwikiAll2HTML +quit /github/workspace/index.wiki
