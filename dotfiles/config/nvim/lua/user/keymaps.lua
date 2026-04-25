-- mapeamento
vim.keymap.set("i", "<C-s>", "<cmd>w<CR>a")
vim.keymap.set("n", "<C-s>", "<cmd>w<CR>")
vim.keymap.set("v", "<C-s>", "<cmd>w<CR>")

-- janelas
vim.keymap.set("n", "<C-h>", "<C-w>h", { desc = "move cursor para esquerda"})
vim.keymap.set("n", "<C-j>", "<C-w>j", { desc = "move cursor para baixo"})
vim.keymap.set("n", "<C-k>", "<C-w>k", { desc = "move cursor para cima"})
vim.keymap.set("n", "<C-l>", "<C-w>l", { desc = "move cursor para direita"})

-- manipula janelas
vim.keymap.set("n", "<Leader>wd", "<C-W>c", { desc = "fecha a janela atual"})
vim.keymap.set("n", "<Leader>ws", "<cmd>new<CR>", { desc = "abre nova janela horz com buffer vazio"})
vim.keymap.set("n", "<Leader>wv", "<cmd>vnew<CR>", { desc = "abre nova janela vert com buffer vazio"})
vim.keymap.set("n", "<Leader>wS", "<cmd>split<CR>", { desc = "abre nova janela horz do buffer atual"})
vim.keymap.set("n", "<Leader>wV", "<cmd>vsplit<CR>", { desc = "abre nova janela vert do buffer atual"})
vim.keymap.set("n", "<Leader>w=", "<C-w>=", { desc = "equalizar tamanhos" })
vim.keymap.set("n", "<Leader>wm", "<C-w>_ <C-w>|", { desc = "maximizar janela" })
vim.keymap.set("n", "<Leader>wH", "<C-w>H", { desc = "move janela para esquerda" })
vim.keymap.set("n", "<Leader>wJ", "<C-w>J", { desc = "move janela para baixo" })
vim.keymap.set("n", "<Leader>wK", "<C-w>K", { desc = "move janela para cima" })
vim.keymap.set("n", "<Leader>wL", "<C-w>L", { desc = "move janela para direita" })
vim.keymap.set("n", "<Leader>wr", "<C-w>r", { desc = "rotaciona janelas" })

-- manipula buffers
vim.keymap.set("n", "<Leader>bd", "<cmd>bdelete<CR>", { desc = "apaga o buffer atual"})
vim.keymap.set("n", "<Leader>bn", "<cmd>bnext<CR>", { desc = "vai para buffer seguinte"})
vim.keymap.set("n", "<Leader>bp", "<cmd>bprevious<CR>", { desc = "vai para buffer anterior" })
vim.keymap.set("n", "<Leader>bb", "<cmd>%bd|e#<CR>", { desc = "vai para o último buffer" })
vim.keymap.set("n", "<Leader>bo", "<cmd>%bdelete|edit#|bdelete#<CR>", { desc = "apaga outros buffers" })

-- manipula tabs
vim.keymap.set("n", "<Leader>tt", "<cmd>tabnew<CR>", { desc = "cria uma nova aba" })
vim.keymap.set("n", "<Leader>td", "<cmd>tabclose<CR>", { desc = "fecha a aba atual" })
vim.keymap.set("n", "<Leader>tn", "<cmd>tabnext<CR>", { desc = "vai para aba seguinte" })
vim.keymap.set("n", "<Leader>tp", "<cmd>tabprevious<CR>", { desc = "vai para aba anterior" })
vim.keymap.set("n", "<Leader>tH", "<cmd>tabmove -1<CR>", { desc = "move aba para esquerda" })
vim.keymap.set("n", "<Leader>tL", "<cmd>tabmove +1<CR>", { desc = "move aba para direita" })
for i = 1, 9 do
    vim.keymap.set("n", "<Leader>t" .. i, i .. "gt", { desc = "vai para aba " .. i })
end

--
vim.keymap.set("n", "<Leader><Leader>i", "<cmd>Inspect<CR>", { desc = "inspeciona o objeto" })

