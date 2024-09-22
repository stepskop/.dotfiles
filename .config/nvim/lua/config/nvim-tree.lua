return {
  filters = { dotfiles = false },
  renderer = {
    highlight_git = true,
    indent_markers = { enable = true },
    icons = {
      git_placement = 'after',
      modified_placement = 'after',
      glyphs = {
        git = {
          unmerged = '',
          untracked = '',
          renamed = '',
          unstaged = '*',
          staged = '',
          deleted = '',
          ignored = '',
        },
      },
    },
  },
}
