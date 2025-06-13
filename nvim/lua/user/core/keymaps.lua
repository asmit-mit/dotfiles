vim.g.mapleader = " "

local keymap = vim.keymap -- for conciseness
local opts = { noremap = true, silent = true }

-- Variable to keep track of the current recording register
local recording_register = nil

-- Function to start/stop macro recording with any register
function ToggleMacroWithRegister()
  if vim.fn.mode() ~= "n" then
    vim.cmd("stopinsert")
  end
  local register = vim.fn.input("Register (a-z): ")
  if register == "" then
    return
  end

  if recording_register == register then
    vim.api.nvim_command("normal! q")
    recording_register = nil
    print("Stopped recording in register " .. register)
  else
    vim.api.nvim_command("normal! q" .. register)
    recording_register = register
    print("Started recording in register " .. register)
  end

  if vim.fn.mode() ~= "n" then
    vim.cmd("stopinsert")
  end
end

-- Map '<leader>q' to the macro recording function instead of just 'q'
keymap.set("n", "<leader>q", ToggleMacroWithRegister, { noremap = true, silent = false, desc = "Record a macro" })

keymap.set("n", "<Esc>", ":nohl<CR>", { desc = "Clear search highlights" })

-- window management
keymap.set("n", "<leader>sv", "<C-w>v", { desc = "Split window vertically" }) -- split window vertically
keymap.set("n", "<leader>sh", "<C-w>s", { desc = "Split window horizontally" }) -- split window horizontally
keymap.set("n", "<leader>s=", "<C-w>=", { desc = "Make splits equal size" }) -- make split windows equal width & height
keymap.set("n", "<leader>sw", "<cmd>close<CR>", { desc = "Close current split" }) -- close current split window

keymap.set("n", "<leader>to", "<cmd>tabnew<CR>", { desc = "Open new tab" }) -- open new tab
keymap.set("n", "<leader>tn", "<cmd>tabn<CR>", { desc = "Go to next tab" }) --  go to next tab
keymap.set("n", "<leader>tp", "<cmd>tabp<CR>", { desc = "Go to previous tab" }) --  go to previous tab
keymap.set("n", "<leader>tw", "<cmd>tabclose<CR>", { desc = "Close current tab" }) -- close current tab
keymap.set("n", "<leader>tf", "<cmd>tabnew %<CR>", { desc = "Open current buffer in new tab" }) --  move current buffer to new tab

-- Resize with arrows
keymap.set("n", "<C-Up>", ":resize +2<CR>", opts)
keymap.set("n", "<C-Down>", ":resize -2<CR>", opts)
keymap.set("n", "<C-Left>", ":vertical resize +2<CR>", opts)
keymap.set("n", "<C-Right>", ":vertical resize -2<CR>", opts)

-- keymap.set("n", "<leader>mf", ":lua MiniFiles.open()<CR>", { noremap = true, silent = true, desc = "Open MiniFiles" })

keymap.set("n", "-", "<CMD>Oil<CR>", { desc = "Open parent directory" })

keymap.set(
  "n",
  "<leader>ra",
  [[:%s/\<<C-r><C-w>\>//gI<Left><Left><Left>]],
  { noremap = true, silent = false, desc = "Replace All" }
)

keymap.set("n", "<C-s>", ":w<CR>", { noremap = true, silent = true })
keymap.set("i", "<C-s>", "<Esc>:w<CR>a", { noremap = true, silent = true })

vim.g.black_linelength = 79

keymap.set("n", "<leader>ld", function()
  Snacks.picker.diagnostics()
end, { desc = "Diagnostics" })
keymap.set("n", "<leader>lD", function()
  Snacks.picker.diagnostics_buffer()
end, { desc = "Buffer Diagnostics" })
