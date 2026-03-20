-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    cmd = { 'NvimTreeToggle', 'NvimTreeOpen', 'NvimTreeFocus' },
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'File [E]xplorer' },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function() require('nvim-tree').setup {} end,
  },
  {
    'nvimdev/dashboard-nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      theme = 'doom',
      config = {
        header = {
          '',
          ' ███╗   ██╗███████╗ ██████╗ ',
          ' ████╗  ██║██╔════╝██╔═══██╗',
          ' ██╔██╗ ██║█████╗  ██║   ██║',
          ' ██║╚██╗██║██╔══╝  ██║   ██║',
          ' ██║ ╚████║███████╗╚██████╔╝',
          ' ╚═╝  ╚═══╝╚══════╝ ╚═════╝ ',
          '',
          '',
        },
        center = {
          { icon = '  ', desc = 'Find File        ', key = 'f', action = 'Telescope find_files' },
          { icon = '  ', desc = 'Recent Files     ', key = 'r', action = 'Telescope oldfiles' },
          { icon = '  ', desc = 'Find Word        ', key = 'g', action = 'Telescope live_grep' },
          { icon = '  ', desc = 'File Tree        ', key = 'e', action = 'NvimTreeToggle' },
          { icon = '  ', desc = 'Quit             ', key = 'q', action = 'qa' },
        },
      },
    },
  },
  {
    'nvim-flutter/flutter-tools.nvim',
    lazy = false,
    dependencies = {
      'nvim-lua/plenary.nvim',
      'stevearc/dressing.nvim', -- optional for vim.ui.select
    },
    config = function()
      require('flutter-tools').setup {
        vim.keymap.set('n', '<leader>F', ':Telescope flutter commands<CR>', { desc = '[F]lutter Commands', silent = true }),
      }
    end,
  },
}
