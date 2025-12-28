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

-- Conditions
local line_begin = require('luasnip.extras.expand_conditions').line_begin

-- Best-effort mathzone detection:
-- If you use vimtex, this is the gold standard.
local function in_mathzone()
  if vim.fn.exists '*vimtex#syntax#in_mathzone' == 1 then
    return vim.fn['vimtex#syntax#in_mathzone']() == 1
  end
  -- Fallback: no vimtex -> don't auto-restrict (return true so snippets still work)
  return true
end

local function not_mathzone()
  return not in_mathzone()
end

return {
  ---------------------------------------------------------------------------
  -- Environments (line-begin)
  ---------------------------------------------------------------------------

  s(
    { trig = 'ali', dscr = 'align*', condition = line_begin },
    fmta(
      [[
\begin{align*}
  <>
\end{align*}
]],
      { i(1) }
    )
  ),

  s(
    { trig = 'align', dscr = 'align', condition = line_begin },
    fmta(
      [[
\begin{align}
  <>
\end{align}
]],
      { i(1) }
    )
  ),

  s(
    { trig = 'eq', dscr = 'equation', condition = line_begin },
    fmta(
      [[
\begin{equation}
  <>
\end{equation}
]],
      { i(1) }
    )
  ),

  s(
    { trig = 'gath', dscr = 'gather', condition = line_begin },
    fmta(
      [[
\begin{gather}
  <>
\end{gather}
]],
      { i(1) }
    )
  ),

  s(
    { trig = 'cases', dscr = 'cases (math)', condition = in_mathzone },
    fmta(
      [[
\begin{cases}
  <> & \text{<>} \\
  <> & \text{<>}
\end{cases}
]],
      { i(1), i(2, 'if'), i(3), i(4, 'otherwise') }
    )
  ),

  s(
    { trig = 'item', dscr = 'itemize', condition = line_begin },
    fmta(
      [[
\begin{itemize}
  \item <>
\end{itemize}
]],
      { i(1) }
    )
  ),

  s(
    { trig = 'enum', dscr = 'enumerate', condition = line_begin },
    fmta(
      [[
\begin{enumerate}
  \item <>
\end{enumerate}
]],
      { i(1) }
    )
  ),

  ---------------------------------------------------------------------------
  -- Matrices / brackets (math mode)
  ---------------------------------------------------------------------------

  s(
    { trig = 'pmat', dscr = 'pmatrix', condition = in_mathzone },
    fmta(
      [[
\begin{pmatrix}
  <>
\end{pmatrix}
]],
      { i(1) }
    )
  ),

  s(
    { trig = 'bmat', dscr = 'bmatrix', condition = in_mathzone },
    fmta(
      [[
\begin{bmatrix}
  <>
\end{bmatrix}
]],
      { i(1) }
    )
  ),

  s(
    { trig = 'vvec', dscr = 'column vector (bmatrix)', condition = in_mathzone },
    fmta(
      [[
\begin{bmatrix}
  <> \\
  <>
\end{bmatrix}
]],
      { i(1), i(2) }
    )
  ),

  ---------------------------------------------------------------------------
  -- Core math constructs (math mode)
  ---------------------------------------------------------------------------

  s({ trig = 'ff', dscr = '\\frac{a}{b}', condition = in_mathzone }, fmta('\\frac{<>}{<>}', { i(1), i(2) })),
  s({ trig = 'sq', dscr = '\\sqrt{x}', condition = in_mathzone }, fmta('\\sqrt{<>}', { i(1) })),
  s({ trig = 'sr', dscr = '\\sqrt[n]{x}', condition = in_mathzone }, fmta('\\sqrt[<>]{<>}', { i(1, 'n'), i(2) })),

  s({ trig = 'sum', dscr = 'summation', condition = in_mathzone }, fmta('\\sum_{<>}^{<>} <>', { i(1, 'i=1'), i(2, 'n'), i(3) })),
  s({ trig = 'prod', dscr = 'product', condition = in_mathzone }, fmta('\\prod_{<>}^{<>} <>', { i(1, 'i=1'), i(2, 'n'), i(3) })),

  s({ trig = 'int', dscr = 'integral', condition = in_mathzone }, fmta('\\int_{<>}^{<>} <> \\, d<>', { i(1), i(2), i(3), i(4, 'x') })),
  s({ trig = 'iint', dscr = 'double integral', condition = in_mathzone }, fmta('\\iint_{<>} <> \\, d<>', { i(1), i(2), i(3, 'A') })),

  s({ trig = 'lim', dscr = 'limit', condition = in_mathzone }, fmta('\\lim_{<> \\to <>} <>', { i(1, 'n'), i(2, '\\infty'), i(3) })),

  s({ trig = 'lrp', dscr = '\\left( \\right)', condition = in_mathzone }, fmta('\\left( <> \\right)', { i(1) })),
  s({ trig = 'lrb', dscr = '\\left[ \\right]', condition = in_mathzone }, fmta('\\left[ <> \\right]', { i(1) })),
  s({ trig = 'lrc', dscr = '\\left\\{ \\right\\}', condition = in_mathzone }, fmta('\\left\\{ <> \\right\\}', { i(1) })),

  s({ trig = 'ang', dscr = '\\langle a, b \\rangle', condition = in_mathzone }, fmta('\\langle <>, <> \\rangle', { i(1), i(2) })),
  s({ trig = 'set', dscr = 'set builder', condition = in_mathzone }, fmta('\\{ <> \\mid <> \\}', { i(1), i(2) })),

  s({ trig = 'abs', dscr = '|x|', condition = in_mathzone }, fmta('\\lvert <> \\rvert', { i(1) })),
  s({ trig = 'norm', dscr = '||x||', condition = in_mathzone }, fmta('\\lVert <> \\rVert', { i(1) })),

  s({ trig = 'bb', dscr = '\\mathbb{X}', condition = in_mathzone }, fmta('\\mathbb{<>}', { i(1, 'R') })),
  s({ trig = 'cal', dscr = '\\mathcal{X}', condition = in_mathzone }, fmta('\\mathcal{<>}', { i(1, 'L') })),
  s({ trig = 'bf', dscr = '\\mathbf{v}', condition = in_mathzone }, fmta('\\mathbf{<>}', { i(1, 'v') })),

  ---------------------------------------------------------------------------
  -- Derivatives / operators (math mode)
  ---------------------------------------------------------------------------

  s({ trig = 'dd', dscr = 'd/dx', condition = in_mathzone }, fmta('\\frac{d<>}{d<>}', { i(1, 'y'), i(2, 'x') })),
  s({ trig = 'pp', dscr = '∂/∂x', condition = in_mathzone }, fmta('\\frac{\\partial <>}{\\partial <>}', { i(1, 'f'), i(2, 'x') })),
  s({ trig = 'p2', dscr = '∂²/∂x²', condition = in_mathzone }, fmta('\\frac{\\partial^2 <>}{\\partial <>^2}', { i(1, 'f'), i(2, 'x') })),

  s({ trig = 'grad', dscr = '∇ operator', condition = in_mathzone }, t '\\nabla '),
  s({ trig = 'lap', dscr = 'Laplacian', condition = in_mathzone }, fmta('\\Delta <>', { i(1) })),

  ---------------------------------------------------------------------------
  -- Physics (math mode)
  ---------------------------------------------------------------------------

  s({ trig = 'ket', dscr = 'Dirac ket', condition = in_mathzone }, fmta('\\lvert <> \\rangle', { i(1, '\\psi') })),
  s({ trig = 'bra', dscr = 'Dirac bra', condition = in_mathzone }, fmta('\\langle <> \\rvert', { i(1, '\\psi') })),
  s(
    { trig = 'braket', dscr = '<phi|A|psi>', condition = in_mathzone },
    fmta('\\langle <> \\rvert <> \\lvert <> \\rangle', { i(1, '\\phi'), i(2, 'A'), i(3, '\\psi') })
  ),

  s({ trig = 'comm', dscr = '[A,B] commutator', condition = in_mathzone }, fmta('\\left[ <>, <> \\right]', { i(1, 'A'), i(2, 'B') })),
  s({ trig = 'acomm', dscr = '{A,B} anticommutator', condition = in_mathzone }, fmta('\\left\\{ <>, <> \\right\\}', { i(1, 'A'), i(2, 'B') })),

  s({ trig = 'ev', dscr = 'expectation value', condition = in_mathzone }, fmta('\\langle <> \\rangle', { i(1) })),

  ---------------------------------------------------------------------------
  -- Computing / CS writing (text mode)
  ---------------------------------------------------------------------------

  s({ trig = 'tt', dscr = '\\texttt{...}', condition = not_mathzone }, fmta('\\texttt{<>}', { i(1) })),
  s({ trig = 'url', dscr = '\\url{...}', condition = not_mathzone }, fmta('\\url{<>}', { i(1) })),
  s({ trig = 'href', dscr = '\\href{url}{text}', condition = not_mathzone }, fmta('\\href{<>}{<>}', { i(1), i(2) })),

  s(
    { trig = 'code', dscr = 'minted code block', condition = line_begin },
    fmta(
      [[
\begin{minted}[fontsize=\small,breaklines]{<>}
<>
\end{minted}
]],
      { i(1, 'bash'), i(2) }
    )
  ),

  s(
    { trig = 'lst', dscr = 'lstlisting code block', condition = line_begin },
    fmta(
      [[
\begin{lstlisting}[language=<>]
<>
\end{lstlisting}
]],
      { i(1, 'Python'), i(2) }
    )
  ),
}
