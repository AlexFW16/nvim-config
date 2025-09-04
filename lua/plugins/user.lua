-- You can also add or configure plugins by creating files in this `plugins/` folder
-- Here are some examples:

---@type LazySpec
return {

  -- == Examples of Adding Plugins ==

  "andweeb/presence.nvim",
  {
    "ray-x/lsp_signature.nvim",
    event = "BufRead",
    config = function() require("lsp_signature").setup() end,
  },

  -- == Examples of Overriding Plugins ==

  -- customize alpha options
  {
    "goolord/alpha-nvim",
    opts = function(_, opts)
      -- customize the dashboard header
      opts.section.header.val = {

        "      ██████           ██     ██  ██  ██       ██       ",
        "     ██    ██          ██     ██  ██  ███     ███        ",
        "     ██    ██  ██  ██   ██   ██   ██  ██ ██ ██ ██    ",
        "     ██    ██    ██      ██ ██    ██  ██  ██   ██",
        "      ██████   ██  ██     ███     ██  ██       ██    ",
      }
      return opts
    end,
  },

  -- You can disable default plugins as follows:
  { "max397574/better-escape.nvim", enabled = false },

  -- You can also easily customize additional setup of plugins that is outside of the plugin's setup call
  {
    "L3MON4D3/LuaSnip",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.luasnip"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom luasnip configuration such as filetype extend or custom snippets
      local luasnip = require "luasnip"
      luasnip.filetype_extend("javascript", { "javascriptreact" })
    end,
  },

  {
    "windwp/nvim-autopairs",
    config = function(plugin, opts)
      require "astronvim.plugins.configs.nvim-autopairs"(plugin, opts) -- include the default astronvim config that calls the setup call
      -- add more custom autopairs configuration such as custom rules
      local npairs = require "nvim-autopairs"
      local Rule = require "nvim-autopairs.rule"
      local cond = require "nvim-autopairs.conds"
      npairs.add_rules(
        {
          Rule("$", "$", { "tex", "latex" })
            -- don't add a pair if the next character is %
            :with_pair(cond.not_after_regex "%%")
            -- don't add a pair if  the previous character is xxx
            :with_pair(
              cond.not_before_regex("xxx", 3)
            )
            -- don't move right when repeat character
            :with_move(cond.none())
            -- don't delete if the next character is xx
            :with_del(cond.not_after_regex "xx")
            -- disable adding a newline when you press <cr>
            :with_cr(cond.none()),
        },
        -- disable for .vim files, but it work for another filetypes
        Rule("a", "a", "-vim")
      )
    end,
  },
  {
    "MeanderingProgrammer/render-markdown.nvim",
    dependencies = { "nvim-treesitter/nvim-treesitter", "echasnovski/mini.nvim" }, -- if you use the mini.nvim suite
    -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'echasnovski/mini.icons' }, -- if you use standalone mini plugins
    --     -- dependencies = { 'nvim-treesitter/nvim-treesitter', 'nvim-tree/nvim-web-devicons' }, -- if you prefer nvim-web-devicons
    --         ---@module 'render-markdown'
    --             ---@type render.md.UserConfig
    --                 opts = {},
    --                 }
  },

  {
    "nvim-zh/colorful-winsep.nvim", -- colorful seperators
    config = true,
    event = { "WinLeave" },
  },
  {
    "jbyuki/nabla.nvim", -- display inline latex
  },

  -- themes

  {
    "morhetz/gruvbox",
    name = "gruvbox",
    priority = 1000,
    config = function()
      vim.g.gruvbox_vert_split = "red"
      vim.g.gruvbox_transparent_bg = true
    end,
    --, gruvbox_contrast_dark = 'hard'
  },

  { "catppuccin/nvim", name = "catppuccin", priority = 999 },

  {
    "github/copilot.vim",
    event = "InsertEnter",
    config = function()
      vim.keymap.set("i", "<S-Tab>", 'copilot#Accept("\\<CR>")', {
        expr = true,
        replace_keycodes = false,
      })
      vim.g.copilot_no_tab_map = true
      -- vim.cmd [[highlight CopilotSuggestion guifg=#a08060    ctermfg=203]]
      vim.cmd [[highlight CopilotSuggestion guifg=#a06e56     ctermfg=203]]
    end,
  },

  -- when moving smth in neo-tree, the cursor is
  -- set to the first slash before the filename
  {
    "nvim-neo-tree/neo-tree.nvim",
    branch = "v3.x",
    dependencies = {
      "nvim-lua/plenary.nvim",
      "nvim-tree/nvim-web-devicons",
      "MunifTanjim/nui.nvim",
    },
    -- opts = {filesystem ={ renderer = { components = {"icon", "name", "size"}}}}, -- Would always expand size to show everything (like pressing e)
    config = function()
      require("neo-tree").setup {
        -- custom command to show all file infos
        filesystem = {
          window = {
            mappings = {
              ["E"] = "expand_all_stats",
              ["Y"] = "copy_path_from_root",
            },
          },
          commands = {
            expand_all_stats = function(state)
              vim.notify(tostring(vim.api.nvim_win_get_width(vim.api.nvim_get_current_win())))

              if vim.api.nvim_win_get_width(vim.api.nvim_get_current_win()) >= 100 then
                require("neo-tree.sources.filesystem.commands").toggle_auto_expand_width(state)
                -- vim.api.nvim_win_set_width(state.winid, 100)
              else
                vim.api.nvim_win_set_width(state.winid, 100)
              end
              -- require"neo-tree.sources.filesystem.commands".open_vsplit(state)
            end,

            -- to copy path relative to root
            copy_path_from_root = function(state)
              local node = state.tree:get_node()
              if node.type ~= "file" and node.type ~= "directory" then return end
              local path = node.path
              local root = state.path
              if not root or root == "" then root = vim.loop.cwd() end
              local relative_path = string.sub(path, #root + 2)
              vim.fn.setreg("+", relative_path)
              vim.notify("Copied to clipboard: " .. relative_path)
            end,
          },
        },

        -- your other neo-tree options here (filesystem, default_component_configs, etc.)
        event_handlers = {
          {
            event = "neo_tree_popup_input_ready",
            handler = function(args)
              pcall(function()
                local bufnr, winid = args.bufnr, args.winid
                if not bufnr or not winid then return end

                -- read first line of popup buffer
                local line = vim.api.nvim_buf_get_lines(bufnr, 0, 1, false)[1] or ""
                -- find last slash or backslash
                local pos
                for i = #line, 1, -1 do
                  local ch = line:sub(i, i)
                  if ch == "/" or ch == "\\" then
                    pos = i
                    break
                  end
                end

                local col = 0
                if pos then
                  -- pos is 1-based char index of slash; set col to pos to place cursor after slash
                  col = pos
                end

                -- schedule to avoid races with Nui/Neo-tree internals
                vim.schedule(function()
                  vim.api.nvim_win_set_cursor(winid, { 1, col })
                  -- if popup lost insert mode, re-enter insert (optional)
                  -- Exit insert mode if active
                  vim.api.nvim_feedkeys(vim.api.nvim_replace_termcodes("<Esc>", true, false, true), "n", true)
                  -- Start visual mode (selecting 1 char)
                  -- vim.api.nvim_feedkeys("v", "n", true)
                end)
              end)
            end,
          },
        },
      }
    end,
  },

      },
    })
  end,
},


  -- not working as intended yet
  --
  -- {
  -- "backdround/tabscope.nvim",
  --   config = function()
  --     require("tabscope").setup({})
  --   end,
  --   }
}
