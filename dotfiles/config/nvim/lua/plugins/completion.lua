return {
  -- Motor de snippets
  {
    "L3MON4D3/LuaSnip",
    build = "make install_jsregexp", -- opcional, melhora transformações
    config = function()
      require("luasnip").setup({
        -- Suas preferências, ex: para expandir com <Tab>
      })
    end,
  },
  -- Framework de autocompletar
  {
    "hrsh7th/nvim-cmp",
    dependencies = {
      "hrsh7th/cmp-nvim-lsp",  -- fonte LSP
      "hrsh7th/cmp-buffer",    -- palavras do buffer
      "hrsh7th/cmp-path",      -- caminhos do sistema
      "saadparwaiz1/cmp_luasnip", -- fonte LuaSnip
    },
    config = function()
      local cmp = require("cmp")
      local luasnip = require("luasnip")

      cmp.setup({
        snippet = {
          expand = function(args)
            luasnip.lsp_expand(args.body)
          end,
        },
        sources = cmp.config.sources({
          { name = "nvim_lsp" },
          { name = "luasnip" },
          { name = "buffer" },
          { name = "path" },
        }),
        mapping = cmp.mapping.preset.insert({
          ["<C-n>"] = cmp.mapping.complete(),               -- abre a lista
          ["<C-j>"] = cmp.mapping.select_next_item(),       -- próximo item
          ["<C-k>"] = cmp.mapping.select_prev_item(),       -- item anterior
          ["<CR>"] = cmp.mapping.confirm({ select = true }),-- confirma seleção
          ["<Tab>"] = cmp.mapping(function(fallback)
            if luasnip.expand_or_jumpable() then
              luasnip.expand_or_jump()
            else
              fallback()
            end
          end, { "i", "s" }),
        }),
      })
    end,
  },
}
