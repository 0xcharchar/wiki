function Link(el)
  if el.title == 'wikilink' and el.target:sub(1, 1) ~= '#' then
    el.target = el.target .. ".html"
  end
  return el
end
