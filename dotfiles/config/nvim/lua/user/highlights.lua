-- Sobrepõe as cores DE APENAS comentários e docstrings (strings de documentação)
local set_hl = vim.api.nvim_set_hl

-- Grupo de comentário padrão (caso o treesitter não cubra algum caso)
set_hl(0, "@comment", { fg = "#696969" })

-- Grupos do treesitter (funcionam quando o parser está ativo)
set_hl(0, "@comment.lua", { fg = "#696969" })
set_hl(0, "@comment.python", { fg = "#696969" })
set_hl(0, "@string.documentation.python", { fg = "#696969" })     -- docstrings propriamente ditas (""" ou """)

