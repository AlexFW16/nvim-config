-- my lsp settings
local lspconfig = require('lspconfig')


lspconfig.ltex.setup {
    settings = {
        ltex= {language = "en-GB"} -- set language to brittish
    }
}

