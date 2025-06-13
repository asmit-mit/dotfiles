return {
  {
    "williamboman/mason.nvim",
    lazy = true,
    config = function()
      require("mason").setup({
        ui = {
          icons = {
            package_installed = "✓",
            package_pending = "➜",
            package_uninstalled = "✗",
          },
        },
      })
    end,
  },
  {
    "williamboman/mason-lspconfig.nvim",
    dependencies = "neovim/nvim-lspconfig",
    event = "VeryLazy",
    config = function()
      local mason_lspconfig = require("mason-lspconfig")

      mason_lspconfig.setup({
        automatic_enable = true,
        ensure_installed = {
          "cssls",
          "html",
          "jsonls",
          "lemminx", -- XML
          "lua_ls",
          "marksman",
          "ts_ls", -- corrected from ts_ls
          "vimls",
          "clangd",
          "pylsp",
        },
      })
    end,
  },
}
