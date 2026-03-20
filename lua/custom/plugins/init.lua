-- You can add your own plugins here or in other files in this directory!
--  I promise not to create any merge conflicts in this directory :)
--
-- See the kickstart.nvim README for more information
return {
  {
    'nvim-tree/nvim-tree.lua',
    version = '*',
    lazy = false,
    keys = {
      { '<leader>e', '<cmd>NvimTreeToggle<CR>', desc = 'File [E]xplorer' },
    },
    dependencies = {
      'nvim-tree/nvim-web-devicons',
    },
    config = function()
      require('nvim-tree').setup {
        open_on_setup = false,
      }
      -- Auto-open nvim-tree when opening a directory
      vim.api.nvim_create_autocmd('VimEnter', {
        callback = function(data)
          local is_directory = vim.fn.isdirectory(data.file) == 1
          local no_name = data.file == '' and vim.bo[data.buf].buftype == ''
          if is_directory then
            vim.cmd.cd(data.file)
            require('nvim-tree.api').tree.open()
          elseif no_name then
            require('nvim-tree.api').tree.open()
          end
        end,
      })
    end,
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

  -- Floating cmdline, messages, and popups
  {
    'folke/noice.nvim',
    event = 'VeryLazy',
    dependencies = {
      'MunifTanjim/nui.nvim',
      'rcarriga/nvim-notify',
    },
    opts = {
      lsp = {
        override = {
          ['vim.lsp.util.convert_input_to_markdown_lines'] = true,
          ['vim.lsp.util.stylize_markdown'] = true,
          ['cmp.entry.get_documentation'] = true,
        },
      },
      presets = {
        bottom_search = true,
        command_palette = true,
        long_message_to_split = true,
        lsp_doc_border = true,
      },
    },
  },

  -- Animated notification popups
  {
    'rcarriga/nvim-notify',
    opts = {
      background_colour = '#000000',
      stages = 'fade_in_slide_out',
      timeout = 3000,
      max_height = function() return math.floor(vim.o.lines * 0.75) end,
      max_width = function() return math.floor(vim.o.columns * 0.75) end,
    },
  },

  -- Tab bar for open buffers
  {
    'akinsho/bufferline.nvim',
    version = '*',
    event = 'VeryLazy',
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    keys = {
      { '<S-h>', '<cmd>BufferLineCyclePrev<CR>', desc = 'Prev buffer' },
      { '<S-l>', '<cmd>BufferLineCycleNext<CR>', desc = 'Next buffer' },
      { '<leader>bp', '<cmd>BufferLineTogglePin<CR>', desc = '[B]uffer [P]in' },
      { '<leader>bx', '<cmd>BufferLineCloseOthers<CR>', desc = '[B]uffer Close Others' },
    },
    opts = {
      options = {
        diagnostics = 'nvim_lsp',
        offsets = {
          { filetype = 'NvimTree', text = 'File Explorer', highlight = 'Directory', separator = true },
        },
      },
    },
  },

  -- Smooth scrolling (page-level)
  {
    'karb94/neoscroll.nvim',
    event = 'VeryLazy',
    opts = {
      mappings = { '<C-u>', '<C-d>', '<C-b>', '<C-f>', 'zt', 'zz', 'zb' },
    },
  },


  -- Inline color previews for hex, rgb, etc.
  {
    'norcalli/nvim-colorizer.lua',
    event = 'VeryLazy',
    config = function()
      require('colorizer').setup({
        '*',
      }, {
        css = true,
        css_fn = true,
      })
    end,
  },

  -- Lazygit integration
  {
    'kdheepak/lazygit.nvim',
    cmd = 'LazyGit',
    keys = {
      { '<leader>gg', '<cmd>LazyGit<CR>', desc = 'Lazy[G]it' },
    },
    dependencies = { 'nvim-lua/plenary.nvim' },
  },

  -- Floating terminal
  {
    'akinsho/toggleterm.nvim',
    version = '*',
    keys = {
      { '<C-\\>', desc = 'Toggle terminal' },
      { '<leader>tf', '<cmd>ToggleTerm direction=float<CR>', desc = '[T]erminal [F]loat' },
      { '<leader>tv', '<cmd>ToggleTerm direction=vertical size=80<CR>', desc = '[T]erminal [V]ertical' },
      { '<leader>th', '<cmd>ToggleTerm direction=horizontal size=15<CR>', desc = '[T]erminal [H]orizontal' },
    },
    opts = {
      open_mapping = [[<C-\>]],
      direction = 'float',
      float_opts = {
        border = 'curved',
      },
    },
  },

  -- Pretty diagnostics list
  {
    'folke/trouble.nvim',
    cmd = 'Trouble',
    keys = {
      { '<leader>xx', '<cmd>Trouble diagnostics toggle<CR>', desc = 'Diagnostics (Trouble)' },
      { '<leader>xb', '<cmd>Trouble diagnostics toggle filter.buf=0<CR>', desc = 'Buffer Diagnostics (Trouble)' },
      { '<leader>xs', '<cmd>Trouble symbols toggle<CR>', desc = 'Symbols (Trouble)' },
    },
    opts = {},
  },

  -- Lualine statusline (replaces mini.statusline)
  {
    'nvim-lualine/lualine.nvim',
    lazy = false,
    dependencies = { 'nvim-tree/nvim-web-devicons' },
    opts = {
      options = {
        theme = 'auto',
        section_separators = { left = '', right = '' },
        component_separators = { left = '', right = '' },
      },
      sections = {
        lualine_a = { 'mode' },
        lualine_b = { 'branch', 'diff', 'diagnostics' },
        lualine_c = { { 'filename', path = 1 } },
        lualine_x = { 'filetype' },
        lualine_y = { 'progress' },
        lualine_z = { 'location' },
      },
    },
  },

  -- Rainbow delimiters
  {
    'HiPhish/rainbow-delimiters.nvim',
    event = 'VeryLazy',
  },

  -- Auto close/rename HTML tags
  {
    'windwp/nvim-ts-autotag',
    event = 'InsertEnter',
    opts = {},
  },
}
