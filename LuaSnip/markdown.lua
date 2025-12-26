local ls = require 'luasnip'
local s = ls.snippet
local sn = ls.snippet_node
local t = ls.text_node
local i = ls.insert_node
local f = ls.function_node
local d = ls.dynamic_node
local fmt = require('luasnip.extras.fmt').fmt
local fmta = require('luasnip.extras.fmt').fmta
local rep = require('luasnip.extras').rep

-- Example: expanding a snippet on a new line only.
-- In a snippet file, first require the line_begin condition...
local line_begin = require('luasnip.extras.expand_conditions').line_begin

return {

  s({ trig = 'h1', dscr = 'Markdown H1', snippetType="autosnippet", condition = line_begin }, fmta('# <>', { i(1) })),

  s({ trig = 'h2', dscr = 'Markdown H2', snippetType="autosnippet", condition = line_begin }, fmta('## <>', { i(1) })),

  s({ trig = 'h3', dscr = 'Markdown H3', snippetType="autosnippet", condition = line_begin }, fmta('### <>', { i(1) })),

  s({ trig = 'h4', dscr = 'Markdown H4', snippetType="autosnippet", condition = line_begin }, fmta('#### <>', { i(1) })),

  s({ trig = 'h5', dscr = 'Markdown H5', snippetType="autosnippet", condition = line_begin }, fmta('##### <>', { i(1) })),

  s({ trig = 'h6', dscr = 'Markdown H6', snippetType="autosnippet",  condition = line_begin }, fmta('###### <>', { i(1) })),
}
