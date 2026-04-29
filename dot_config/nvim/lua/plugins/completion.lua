return {
  {
    "saghen/blink.cmp",
    opts = {
      keymap = {
        preset = "enter",
        ["<Tab>"] = { "select_next", "fallback" },
        ["<S-Tab>"] = { "select_prev", "fallback" },
      },
    },
  },
  { "zbirenbaum/copilot.lua", enabled = false },
  { "blink-copilot", enabled = false },
  { "MeanderingProgrammer/render-markdown.nvim", enabled = false },
}