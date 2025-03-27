vim.api.nvim_create_augroup("PrologFiletype", { clear = true })
vim.api.nvim_create_autocmd({ "BufRead", "BufNewFile" }, {
    pattern = "*.pl",
    callback = function()
        vim.bo.filetype = "prolog"
    end,
})

