local mini_config = {}

mini_config.move = {
  mappings = {
    left = "<S-h>",
    right = "<S-l>",
    down = "<S-j>",
    up = "<S-k>",

    line_left = "<S-h>",
    line_right = "<S-l>",
  },

  options = {
    reindent_linewise = true,
  },
}

mini_config.indentscope = {
  draw = {
    delay = 10,

    priority = 2,
  },

  mappings = {
    object_scope = "ii",
    object_scope_with_border = "ai",
    goto_top = "[i",
    goto_bottom = "]i",
  },

  options = {
    border = "both",
    indent_at_cursor = true,
    n_lines = 10000,
    try_as_border = false,
  },

  symbol = "╎",
}

return {
  "echasnovski/mini.nvim",
  version = "*",
  config = function()
    require("mini.ai").setup()
    -- require('mini.comment').setup()
    require("mini.move").setup(mini_config.move)
    require("mini.pairs").setup()
    require("mini.surround").setup()
    require("mini.icons").setup()
  end,
}
