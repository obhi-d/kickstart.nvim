return {
  'nvim-tree/nvim-tree.lua',
  version = '*',
  lazy = false,
  dependencies = {
    'nvim-tree/nvim-web-devicons',
  },
  config = function()
    require('nvim-tree').setup {
      update_focused_file = {
        enable = true,
        update_root = {
          enable = false,
          ignore_list = {},
        },
        exclude = false,
      },
    }
    vim.api.nvim_set_keymap('n', '<leader>e', ':NvimTreeToggle<CR>', { noremap = true, silent = true })
  end,
}
