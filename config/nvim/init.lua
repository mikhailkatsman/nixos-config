-- init.lua

-- Basic options
vim.opt.number = true
vim.opt.relativenumber = true
vim.opt.tabstop = 4
vim.opt.shiftwidth = 4
vim.opt.expandtab = true
vim.opt.termguicolors = true;
vim.opt.signcolumn = yes;

-- Set Leader Key
vim.g.mapleader = " "

-- LSP
vim.lsp.enable({ "nixd", "lua_ls", "phpactor" })

-- Completion
local cmp = require("cmp")
cmp.setup({
  mapping = {
    ["<Tab>"] = cmp.mapping.select_next_item(),
    ["<S-Tab>"] = cmp.mapping.select_prev_item(),
  },
  sources = {
    { name = "nvim_lsp" },
    { name = "buffer" },
    { name = "path" },
  }
})

-- Tree-sitter
require("nvim-treesitter").setup({
  highlight = { enable = true },
  indent = { enable = true },
})

require("nvim-autopairs").setup()

require("nvim-tree").setup({
    filters = {
        dotfiles = false,
        custom = {}
    },
    git = {
        enable = true,
        ignore = false
    }
})

local function grep_from_files()
  require("fzf-lua").live_grep()
end

require("fzf-lua").setup({
  files = {
    actions = {
      ["ctrl-g"] = grep_from_files,
    },
  },
})

-- Keybinds
vim.keymap.set("n", "<leader><Tab>", ":NvimTreeToggle<CR>")
vim.keymap.set("n", "<leader>h", "<C-w>h")
vim.keymap.set("n", "<leader>l", "<C-w>l")
vim.keymap.set("n", "<leader>k", "<C-w>k")
vim.keymap.set("n", "<leader>j", "<C-w>j")
vim.keymap.set("t", "<leader><ESC>", "<C-\\><C-n>", {noremap = true})
vim.keymap.set("n", "<leader><leader>", ":FzfLua files<CR>")

-- Opencode Keybind
vim.keymap.set('n', '<leader>o', function()
    vim.cmd('botright vsplit')
    vim.cmd('vertical resize 70')
    vim.cmd('terminal opencode')
    vim.cmd('startinsert')
    vim.wo.winfixwidth = true
end, { desc = 'Open opencode' })

-- Colors
local dracula = require("dracula")
dracula.setup({
  italic_comment = true,
  transparent_bg = true,
})
vim.cmd("colorscheme dracula")
