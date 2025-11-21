return {
  {
    "mrcjkb/rustaceanvim",
    version = "^5",
    lazy = false,
    ft = { "rust" },
    dependencies = {
      "mfussenegger/nvim-dap",
    },
    config = function()
      vim.g.rustaceanvim = {
        dap = {
          autoload_configurations = true,
        },
        server = {
          settings = {
            ["rust-analyzer"] = {
              cargo = {
                allFeatures = true,
              },
              checkOnSave = {
                command = "clippy",
              },
              completion = {
                postfix = {
                  enable = false,
                },
              },
              diagnostics = {
                experimental = {
                  enable = false,
                },
              },
              hover = {
                enable = false,
              },
              lens = {
                enable = true,
              },
              procMacro = {
                ignored = {
                  leptos_macro = {
                    "component",
                    "server",
                  },
                },
              },
            },
          },
        },
      }
    end,
    keys = {
      { "<leader>rr", "<cmd>RustLsp runnables<cr>", desc = "Rust Runnables", ft = "rust" },
      { "<leader>rd", "<cmd>RustLsp debuggables<cr>", desc = "Rust Debuggables", ft = "rust" },
      { "<leader>rt", "<cmd>RustLsp testables<cr>", desc = "Rust Testables", ft = "rust" },
      { "<leader>rl", "<cmd>RustLsp! runnables<cr>", desc = "Rust Re-run Last", ft = "rust" },
      { "<leader>re", "<cmd>RustLsp expandMacro<cr>", desc = "Rust Expand Macro", ft = "rust" },
      { "<leader>rc", "<cmd>RustLsp openCargo<cr>", desc = "Rust Open Cargo.toml", ft = "rust" },
      { "<leader>rp", "<cmd>RustLsp parentModule<cr>", desc = "Rust Parent Module", ft = "rust" },
      { "<leader>rm", "<cmd>RustLsp rebuildProcMacros<cr>", desc = "Rust Rebuild Proc Macros", ft = "rust" },
    },
  },
  {
    "mason-org/mason.nvim",
    opts = {
      ensure_installed = {
        "rust-analyzer",
        "codelldb",
      },
    },
  },
}
