-- This module sets up nvim-dap for debugging Python applications using debugpy.
-- ChatGPT created

return {
  -- Ensure nvim-dap and debugpy are set up
  {
    "mfussenegger/nvim-dap",
    config = function()
      local dap = require("dap")

      dap.adapters.python = {
        type = "executable",
        command = "python", -- fallback
        args = { "-m", "debugpy.adapter" },
      }

      dap.configurations.python = {
        {
          type = "python",
          request = "launch",
          name = "Launch current file (custom)",
          program = "${file}",
          pythonPath = function()
            local cwd = vim.fn.getcwd()
            local paths = {
              cwd .. "/.venv/bin/python",
              cwd .. "/venv/bin/python",
              cwd .. "/env/bin/python",
            }
            for _, python in ipairs(paths) do
              if vim.fn.executable(python) == 1 then
                return python
              end
            end
            return vim.fn.exepath("python") or "python"
          end,
        },
      }
    end,
  },
}

