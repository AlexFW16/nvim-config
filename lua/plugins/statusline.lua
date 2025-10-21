-- don't require windline at the top!
local M = {}

-- function M.setup()
--   function M.setup()
--     local windline = require "windline"
--     local helper = require "windline.helpers"
--
--     -- Add highlights for active/inactive windows
--     vim.cmd [[hi! WinlineActive guifg=#ffffff guibg=#5f87af]]
--     vim.cmd [[hi! WinlineInactive guifg=#888888 guibg=#3a3a3a]]
--
--     -- Add window separator arrows for the existing default line
--     local sep_left, sep_right = "", ""
--
--     -- Get existing default statusline
--     local statusline = windline.get_statusline "default"
--
--     -- Prepend left arrow and append right arrow to active/inactive components
--     for _, comps in pairs(statusline.active) do
--       table.insert(comps[1], 1, { provider = sep_left, hl = "WinlineActive" })
--       table.insert(comps[1], { provider = sep_right, hl = "WinlineActive" })
--     end
--
--     for _, comps in pairs(statusline.inactive) do
--       table.insert(comps[1], 1, { provider = sep_left, hl = "WinlineInactive" })
--       table.insert(comps[1], { provider = sep_right, hl = "WinlineInactive" })
--     end
--
--     -- Force windline to refresh
--     windline.update_statusline()
--   end
-- end

return M
