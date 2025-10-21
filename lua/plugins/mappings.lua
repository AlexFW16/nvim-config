return {
  {
    "AstroNvim/astrocore",
    ---@type AstroCoreOpts
    opts = {
      mappings = {
        -- first key is the mode
        n = {
          -- second key is the lefthand side of the map
          -- mappings seen under group name "Buffer"
          ["<Leader>bn"] = { "<cmd>tabnew<cr>", desc = "New tab" },
          ["<Leader>bD"] = {
            function()
              require("astroui.status").heirline.buffer_picker(
                function(bufnr) require("astrocore.buffer").close(bufnr) end
              )
            end,
            desc = "Pick to close",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { name = "Buffers" },
          ["<Leader>z"] = { name = "Custom Mappings" },
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
          -- Run menu
          ["<Leader>r"] = { name = "Run" },
          ["<Leader>rf"] = {
            function()
              require("toggleterm.terminal").Terminal
                :new({ cmd = "python " .. vim.fn.expand "%", direction = "float" })
                :toggle()
            end,
            desc = "Run current file",
          },
          ["<Leader>rp"] = {
            function()
              require("toggleterm.terminal").Terminal
                :new({ cmd = "python3 " .. vim.fn.expand "%", direction = "horizontal", close_on_exit = false })
                :toggle()
            end,
            desc = "Run current file with Python 3",
          },
          ["<Leader>rn"] = {
            function()
              require("toggleterm.terminal").Terminal
                :new({ cmd = "node " .. vim.fn.expand "%", direction = "float" })
                :toggle()
            end,
            desc = "Run current file with Node.js",
          },
          ["<Leader>rb"] = {
            function() require("toggleterm.terminal").Terminal:new({ cmd = "make", direction = "float" }):toggle() end,
            desc = "Run make",
          },
          ["<Leader>rr"] = {
            function()
              require("toggleterm.terminal").Terminal
                :new({
                  cmd = "Rscript " .. vim.fn.shellescape(vim.fn.expand "%"),
                  direction = "horizontal",
                  close_on_exit = false,
                })
                :toggle()
            end,
            desc = "Run with Rscript",
          },

          -- Custom Keymaps
          --
          --
          ["<Leader>zm"] = {
            function()
              require "peek"
              if require("peek").is_open() then
                vim.cmd "PeekClose"
              else
                vim.cmd "PeekOpen"
              end
            end,
            desc = "Opens/Closes md preview",
          },
          ["<Leader>zl"] = {
            function()
              -- get the full path of the current file
              local file = vim.fn.expand "%:p"
              -- output HTML filename in the same folder
              local html = file:gsub("%.md$", ".html")
              -- run Pandoc with MathJax CDN
              local cmd = string.format(
                'pandoc "%s" -o "%s" --standalone --mathjax="https://cdn.jsdelivr.net/npm/mathjax@3/es5/tex-mml-chtml.js"',
                file,
                html
              )
              -- execute the command
              vim.fn.system(cmd)
              -- open in default browser
              vim.fn.system("wslview " .. html)
              print("Exported to " .. html .. " and opened in browser!")
            end,
            desc = "Renders and exports markdown with latex",
          },
          ["<Leader>fd"] = {
            function() require("telescope.builtin").diagnostics() end,
            desc = "Find diagnostics (buffer)",
          },
          ["<Leader>fD"] = {
            function() vim.cmd "Telescope lsp_workspace_diagnostics" end,
            desc = "Find diagnostics (all files)",
          },

          ["<Leader>zs"] = {
            function()
              vim.cmd "vsplit"
              vim.cmd "split"
              vim.cmd "resize 30"
              vim.cmd "terminal bash -i -c 'source ~/.bashrc && source venv/bin/activate && exec bash -li'" -- Opens a terminal and sources the venv, keeping the basrc setup
            end,
            desc = "COMPAC workspace setup",
          }, -- setup for COMPAC

          ["<Leader>zf"] = { function() vim.lsp.buf.format { async = true } end, desc = "LSP: Format file" }, -- Auto formats the file
        },

        t = {
          -- setting a mapping to false will disable it
          ["<esc>"] = false,
        },
      },
    },
  },
}
