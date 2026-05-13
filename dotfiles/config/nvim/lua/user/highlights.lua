local cinza = "#696969"
-- Sobrepõe as cores DE APENAS comentários e docstrings (strings de documentação)
local set_hl = vim.api.nvim_set_hl

-- Grupo de comentário padrão (caso o treesitter não cubra algum caso)
set_hl(0, "@comment", { fg = cinza })

-- Grupos do treesitter (funcionam quando o parser está ativo)
set_hl(0, "@comment.lua", { fg = cinza })
set_hl(0, "@comment.python", { fg = cinza })
set_hl(0, "@string.documentation.python", { fg = cinza })     -- docstrings propriamente ditas (""" ou """)

