local rel_num_augroup = vim.api.nvim_create_augroup("RelNumToggle", { clear = true })
vim.api.nvim_create_autocmd("InsertEnter", {
    group = rel_num_augroup,
    callback = function() vim.opt.relativenumber = false end
})
vim.api.nvim_create_autocmd("InsertLeave", {
    group = rel_num_augroup,
    callback = function() vim.opt.relativenumber = true end
})
-- necessário já que <C-c> não dispara InsertLeave
vim.keymap.set("i", "<C-c>", "<Esc>:set relativenumber<CR>")  -- ativa relativenumber no modo normal

vim.api.nvim_create_user_command("W", function()
    vim.cmd("w !sudo tee % > /dev/null")
    vim.cmd("edit!")
end, {})

-- Garante que as sobreposições de destaque sejam aplicadas após qualquer tema
vim.api.nvim_create_autocmd("ColorScheme", {
  pattern = "*",
  callback = function()
    require("user.highlights")
  end,
})

-- destaca o que for copiado
vim.api.nvim_create_autocmd("TextYankPost", {
  callback = function()
    vim.highlight.on_yank({
      higroup = "IncSearch",
      timeout = 250,
    })
  end,
})

-- atalhos do LSP (modo normal)
vim.api.nvim_create_autocmd("LspAttach", {
  group = vim.api.nvim_create_augroup("UserLspAttach", { clear = true }),
  callback = function(args)
    local buf = args.buf

    -- Navegação
    vim.keymap.set("n", "<leader>ld", "<cmd>lua vim.lsp.buf.definition()<CR>", { buffer = buf, desc = "Ir para definição" })
    vim.keymap.set("n", "<leader>lD", "<cmd>lua vim.lsp.buf.declaration()<CR>", { buffer = buf, desc = "Ir para declaração" })
    vim.keymap.set("n", "<leader>lR", "<cmd>lua vim.lsp.buf.references()<CR>", { buffer = buf, desc = "Listar referências" })
    vim.keymap.set("n", "<leader>li", "<cmd>lua vim.lsp.buf.implementation()<CR>", { buffer = buf, desc = "Ir para implementação" })
    vim.keymap.set("n", "<leader>lt", "<cmd>lua vim.lsp.buf.type_definition()<CR>", { buffer = buf, desc = "Ir para tipo" })

    -- Ações
    vim.keymap.set("n", "<leader>lr", "<cmd>lua vim.lsp.buf.rename()<CR>", { buffer = buf, desc = "Renomear símbolo" })
    vim.keymap.set({"n", "v"}, "<leader>la", "<cmd>lua vim.lsp.buf.code_action()<CR>", { buffer = buf, desc = "Ações de código" }) -- modo visual também
    vim.keymap.set("n", "<leader>lf", "<cmd>lua vim.lsp.buf.format({ async = true })<CR>", { buffer = buf, desc = "Formatar código" })

    -- Informações
    vim.keymap.set("n", "<leader>lh", "<cmd>lua vim.lsp.buf.hover()<CR>", { buffer = buf, desc = "Documentação" })
    vim.keymap.set("n", "<leader>ls", "<cmd>lua vim.lsp.buf.signature_help()<CR>", { buffer = buf, desc = "Assinatura" })

    -- Diagnósticos
    vim.keymap.set("n", "<leader>l[", "<cmd>lua vim.diagnostic.goto_next()<CR>", { buffer = buf, desc = "Próximo diagnóstico" })
    vim.keymap.set("n", "<leader>l]", "<cmd>lua vim.diagnostic.goto_prev()<CR>", { buffer = buf, desc = "Diagnóstico anterior" })
    vim.keymap.set("n", "<leader>le", "<cmd>lua vim.diagnostic.open_float()<CR>", { buffer = buf, desc = "Exibir diagnóstico flutuante" })
  end,
})

