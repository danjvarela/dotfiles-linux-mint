-- Keymaps are automatically loaded on the VeryLazy event
-- Default keymaps that are always set: https://github.com/LazyVim/LazyVim/blob/main/lua/lazyvim/config/keymaps.lua
-- Add any additional keymaps here

local function map(mode, lhs, rhs, opts)
  local keys = require("lazy.core.handler").handlers.keys
  ---@cast keys LazyKeysHandler
  -- do not create the keymap if a lazy keys handler exists
  if not keys.active[keys.parse({ lhs, mode = mode }).id] then
    opts = opts or {}
    opts.silent = opts.silent ~= false
    if opts.remap and not vim.g.vscode then
      opts.remap = nil
    end
    vim.keymap.set(mode, lhs, rhs, opts)
  end
end

map("n", "<leader>bc", "<cmd>let @+ = expand('%:p')<CR>", { desc = "Copy current buffer path to clipboard" })

map({ "n", "x" }, "<leader>gx", "<cmd>Easypick conflicts<cr>", { desc = "Show files with git conflicts" })

map({ "n", "x" }, "<leader>gC", "<cmd>Telescope git_bcommits<cr>", { desc = "Show git commits on this buffer" })
