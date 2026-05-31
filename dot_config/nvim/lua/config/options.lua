-- Options are automatically loaded before lazy.nvim startup
-- Default options that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/options.lua
-- Add any additional options here

-- Increase timeout to prevent command cancelled popups
vim.g.copilot_no_tab_map = true
vim.opt.updatetime = 250
vim.opt.timeoutlen = 500
vim.g.snacks_animate = false

-- Use OSC 52 clipboard inside Docker (no pbcopy/xclip available)
if vim.fn.filereadable("/.dockerenv") == 1 then
  pcall(function()
    local osc52 = require("vim.ui.clipboard.osc52")
    -- osc52.copy(reg) returns function(lines); osc52.paste(reg) returns function()
    -- nvim calls copy["+"] = function(lines, regtype), paste["+"] = function()
    vim.g.clipboard = {
      name = "OSC 52",
      copy = {
        ["+"] = osc52.copy("+"),
        ["*"] = osc52.copy("*"),
      },
      paste = {
        ["+"] = osc52.paste("+"),
        ["*"] = osc52.paste("*"),
      },
    }
  end)
end
vim.opt.clipboard = "unnamedplus"
