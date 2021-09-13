#!/bin/sh

cd $GITHUB_WORKSPACE

# create output folder
mkdir -p public_html

# copy directory structure, wiki files, and images
tar cf - --exclude=public_html --exclude='.[^/]*' --exclude="*.sh" . | (cd public_html && tar xf - )

# remove wiki files
find public_html -type f -name "*.wiki" -delete

# copy over style
cp .meta/style.css public_html/style.css

# convert all wiki files
# lookin in this '.' directory so that the output is easier and don't need to do string substition
find . -name '*.wiki' | while read file ; do
  outname=$(echo "${file}" | sed -e "s/\.wiki/\.html/g")
  #printf 'DEBUG - Found '"'%s'"', converted to '"'%s'"'\n' "${file##*/}" "${outname}"

  pandoc -f vimwiki -t html5 \
    --lua-filter=.meta/fixlinks.lua \
    --template=.meta/templates/default.html \
    --highlight-style=pygments \
    --css=style.css \
    --verbose \
    "${file}" -o "public_html/${outname}"
done
