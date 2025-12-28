local ls = require("luasnip")
local s = ls.snippet
local t = ls.text_node
local i = ls.insert_node
local fmta = require("luasnip.extras.fmt").fmta
local line_begin = require("luasnip.extras.expand_conditions").line_begin

return {

	-- Figures (⟂)
	s(
		{ trig = "fig", dscr = "Figure float with caption+label", condition = line_begin },
		fmta(
			[[
\begin{figure}[htbp]
  \centering
  \includegraphics[width=0.8\textwidth]{<>}
  \caption{<>}
  \label{fig:<>}
\end{figure}
]],
			{ i(1, "image"), i(2, "Caption"), i(3, "label") }
		)
	),

	s(
		{ trig = "img", dscr = "Inline includegraphics", condition = line_begin },
		fmta("\\includegraphics[width=0.8\\textwidth]{<>}", { i(1, "image") })
	),

	-- Tables (⟂)
	s(
		{ trig = "tab", dscr = "Table float scaffold", condition = line_begin },
		fmta(
			[[
\begin{table}[htbp]
  \centering
  \caption{<>}
  \label{tab:<>}
  \begin{tabular}{<>}
    <>
  \end{tabular}
\end{table}
]],
			{ i(1, "Caption"), i(2, "label"), i(3, "l l"), i(4, "\\hline\n    a & b \\\\\n    \\hline") }
		)
	),

	-- References / citations (inline)
	s({ trig = "lab", dscr = "Label" }, fmta("\\label{<>:<>}", { i(1, "sec"), i(2, "name") })),
	s({ trig = "ref", dscr = "Reference" }, fmta("\\ref{<>:<>}", { i(1, "sec"), i(2, "name") })),
	s({ trig = "eqr", dscr = "Equation reference" }, fmta("\\eqref{<>}", { i(1, "eq:label") })),
	s({ trig = "cite", dscr = "Citation" }, fmta("\\cite{<>}", { i(1, "key") })),

	-- Sectioning (⟂)
	s({ trig = "s1", dscr = "Section", condition = line_begin }, fmta("\\section{<>}\n<>", { i(1, "Title"), i(2) })),
	s(
		{ trig = "s2", dscr = "Subsection", condition = line_begin },
		fmta("\\subsection{<>}\n<>", { i(1, "Title"), i(2) })
	),
	s(
		{ trig = "s3", dscr = "Subsubsection", condition = line_begin },
		fmta("\\subsubsection{<>}\n<>", { i(1, "Title"), i(2) })
	),

	-- Lists (⟂)
	s(
		{ trig = "item", dscr = "itemize", condition = line_begin },
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
		{ trig = "enum", dscr = "enumerate", condition = line_begin },
		fmta(
			[[
\begin{enumerate}
  \item <>
\end{enumerate}
]],
			{ i(1) }
		)
	),

	-- Code blocks (⟂) (choose minted OR listings in your preamble)
	s(
		{ trig = "mint", dscr = "minted block", condition = line_begin },
		fmta(
			[[
\begin{minted}[fontsize=\small,breaklines]{<>}
<>
\end{minted}
]],
			{ i(1, "bash"), i(2) }
		)
	),

	s(
		{ trig = "lst", dscr = "lstlisting block", condition = line_begin },
		fmta(
			[[
\begin{lstlisting}[language=<>]
<>
\end{lstlisting}
]],
			{ i(1, "Python"), i(2) }
		)
	),

	-- Useful text macros (inline)
	s({ trig = "tt", dscr = "texttt" }, fmta("\\texttt{<>}", { i(1) })),
	s({ trig = "em", dscr = "emph" }, fmta("\\emph{<>}", { i(1) })),
}
