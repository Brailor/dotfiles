local Worktree = require('git-worktree')

local function is_instui(path)
      local found = path:find("instui")

      return type(found) == 'number' and found > 0
end

Worktree.on_tree_change(function(op, metadata)
  if (op == Worktree.Operations.Switch or op == Worktree.Operations.Create) and is_instui(metadata.path) then
          local command = string.format(":!tmux-instui-bootstrap.sh %s", metadata.path)
          vim.cmd(command)
  end
end)
