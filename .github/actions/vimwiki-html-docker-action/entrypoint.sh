#!/bin/sh

# create output folder
mkdir -p public_html

# copy directory structure, wiki files, and images
tar cf - --exclude=public_html --exclude='.[^/]*' --exclude="*.sh" . | (cd public_html && tar xvf - )

# remove wiki files
find public_html -type f -name "*.wiki" -delete

# copy over style
cp .meta/style.css public_html/style.css

find . -name '*.wiki' -print0 -not -path -"./public_html" | while read -d $'\0' -r file ; do
  printf 'Found: '"'%s'"'\n' "${file##*/}"
  outname=$(echo "${file}" | sed -e "s/\.wiki/\.html/g")
  #echo $outname
  pandoc -f vimwiki -t html5 \
    --lua-filter=.meta/fixlinks.lua \
    --template=.meta/templates/default.html \
    --highlight-style=pygments \
    --css=style.css \
    "${file}" -o "public_html/$outname"
done
