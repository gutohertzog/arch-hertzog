-- Realce de sintaxe via treesitter
vim.treesitter.start()

-- Dobras (folds) baseadas em sintaxe
vim.wo.foldexpr = "v:lua.vim.treesitter.foldexpr()"
vim.wo.foldmethod = "expr"

-- Indentação automática (opcional, ainda experimental)
vim.bo.indentexpr = "v:lua.require"nvim-treesitter".indentexpr()"

