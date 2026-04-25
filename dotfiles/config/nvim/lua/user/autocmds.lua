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

