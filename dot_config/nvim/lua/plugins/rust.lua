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
      local docker_lsp = require("config.docker-lsp")

      vim.g.rustaceanvim = {
        dap = {
          adapter = {
            type = "server",
            port = "${port}",
            executable = {
              command = vim.fn.stdpath("data") .. "/mason/bin/codelldb",
              args = { "--port", "${port}" },
            },
          },
          autoload_configurations = true,
          load_rust_types = true,
        },
        server = {
          -- Resolved lazily when the LSP attaches to the current buffer.
          -- If a claude-agent container matches an ancestor dir of the
          -- buffer, returns a docker-exec RPC client; otherwise nil so
          -- rustaceanvim falls back to its default host rust-analyzer.
          cmd = function()
            local bufname = vim.api.nvim_buf_get_name(0)
            local start = bufname ~= "" and vim.fn.fnamemodify(bufname, ":h") or vim.fn.getcwd()
            local cmd, container, worktree =
              docker_lsp.rust_analyzer_cmd({ start_dir = start, silent = true })
            if cmd then
              vim.schedule(function()
                vim.notify(
                  string.format("[rust] rust-analyzer in %s (worktree: %s)", container, worktree),
                  vim.log.levels.INFO
                )
              end)
              return cmd
            end
            -- Fallback: host rust-analyzer (mason or PATH)
            local mason_bin = vim.fn.stdpath("data") .. "/mason/bin/rust-analyzer"
            local bin = vim.fn.executable(mason_bin) == 1 and mason_bin or "rust-analyzer"
            return { bin }
          end,
          settings = {
            ["rust-analyzer"] = {
              -- File watching: bind mounts from macOS into Linux containers
              -- don't propagate inotify reliably. Force rust-analyzer to use
              -- the LSP client (nvim) for file change notifications.
              files = {
                watcher = "client",
                -- Exclude directories that don't need watching (reduces inotify load)
                excludeDirs = { ".git", "node_modules", ".direnv", ".devenv" },
              },
              -- Memory and performance tuning
              cachePriming = {
                enable = false,  -- Don't preload all workspace crates at startup
              },
              lru = {
                capacity = 128,  -- Limit in-memory crate cache (default: 256)
              },
              -- Disable parallel processing to reduce memory spikes
              numThreads = 4,  -- Limit to 4 threads (default: #CPUs)
              cargo = {
                allFeatures = true,
                -- Don't auto-refresh proc-macros / build-scripts on every
                -- buffer event; refresh only when explicitly requested.
                buildScripts = {
                  enable = true,
                  rebuildOnSave = false,
                },
              },
              check = {
                command = "clippy",
                -- Don't run clippy over the entire workspace on every save.
                workspace = false,
                extraArgs = { "--no-deps" },
              },
              -- Only re-check on save, not on every keystroke / event.
              checkOnSave = true,
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
                -- Disable proc-macro expansion entirely. rust-analyzer's
                -- proc-macro server panics on malformed token streams from
                -- some derive macros in this workspace (e.g. config's
                -- get_help generation), which takes the whole LSP down.
                -- Disabling expansion loses some completions/hover on
                -- macro-heavy code but keeps the LSP alive.
                enable = false,
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
