return {
  {
    "saghen/blink.cmp",
    version = "*", -- needed for fuzzy binary download
    dependencies = "rafamadriz/friendly-snippets",
    event = "InsertEnter",
    ---@type blink.cmp.Config
    opts = {
      keymap = {
        preset = "default", -- use 'default' as the base preset
        ["<C-j>"] = { "select_next", "fallback" }, -- Move down in the suggestion window
        ["<C-k>"] = { "select_prev", "fallback" }, -- Move up in the suggestion window
      },
      sources = { default = { "lsp", "path", "snippets", "buffer" } },
    },
  },
  {
    "neovim/nvim-lspconfig",
    dependencies = {
      "saghen/blink.cmp",
      "williamboman/mason-lspconfig.nvim",
    },
    event = "VeryLazy",
    -- opts = {
    --   servers = {
    --     clangd = {},
    --     cmake = {},
    --     cssls = {},
    --     dockerls = {},
    --     emmet_ls = {},
    --     graphql = {},
    --     html = {},
    --     jdtls = {},
    --     jsonls = {},
    --     lemminx = {},
    --     lua_ls = {
    --       settings = {
    --         Lua = {
    --           runtime = {
    --             version = "LuaJIT",
    --           },
    --           diagnostics = {
    --             globals = { "vim" },
    --           },
    --           workspace = {
    --             library = vim.api.nvim_get_runtime_file("", true),
    --             checkThirdParty = false,
    --           },
    --           telemetry = {
    --             enable = false,
    --           },
    --         },
    --       },
    --     },
    --     marksman = {},
    --     prismals = {},
    --     pylsp = {},
    --     svelte = {},
    --     tailwindcss = {},
    --     ts_ls = {},
    --     vimls = {},
    --   },
    -- },
    config = function(_, opts)
      local lspconfig = require("lspconfig")
      local blink = require("blink.cmp")

      vim.diagnostic.config({
        virtual_text = {
          prefix = "●",
          --     spacing = 4, -- Space between symbol and text
          -- format = function(diagnostic)
          --   local symbols = {
          --     [vim.diagnostic.severity.ERROR] = "✗",
          --     [vim.diagnostic.severity.WARN] = "⚠",
          --     [vim.diagnostic.severity.INFO] = "ℹ",
          --     [vim.diagnostic.severity.HINT] = "➤",
          --   }
          --   return string.format("%s %s", symbols[diagnostic.severity], diagnostic.message)
          -- end,
          signs = true,
          underline = true,
          update_in_insert = false,
          severity_sort = true,
        },
      })

      vim.api.nvim_create_autocmd("LspAttach", {
        callback = function(e)
          local buf = e.buf
          local opts = { buffer = buf, noremap = true, silent = true }
          local keymap = vim.keymap.set

          keymap("n", "gd", vim.lsp.buf.definition, vim.tbl_extend("force", opts, { desc = "Go to definition" }))

          keymap("n", "gD", function()
            vim.lsp.buf.declaration()
          end, vim.tbl_extend("force", opts, { desc = "Go to declaration" }))

          keymap("n", "gy", function()
            Snacks.picker.lsp_type_definitions()
          end, vim.tbl_extend("force", opts, { desc = "Go to type definition" }))

          keymap("n", "gS", function()
            Snacks.picker.lsp_symbols()
          end, vim.tbl_extend("force", opts, { desc = "List symbols" }))

          keymap("n", "gr", function()
            Snacks.picker.lsp_references()
          end, vim.tbl_extend("force", opts, { desc = "List references" }))

          keymap("n", "gI", function()
            Snacks.picker.lsp_implementations()
          end, vim.tbl_extend("force", opts, { desc = "Go to implementation" }))

          keymap("n", "K", vim.lsp.buf.hover, vim.tbl_extend("force", opts, { desc = "Show hover information" }))

          keymap("n", "<leader>la", function()
            vim.lsp.buf.code_action()
          end, vim.tbl_extend("force", opts, { desc = "Show code actions" }))

          keymap("n", "<leader>lr", function()
            vim.lsp.buf.rename()
          end, vim.tbl_extend("force", opts, { desc = "Rename symbol" }))

          keymap("n", "<leader>lk", function()
            vim.diagnostic.open_float()
          end, vim.tbl_extend("force", opts, { desc = "Show diagnostics" }))

          keymap("n", "<leader>ln", function()
            vim.diagnostic.goto_next()
          end, vim.tbl_extend("force", opts, { desc = "Go to next diagnostic" }))

          keymap("n", "<leader>lp", function()
            vim.diagnostic.goto_prev()
          end, vim.tbl_extend("force", opts, { desc = "Go to previous diagnostic" }))
        end,
      })

      -- for server, config in pairs(opts.servers) do
      --   config.capabilities = blink.get_lsp_capabilities(config.capabilities)
      --   lspconfig[server].setup(config)
      -- end
    end,
  },
}
