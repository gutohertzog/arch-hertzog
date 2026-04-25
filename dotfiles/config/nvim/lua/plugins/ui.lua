return {
  {
    "tomasiser/vim-code-dark",
    priority = 1000,
    config = function()
      vim.cmd.colorscheme("codedark")
      -- aplica as sobreposições imediatamente
      require("user.highlights")
  end,
  },

  { "nvim-tree/nvim-web-devicons", lazy = true },
}

