require("telescope").load_extension("git_worktree")
require("harpoon")

local map = vim.api.nvim_set_keymap

-- map the leader key
map('n', '<Space>', '', {})
vim.g.mapleader = ' '

local keymapOpts = { noremap = true, silent = true }
-- git worktree related
map('n', '<Leader>br', "<cmd>:lua require('telescope').extensions.git_worktree.git_worktrees()<CR>", keymapOpts)
map('n', '<Leader>bc', "<cmd>:lua require('telescope').extensions.git_worktree.create_git_worktree()<CR>", keymapOpts)

-- telescope related
map('n', '<C-p>', "<cmd>Telescope find_files<CR>", keymapOpts)
map('n', '<C-F>', "<cmd>Telescope live_grep<CR>", keymapOpts)
map('n', '<Leader>fb', "<cmd>Telescope buffers<CR>", keymapOpts)
map('n', '<Leader>fh', "<cmd>Telescope help_tags<CR>", keymapOpts)

-- harpoon related
map('n', '<Leader>j', "<cmd>:lua require('harpoon.ui').nav_file(1)<CR>", keymapOpts)
map('n', '<Leader>k', "<cmd>:lua require('harpoon.ui').nav_file(2)<CR>", keymapOpts)
map('n', '<Leader>l', "<cmd>:lua require('harpoon.ui').nav_file(3)<CR>", keymapOpts)
map('n', '<Leader>;', "<cmd>:lua require('harpoon.ui').nav_file(4)<CR>", keymapOpts)
map('n', '<C-n>', "<cmd>:lua require('harpoon.ui').toggle_quick_menu()<CR>", keymapOpts)
map('n', '<Leader>a', "<cmd>:lua require('harpoon.mark').add_file()<CR>", keymapOpts)

