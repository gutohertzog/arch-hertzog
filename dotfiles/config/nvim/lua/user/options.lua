local opt = vim.opt

--let g:ftplugin_sql_omni_key = '<Plug>DisableSqlOmni'
vim.g.ftplugin_sql_omni_key = "<Plug>DisableSqlOmni"

-- interface
opt.colorcolumn = "80,100"
opt.cursorline = true
opt.laststatus = 2
opt.number = true
opt.relativenumber = true
opt.ruler = true
opt.scrolloff = 3
opt.showcmd = true
-- opt.showtabline = 2
opt.signcolumn = "yes"
opt.syntax = "on"
opt.wildmenu = true
vim.cmd("colorscheme desert")

-- edição
opt.tabstop = 4
opt.shiftwidth = 4
opt.expandtab = true
opt.smarttab = true
opt.autoindent = true
opt.clipboard = "unnamed,unnamedplus"

-- pesquisa
opt.wrapscan = true
opt.ignorecase = true
opt.smartcase = true
opt.incsearch = true
opt.hlsearch = true

