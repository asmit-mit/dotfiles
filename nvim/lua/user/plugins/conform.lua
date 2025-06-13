return {
  "stevearc/conform.nvim",
  event = { "BufReadPre", "BufNewFile" },
  config = function()
    local conform = require("conform")

    conform.setup({
      formatters_by_ft = {
        javascript = { "prettier" },
        typescript = { "prettier" },
        javascriptreact = { "prettier" },
        typescriptreact = { "prettier" },
        svelte = { "prettier" },
        css = { "prettier" },
        html = { "prettier" },
        json = { "prettier" },
        yaml = { "prettier" },
        markdown = { "prettier" },
        graphql = { "prettier" },
        liquid = { "prettier" },
        lua = { "stylua" },
        python = { "isort", "black" },
        cpp = { "clang-format" },
        c = { "clang-format" },
        java = { "clang-format" },
        cmake = { "gersemi" },
        xml = { "xmlformatter" },
      },
      formatters = {
        black = {
          prepend_args = { "--line-length", "79" },
        },
        isort = {
          prepend_args = { "--line-length", "79" },
        },
        ["clang-format"] = {
          prepend_args = {
            "--style={BasedOnStyle: LLVM, AlignAfterOpenBracket: BlockIndent, AlignConsecutiveAssignments: Consecutive}",
          },
        },
        prettier = {
          prepend_args = { "--print-width", "100" },
        },
      },
      format_on_save = {
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      },
    })

    vim.keymap.set({ "n", "v" }, "<leader>fm", function()
      conform.format({
        lsp_fallback = true,
        async = false,
        timeout_ms = 1000,
      })
    end, { desc = "Format file or range (in visual mode)" })
  end,
}
