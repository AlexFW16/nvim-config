local lspconfig = require "lspconfig"

-- 1) Global: only show WARN+ERROR (no HINT/INFO) for all LSP servers
vim.diagnostic.config {
  virtual_text = {
    severity = { min = vim.diagnostic.severity.WARN },
    spacing = 4,
  },
  signs = true,
  underline = false,
  update_in_insert = false,
}

-- 2) (Optional) Ensure floating diagnostics also respect WARN+ERROR
vim.lsp.handlers["textDocument/publishDiagnostics"] = vim.lsp.with(vim.lsp.diagnostic.on_publish_diagnostics, {
  severity_limit = "Warning",
})

-- 3) Your LTEX server setup
lspconfig.ltex.setup {
  settings = {
    ltex = {
      language = "en-GB",
    },
  },
}

-- 4) Any other servers…
-- lspconfig.pyright.setup{}
-- lspconfig.r_language_server.setup{}
