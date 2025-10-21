-- This module sets up nvim-dap for debugging Python applications using debugpy.
-- Fixed by ChatGPT (root detection + venv selection)

-- 🔍 Detect project root using git or fallback to cwd
local function get_project_root()
  local cwd = vim.fn.getcwd()
  local root = vim.fn.systemlist("git -C " .. cwd .. " rev-parse --show-toplevel")[1]
  if root and vim.fn.isdirectory(root) == 1 then return root end
  return cwd
end

return {
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require "dap"

      -- 🐍 Try to use local venv Python for debugpy itself
      local function get_python()
        local cwd = vim.fn.getcwd()
        local candidates = {
          cwd .. "/.venv/bin/python",
          cwd .. "/venv/bin/python",
          cwd .. "/env/bin/python",
        }
        for _, path in ipairs(candidates) do
          if vim.fn.executable(path) == 1 then return path end
        end
        return vim.fn.exepath "python" or "python"
      end

      local python_path = get_python()

      -- ⚙️ DAP adapter using detected Python
      dap.adapters.python = {
        type = "executable",
        command = python_path,
        args = { "-m", "debugpy.adapter" },
      }

      -- 🧠 Debug configuration: run file from project root, using proper venv
      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch current file (custom)",
          program = "${file}",
          cwd = get_project_root(), -- ✅ Added this
          pythonPath = get_python, -- ✅ Fixed this
        },
      }

      vim.notify("DAP Python adapter using: " .. python_path)
    end,
  },
}

-- return {
--
--   -- Ensure nvim-dap and debugpy are set up
--   {
--     "mfussenegger/nvim-dap",
--     config = function()
--       local dap = require("dap")
--
--       dap.adapters.python = {
--         type = "executable",
--         command = "python", -- fallback
--         args = { "-m", "debugpy.adapter" },
--       }
--
--       dap.configurations.python = {
--         {
--           type = "python",
--           request = "launch",
--           name = "Launch current file (custom)",
--           program = "${file}",
--           pythonPath = function()
--             local cwd = vim.fn.getcwd()
--             local paths = {
--               cwd .. "/.venv/bin/python",
--               cwd .. "/venv/bin/python",
--               cwd .. "/env/bin/python",
--             }
--             for _, python in ipairs(paths) do
--               if vim.fn.executable(python) == 1 then
--                 return python
--               end
--             end
--             return vim.fn.exepath("python") or "python"
--           end,
--         },
--       }
--     end,
--   },
-- }
--
