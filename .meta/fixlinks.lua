function Link(el)
  if el.title == 'wikilink' and string.sub(el.href, 1, 1) != '#' then
    el.target = el.target .. ".html"
  end
  return el
end
