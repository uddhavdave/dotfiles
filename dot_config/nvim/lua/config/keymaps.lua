-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

vim.keymap.set("v", "<leader>yr", function()
  local file = vim.fn.expand("%")
  local start_line = vim.fn.line("v")
  local end_line = vim.fn.line(".")

  if start_line > end_line then
    start_line, end_line = end_line, start_line
  end

  local ref = file .. ":" .. start_line .. "-" .. end_line

  vim.fn.setreg("+", ref)
  print("Copied reference: " .. ref)
end, { desc = "Copy code range reference" })
