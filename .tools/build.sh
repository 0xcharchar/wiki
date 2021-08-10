#!/bin/sh

mkdir -p ~/.vim/pack/plugins/start/
cp -R /opt/repo/.tools/vimwiki/ ~/.vim/pack/plugins/start/vimwiki
cp /opt/repo/.tools/vimrc ~/.vimrc
/opt/repo/.tools/vim --not-a-term +VimwikiAll2HTML +quit /opt/repo/vimwiki/index.wiki
