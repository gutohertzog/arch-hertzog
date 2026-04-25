return {
  -- { "nvim-treesitter/nvim-treesitter", build = ":TSUpdate" },
  -- Detecção de arquivos ainda melhor
  {
    "nvim-treesitter/nvim-treesitter",
    lazy = false,        -- o novo plugin NÃO suporta lazy-loading
    build = ":TSUpdate", -- atualiza/instala parsers ao iniciar
    config = function()
      require("nvim-treesitter").setup({
        -- A pasta padrão já é boa, mas pode explicitá-la se quiser:
        -- install_dir = vim.fn.stdpath("data") .. "/site",
      })

      -- (Opcional) Instala parsers essenciais de uma vez
      -- Isso é assíncrono; se quiser bloquear até terminar, use :wait()
      require("nvim-treesitter").install({ "python", "sql", "lua", "vim", "vimdoc" })
    end,
  },
  -- Busca fuzzy (substitui a lista de buffers manual)
  {
    "nvim-telescope/telescope.nvim", version = "*",
    dependencies = {
        "nvim-lua/plenary.nvim",
        -- optional but recommended
        { "nvim-telescope/telescope-fzf-native.nvim", build = "make" },
    },
    keys = {
      { "<leader>ff", "<cmd>Telescope find_files<CR>", desc = "find files" },
      { "<leader>fb", "<cmd>Telescope buffers<CR>", desc = "find buffers" },
      { "<leader>fg", "<cmd>Telescope live_grep<CR>", desc = "live grep" },
      { "<leader>fk", "<cmd>Telescope keymaps<CR>", desc = "find keymaps" },
    },
  },
  {
    "folke/which-key.nvim",
    event = "VeryLazy",
    opts = {
      -- your configuration comes here
      -- or leave it empty to use the default settings
      -- refer to the configuration section below
    },
    keys = {
      {
        "<leader>?",
        function()
          require("which-key").show({ global = false })
        end,
        desc = "Buffer Local Keymaps (which-key)",
      },
    },
  },
  -- Plugin para árvore de diretórios
  {
    "nvim-tree/nvim-tree.lua",
    dependencies = { "nvim-tree/nvim-web-devicons" },
    opts = { -- configuração padrão já razoável
      view = { width = 30 },
    },
    keys = { { "<leader>e", ":NvimTreeToggle<CR>", desc = "Toggle file tree" } },
  },
}

