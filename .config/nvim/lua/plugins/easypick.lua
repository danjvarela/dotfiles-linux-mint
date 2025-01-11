return {
  "axkirillov/easypick.nvim",
  dependencies = { "nvim-telescope/telescope.nvim" },
  config = function()
    local easypick = require("easypick")

    local function branch_name()
      local branch = vim.fn.system("git branch --show-current 2> /dev/null | tr -d '\n'")
      if branch ~= "" then
        return branch
      else
        return ""
      end
    end

    easypick.setup({
      pickers = {
        -- diff current branch with base_branch and show files that changed with respective diffs in preview
        {
          name = "changed_files",
          command = "git diff --name-only $(git merge-base HEAD " .. branch_name() .. " )",
          previewer = easypick.previewers.branch_diff({ base_branch = branch_name() }),
        },

        -- list files that have conflicts with diffs in preview
        {
          name = "conflicts",
          command = "git diff --name-only --diff-filter=U --relative",
          previewer = easypick.previewers.file_diff(),
        },
      },
    })
  end,
}
