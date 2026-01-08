return {
  {
    "lervag/vimtex",
    lazy = false, -- important: load at startup
    init = function()
      -- Disable VimTeX insert-mode mappings if you want
      vim.g.vimtex_imaps_enabled = 0

      -- Compiler (latexmk) - usually default, but explicit is nice
      vim.g.vimtex_compiler_method = "latexmk"

      -- Viewer (pick one)
      vim.g.vimtex_view_method = "zathura"

      -- Quickfix noise filters
      vim.g.vimtex_quickfix_open_on_warning = 0
      vim.g.vimtex_quickfix_ignore_filters = {
        "Underfull",
        "Overfull",
        "LaTeX Warning: .\\+ float specifier changed to",
        "Package hyperref Warning: Token not allowed in a PDF string",
      }

      -- Optional: keep VimTeX from stealing conceal settings
      -- vim.g.vimtex_syntax_conceal_disable = 1
    end,
  },
}

