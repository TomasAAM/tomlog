-- Prepends a link to the post's counterpart in the other language, read from
-- the `translation:` front-matter field. English pages also get a note saying
-- the text was translated from the Spanish original with AI.

local LABELS = {
  es = { link = "Read in English" },
  en = {
    link = "Leer en español (original)",
    note = "Originally written in Spanish and translated with AI.",
  },
}

function Pandoc(doc)
  local target = doc.meta["translation"]
  if target == nil then
    return doc
  end

  local lang = pandoc.utils.stringify(doc.meta["lang"] or "es"):sub(1, 2)
  local labels = LABELS[lang] or LABELS.es
  local href = pandoc.utils.stringify(target)

  local inlines = { pandoc.Link(labels.link, href) }
  if labels.note then
    inlines = {
      pandoc.Emph(labels.note), pandoc.Space(), pandoc.Str("·"), pandoc.Space(),
      pandoc.Link(labels.link, href),
    }
  end

  table.insert(doc.blocks, 1, pandoc.Div(pandoc.Para(inlines), { class = "translation-link" }))
  return doc
end
