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
    opts = {
      defaults = {
        mappings = {
          i = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
          n = {
            ["<C-j>"] = require("telescope.actions").move_selection_next,
            ["<C-k>"] = require("telescope.actions").move_selection_previous,
          },
        },
      },
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
  { 
    "lewis6991/gitsigns.nvim",
    event = { "BufReadPre", "BufNewFile" }, -- carrega ao abrir arquivos
    --config = function()
      --require('gitsigns').setup {
    opts = {
      signs = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged = {
        add          = { text = '┃' },
        change       = { text = '┃' },
        delete       = { text = '_' },
        topdelete    = { text = '‾' },
        changedelete = { text = '~' },
        untracked    = { text = '┆' },
      },
      signs_staged_enable = true,
      signcolumn = true,  -- Toggle with `:Gitsigns toggle_signs`
      numhl      = false, -- Toggle with `:Gitsigns toggle_numhl`
      linehl     = false, -- Toggle with `:Gitsigns toggle_linehl`
      word_diff  = false, -- Toggle with `:Gitsigns toggle_word_diff`
      watch_gitdir = {
        follow_files = true
      },
      auto_attach = true,
      attach_to_untracked = false,
      current_line_blame = false, -- Toggle with `:Gitsigns toggle_current_line_blame`
      current_line_blame_opts = {
        virt_text = true,
        virt_text_pos = 'eol', -- 'eol' | 'overlay' | 'right_align'
        delay = 1000,
        ignore_whitespace = false,
        virt_text_priority = 100,
        use_focus = true,
      },
      current_line_blame_formatter = '<author>, <author_time:%R> - <summary>',
      blame_formatter = nil, -- Use default
      sign_priority = 6,
      update_debounce = 100,
      status_formatter = nil, -- Use default
      max_file_length = 40000, -- Disable if file is longer than this (in lines)
      preview_config = {
        -- Options passed to nvim_open_win
        style = 'minimal',
        relative = 'cursor',
        row = 0,
        col = 1
      },
    },
    --end,
    keys = {
      { "<leader>gn", "<cmd>Gitsigns next_hunk<CR>", {desc = "alteração seguinte" }},
      { "<leader>gp", "<cmd>Gitsigns previous_hunk<CR>", {desc = "alteração anterior" }},
      { "<leader>gb", "<cmd>Gitsigns blame_line<CR>", {desc = "toggle blame" }},
      { "<leader>gp", "<cmd>Gitsigns diffthis<CR>", {desc = "diff completo" }},
    },
  },
}

