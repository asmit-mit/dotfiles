local noice_config = {
  cmdline = {
    view = "cmdline",
    format = {
      cmdline = {
        position = {
          row = "0%",
          col = "50%"
        },
        size = {
          width = "80%",
        },
      },
    },
  },
  popupmenu = {
    backend = "nui",
    kind = {
      cmdline = {
        position = {
          row = "100%",
          col = "50%",
        },
        size = {
          width = "80%",
        },
      },
    },
  },
}

return {
  "folke/noice.nvim",
  event = "VeryLazy",
  opts = noice_config, -- Pass the config here
  dependencies = {
    "MunifTanjim/nui.nvim",
  },
}
