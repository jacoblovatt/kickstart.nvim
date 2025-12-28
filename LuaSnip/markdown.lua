local ls = require "luasnip"
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local fmta = require("luasnip.extras.fmt").fmta

-- Conditions
local line_begin = require("luasnip.extras.expand_conditions").line_begin

-- Helpers
local function iso_date()
  return os.date("%Y-%m-%d")
end

return {

  ---------------------------------------------------------------------------
  -- Headings (start-of-line only)
  ---------------------------------------------------------------------------
  s({ trig = "h1", dscr = "Heading 1", snippetType = "autosnippet", condition = line_begin },
    fmta("# <>", { i(1) })),

  s({ trig = "h2", dscr = "Heading 2", snippetType = "autosnippet", condition = line_begin },
    fmta("## <>", { i(1) })),

  s({ trig = "h3", dscr = "Heading 3", snippetType = "autosnippet", condition = line_begin },
    fmta("### <>", { i(1) })),

  s({ trig = "h4", dscr = "Heading 4", snippetType = "autosnippet", condition = line_begin },
    fmta("#### <>", { i(1) })),

  s({ trig = "h5", dscr = "Heading 5", snippetType = "autosnippet", condition = line_begin },
    fmta("##### <>", { i(1) })),

  s({ trig = "h6", dscr = "Heading 6", snippetType = "autosnippet", condition = line_begin },
    fmta("###### <>", { i(1) })),

  ---------------------------------------------------------------------------
  -- Lists & Tasks (start-of-line)
  ---------------------------------------------------------------------------
  s({ trig = "li", dscr = "Bullet item", condition = line_begin },
    fmta("- <>", { i(1) })),

  s({ trig = "nli", dscr = "Numbered item", condition = line_begin },
    fmta("1. <>", { i(1) })),

  s({ trig = "todo", dscr = "Task item", condition = line_begin },
    fmta("- [ ] <>", { i(1) })),

  s({ trig = "done", dscr = "Completed task", condition = line_begin },
    fmta("- [x] <>", { i(1) })),

  ---------------------------------------------------------------------------
  -- Quotes & Callouts (start-of-line)
  ---------------------------------------------------------------------------
  s({ trig = "quote", dscr = "Blockquote", condition = line_begin },
    fmta("> <>", { i(1) })),

  s({ trig = "call", dscr = "Callout / admonition", condition = line_begin },
    fmta([[
> [!<>] <>
> <>
]], {
      i(1, "NOTE"),
      i(2, "Title"),
      i(3),
    })),

  ---------------------------------------------------------------------------
  -- Links & Media (inline)
  ---------------------------------------------------------------------------
  s({ trig = "link", dscr = "Markdown link" },
    fmta("[<>](<>)", { i(1, "text"), i(2, "url") })),

  s({ trig = "img", dscr = "Image" },
    fmta("![<>](<>)", { i(1, "alt text"), i(2, "path-or-url") })),

  s({ trig = "ref", dscr = "Internal link" },
    fmta("[[<>]]", { i(1, "Note Title") })),

  s({ trig = "reft", dscr = "Internal link with alias" },
    fmta("[[<>|<>]]", { i(1, "Note Title"), i(2, "Alias") })),

  ---------------------------------------------------------------------------
  -- Code blocks (start-of-line)
  ---------------------------------------------------------------------------
  s({ trig = "cb", dscr = "Fenced code block", condition = line_begin },
    fmta([[
```<>
<>
```
]], {
      i(1, "bash"),
      i(2),
    })),

  s({ trig = "sh", dscr = "Shell code block", condition = line_begin },
    fmta([[
```bash
<>
```
]], { i(1) })),

  s({ trig = "py", dscr = "Python code block", condition = line_begin },
    fmta([[
```python
<>
```
]], { i(1) })),

  s({ trig = "js", dscr = "JavaScript code block", condition = line_begin },
    fmta([[
```javascript
<>
```
]], { i(1) })),

  ---------------------------------------------------------------------------
  -- Tables (start-of-line)
  ---------------------------------------------------------------------------
  s({ trig = "tbl2", dscr = "2-column table", condition = line_begin },
    fmta([[
| <> | <> |
|----|----|
| <> | <> |
]], {
      i(1, "Column 1"),
      i(2, "Column 2"),
      i(3),
      i(4),
    })),

  s({ trig = "tbl3", dscr = "3-column table", condition = line_begin },
    fmta([[
| <> | <> | <> |
|----|----|----|
| <> | <> | <> |
]], {
      i(1, "Column 1"),
      i(2, "Column 2"),
      i(3, "Column 3"),
      i(4),
      i(5),
      i(6),
    })),

  ---------------------------------------------------------------------------
  -- Frontmatter (start-of-line)
  ---------------------------------------------------------------------------
  s({ trig = "fm", dscr = "YAML frontmatter", condition = line_begin },
    fmta([[
---
title: "<>"
date: <>
tags: [<>]
draft: true
---
<>
]], {
      i(1, "Post title"),
      f(iso_date),
      i(2, "tag1, tag2"),
      i(3),
    })),

  ---------------------------------------------------------------------------
  -- Writing helpers (start-of-line)
  ---------------------------------------------------------------------------
  s({ trig = "abs", dscr = "Abstract section", condition = line_begin },
    fmta([[
## Abstract
<>
]], { i(1) })),

  s({ trig = "intro", dscr = "Introduction section", condition = line_begin },
    fmta([[
## Introduction
<>
]], { i(1) })),

  s({ trig = "sum", dscr = "Summary section", condition = line_begin },
    fmta([[
## Summary
- <>
]], { i(1) })),

  s({ trig = "conc", dscr = "Conclusion section", condition = line_begin },
    fmta([[
## Conclusion
<>
]], { i(1) })),

  s({ trig = "qa", dscr = "Q&A block", condition = line_begin },
    fmta([[
**Q:** <>
**A:** <>
]], {
      i(1),
      i(2),
    })),
}
