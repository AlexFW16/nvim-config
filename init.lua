-- This file simply bootstraps the installation of Lazy.nvim and then calls other files for execution
-- This file doesn't necessarily need to be touched, BE CAUTIOUS editing this file and proceed at your own risk.
local lazypath = vim.env.LAZY or vim.fn.stdpath "data" .. "/lazy/lazy.nvim"
if not (vim.env.LAZY or (vim.uv or vim.loop).fs_stat(lazypath)) then
  -- stylua: ignore
  vim.fn.system({ "git", "clone", "--filter=blob:none", "https://github.com/folke/lazy.nvim.git", "--branch=stable", lazypath })
end
vim.opt.rtp:prepend(lazypath)

-- validate that lazy is available
if not pcall(require, "lazy") then
  -- stylua: ignore
  vim.api.nvim_echo({ { ("Unable to load lazy from: %s\n"):format(lazypath), "ErrorMsg" }, { "Press any key to exit...", "MoreMsg" } }, true, {})
  vim.fn.getchar()
  vim.cmd.quit()
end

if vim.fn.has "nvim" == 1 then
  vim.env.TERM = "alacritty"
  vim.env.TERMINANL = "alacritty"
end

-- my stuff
vim.opt.shell = "/bin/bash"
vim.env.JAVA_HOME = "/usr/lib/jvm/java-17-openjdk-amd64"
vim.env.PATH = vim.env.PATH .. ":/usr/lib/jvm/java-17-openjdk-amd64/bin"

-- setup for ast-grep bc it doesnt find config

require "lazy_setup"
require "polish"

-- my stuff
require "lsp"
require "prolog"
