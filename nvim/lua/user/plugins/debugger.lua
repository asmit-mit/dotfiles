return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")
      -- Configure your debug adapters here
      -- https://github.com/mfussenegger/nvim-dap/wiki/Debug-Adapter-installation
    end,
  },
  {
    "miroshQa/debugmaster.nvim",
    config = function()
      local dm = require("debugmaster")

      -- Key mappings for DebugMaster
      vim.keymap.set({ "n", "v" }, "<leader>d", dm.mode.toggle, { nowait = true })
      vim.keymap.set("t", "<C-/>", "<C-\\><C-n>", { desc = "Exit terminal mode" })
    end,
  },
}
