#!/bin/sh

cd $GITHUB_WORKSPACE

# create output folder
mkdir -p public_html

# copy directory structure, wiki files, and images
tar cf - --exclude=public_html --exclude='.[^/]*' --exclude="*.sh" . | (cd public_html && tar xf - )

# remove wiki files to keep structure
find public_html -type f -name "*.wiki" -delete

# copy over style
cp .meta/style.css public_html/style.css

# convert all wiki files
#
# look in this '.' directory (GITHUB_WORKSPACE) so that the output is easier
# to work with
find . -name '*.wiki' | while read file ; do
  outname=$(echo "${file}" | sed -e "s/\.wiki/\.html/g")
  template=.meta/templates/default.html
  if [ "$file" = "index.wiki" ]; then
    template=.meta/templates/index.html
  fi

  pandoc -f vimwiki -t html5 \
    --lua-filter=.meta/fixlinks.lua \
    --template="${template}" \
    --syntax-definition=.meta/solidity.xml \
    --metadata-file=.meta/metadata.yml \
    --variable=site-base:"https://0xcharchar.github.io/wiki"
    --highlight-style=pygments \
    --css=style.css \
    --verbose \
    "${file}" -o "public_html/${outname}"

  # Using sed to remove whitespace at the beginning of each line
  # This is a cheap hack to work around problems with pandoc putting
  # additional whitespace in `pre` tags causing source code to be
  # formatted incorrectly. This works because rendered source
  # code wraps code formatting whitespace in `<span>` so we can safely
  # strip whitespace in front of the spans. AFAIK, this can't
  # be done in a filter due to this not being an AST problem.
  #
  # There are some caveats where no `<span>` tags are rendered:
  #   1. if `--no-highlight` is used
  #   2. if the source code is unknown (shoutout to solidity)
  sed "s/^[ \t]*//g" -i "public_html/${outname}"
done
