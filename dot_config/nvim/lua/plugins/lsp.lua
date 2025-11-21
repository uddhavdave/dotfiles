return {
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- Disable taplo to prevent schema errors
        taplo = false,
        -- Disable rust_analyzer - rustaceanvim handles this
        rust_analyzer = false,
      },
    },
  },
}