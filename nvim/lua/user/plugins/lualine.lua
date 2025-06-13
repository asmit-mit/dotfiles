local dmode_enabled = false

local function lsp_status()
  local attached_clients = vim.lsp.get_clients({ bufnr = 0 })
  if #attached_clients == 0 then
    return ""
  end
  local names = {}
  for _, client in ipairs(attached_clients) do
    local name = client.name:gsub("language.server", "ls")
    table.insert(names, name)
  end
  return "LSP: " .. table.concat(names, ", ")
end

local lualine_config = {
  options = {
    icons_enabled = true,
    theme = "auto",
    component_separators = { left = "", right = "" },
    section_separators = { left = "", right = "" },
    disabled_filetypes = {
      statusline = {},
      winbar = {},
    },
    ignore_focus = {},
    always_divide_middle = true,
    always_show_tabline = true,
    globalstatus = false,
    refresh = {
      statusline = 100,
      tabline = 100,
      winbar = 100,
    },
  },
  sections = {
    lualine_a = {
      {
        "mode",
        fmt = function(str)
          return dmode_enabled and "DEBUG" or str
        end,
        color = function()
          if dmode_enabled then
            return { fg = "#000000", bg = "#2fa94f", gui = "bold" }
          else
            return nil
          end
        end,
        separator = { left = "", right = "" },
      },
    },
    lualine_b = { "branch", "diff", "diagnostics" },
    lualine_c = { "filename" },
    lualine_x = {
      { lsp_status },
      { "filetype" },
    },
    lualine_y = { { "progress" } },
    lualine_z = { "location" },
  },
  inactive_sections = {
    lualine_a = {},
    lualine_b = {},
    lualine_c = { "filename" },
    lualine_x = { "location" },
    lualine_y = {},
    lualine_z = {},
  },
  tabline = {},
  winbar = {},
  inactive_winbar = {},
  extensions = {},
}

return {
  "nvim-lualine/lualine.nvim",
  dependencies = { "nvim-tree/nvim-web-devicons" },
  config = function()
    vim.api.nvim_create_autocmd("User", {
      pattern = "DebugModeChanged",
      callback = function(args)
        dmode_enabled = args.data.enabled
      end,
    })
    require("lualine").setup(lualine_config)
  end,
}
