return {
  'stevearc/oil.nvim',
  opts = {},
  dependencies = { "nvim-tree/nvim-web-devicons" }, -- use if you prefer nvim-web-devicons
  lazy = false,
  config = function()
    require("oil").setup({
      keymaps = {
        ["<C-r>"] = "actions.refresh", -- Map <C-r> to refresh
        ["<C-l>"] = false,              -- Unmap the default <C-l>
        ["<C-h>"] = false,
      },
    })
  end,
}
