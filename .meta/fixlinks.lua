function Link(el)
  if el.title == 'wikilink' then
    el.target = el.target .. ".html"
  end
  return el
end
