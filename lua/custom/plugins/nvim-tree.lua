return {
  'nvim-tree/nvim-tree.lua',
  dependencies = {
    'nvim-tree/nvim-web-devicons', -- Required for file and folder icons
    'nvim-lua/plenary.nvim', -- General utility library, common dependency
  },
  -- Lazy load NvimTree when the 'NvimTreeToggle' command is used,
  -- or when the associated keybinding is pressed.
  cmd = 'NvimTreeToggle',
  keys = {
    -- Map <leader>e to toggle NvimTree
    { '<leader>e', '<cmd>NvimTreeToggle<cr>', desc = 'Toggle NvimTree' },
  },
  config = function()
    -- Disable Netrw (Neovim's default file explorer) to avoid conflicts
    -- This should ideally be at the top of your init.lua or a core config file,
    -- but included here for completeness of the NvimTree setup.
    vim.g.loaded_netrw = 0
    vim.g.loaded_netrwPlugin = 0

    require('nvim-tree').setup {
      -- Custom keymappings for splits
      on_attach = function(bufnr)
        local api = require 'nvim-tree.api'

        -- Default mappings
        api.config.mappings.default_on_attach(bufnr)

        -- Custom keymappings for splits
        vim.keymap.set('n', 'v', api.node.open.horizontal, { buffer = bufnr, desc = 'Open: Horizontal Split' })
        vim.keymap.set('n', 's', api.node.open.vertical, { buffer = bufnr, desc = 'Open: Vertical Split' })
      end,
      -- Configure the NvimTree window itself
      view = {
        width = 30, -- Set a fixed width for the tree sidebar
        relativenumber = false, -- Show relative line numbers within the tree
        side = 'left', -- Position the tree on the left (default)
      },
      -- Configure how files are opened from the tree
      actions = {
        open_file = {
          quit_on_open = true, -- Close NvimTree when a file is opened from it
        },
      },
      -- Enable Git integration for status markers
      git = {
        enable = true,
        ignore = false, -- Set to true to hide git-ignored files
      },
      -- Show LSP diagnostics directly in the tree (requires LSP setup elsewhere)
      diagnostics = {
        enable = true,
        icons = {
          hint = '💡',
          info = 'ℹ️',
          warning = '⚠️',
          error = '⛔',
        },
      },
      -- Make the tree follow the currently focused file in your editor
      update_focused_file = {
        enable = true,
        update_root = true, -- Change the tree root to the focused file's directory
        ignore_list = {}, -- Files to ignore when updating focus (e.g., {"*.log"})
      },
      -- Configure rendering details
      renderer = {
        indent_width = 2,
        highlight_git = true, -- Highlight file names based on their Git status
        icons = {
          show = {
            git = true,
            folder = true,
            file = true,
            diagnostics = true,
          },
          git_placement = 'before', -- Place Git icons before file names
          diagnostics_placement = 'after', -- Place diagnostics icons after file names
          padding = ' ',
        },
      },
      -- Filters for displaying files/folders
      filters = {
        dotfiles = false, -- Set to true to show hidden files (starting with '.')
        exclude = {}, -- Table of patterns to exclude (e.g., {".git", ".DS_Store"})
      },
      -- Optional: Configure the "buffers" source for displaying open buffers in the tree
      -- sources = { "filesystem", "buffers", "git_status" },
      -- Buffers specific configuration
      -- buffers = {
      --   follow_current_file = {
      --     enabled = true,
      --     leave_dirs_open = false,
      --   },
      -- },
      -- Default component configs, useful for tweaking specific elements
    }

    -- Optional: Auto-close NvimTree when no file buffers are open in the current tab
    -- This is a common preference, but can sometimes be finicky.
    vim.api.nvim_create_autocmd('QuitPre', {
      callback = function()
        -- Get all windows in the current tabpage
        local windows = vim.api.nvim_tabpage_list_wins(0)
        -- Check if the only remaining window is NvimTree
        if #windows == 1 and vim.api.nvim_win_get_buf(windows[1]) == require('nvim-tree.api').tree.get_bufnr() then
          vim.cmd 'NvimTreeClose'
        end
      end,
    })
  end,
}
