
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
              require("astroui.status").heirline.buffer_picker(function(bufnr)
                require("astrocore.buffer").close(bufnr)
              end)
            end,
            desc = "Pick to close",
          },
          -- tables with the `name` key will be registered with which-key if it's installed
          -- this is useful for naming menus
          ["<Leader>b"] = { name = "Buffers" },
          ["<Leader>z"] = { name = "Custom Mappings"},
          -- quick save
          -- ["<C-s>"] = { ":w!<cr>", desc = "Save File" },  -- change description but the same command
          -- Run menu
          ["<Leader>r"] = { name = "Run" },
          ["<Leader>rf"] = { function() require("toggleterm.terminal").Terminal:new({ cmd = "python " .. vim.fn.expand("%"), direction = "float" }):toggle() end, desc = "Run current file" },
          ["<Leader>rp"] = { function() require("toggleterm.terminal").Terminal:new({ cmd = "python3 " .. vim.fn.expand("%"), direction = "float" }):toggle() end, desc = "Run current file with Python 3" },
          ["<Leader>rn"] = { function() require("toggleterm.terminal").Terminal:new({ cmd = "node " .. vim.fn.expand("%"), direction = "float" }):toggle() end, desc = "Run current file with Node.js" },
          ["<Leader>rb"] = { function() require("toggleterm.terminal").Terminal:new({ cmd = "make", direction = "float" }):toggle() end, desc = "Run make" },

          -- Custom Keymaps
          ["<Leader>zs"] = { function()  vim.cmd("vsplit")
            vim.cmd("split")
            vim.cmd("resize 30")
            vim.cmd("terminal bash -i -c 'source ~/.bashrc && source venv/bin/activate && exec bash -li'") -- Opens a terminal and sources the venv, keeping the basrc setup

            end,
            desc = "COMPAC workspace setup" }, -- setup for COMPAC
        },       t = {
          -- setting a mapping to false will disable it
          ["<esc>"] = false,
        },
     },
    },
  },
}

