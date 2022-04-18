require("telescope").load_extension("git_worktree")

local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local keymapOpts = { noremap = true, silent = true }

-- git worktree related
map('n', '<Leader>br', "<cmd>:lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", keymapOpts)
map('n', '<Leader>bc', "<cmd>:lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", keymapOpts)

-- telescope related
map('n', '<Leader>p', "<cmd>Telescope find_files<CR>", keymapOpts)
map('n', '<Leader>pg', "<cmd>Telescope live_grep<CR>", keymapOpts)
map('n', '<Leader>fb', "<cmd>Telescope buffers<CR>", keymapOpts)
map('n', '<Leader>fh', "<cmd>Telescope help_tags<CR>", keymapOpts)


