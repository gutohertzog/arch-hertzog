return {
  -- Instalador de servidores
  {
    "williamboman/mason.nvim",
    build = ":MasonUpdate",
    config = true,
  },

  -- Integração Mason ↔ LSP do Neovim
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = { "williamboman/mason.nvim" },
    config = function()
      require("mason-lspconfig").setup({
        ensure_installed = { "basedpyright" },
        -- Habilita automaticamente os servidores instalados
        -- (chama vim.lsp.enable() quando um arquivo correspondente for aberto)
        automatic_enable = true,
      })
    end,
  },

  -- Configurador de LSP (biblioteca)
  {
    "neovim/nvim-lspconfig",
    dependencies = { "williamboman/mason-lspconfig.nvim" },
    config = function()
      -- Configuração personalizada para o basedpyright
      -- Usa vim.lsp.config(), disponível a partir do Neovim 0.10
      vim.lsp.config("basedpyright", {
        settings = {
          basedpyright = {
            analysis = {
              typeCheckingMode = "basic",
              autoSearchPaths = true,
              diagnosticMode = "workspace",
            },
          },
        },
      })
      local capabilities = require("cmp_nvim_lsp").default_capabilities()
      vim.lsp.config("*", { capabilities = capabilities })
    end,
  },
}
