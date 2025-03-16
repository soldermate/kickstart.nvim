return {
  'Vigemus/iron.nvim',
  config = function(plugins, opts)
    local iron = require 'iron.core'
    local view = require 'iron.view'

    iron.setup {
      config = {
        -- Whether a repl should be discarded or not
        scratch_repl = true,
        -- Your repl definitions come here
        repl_definition = {
          python = {
            -- Can be a table or a function that
            -- returns a table (see below)
            command = { 'python' },
            format = require('iron.fts.common').bracketed_paste,
          },
        },
        -- How the repl window will be displayed
        -- See below for more information
        repl_open_cmd = view.right(100),
      },
      -- Iron doesn't set keymaps by default anymore.
      -- You can set them here or manually add keymaps to the functions in iron.core
      keymaps = {
        visual_send = '<space>rc',
        send_file = '<space>rf',
        send_line = '<space>rl',
        send_paragraph = '<leader>rp',
        cr = '<leader>r<enter>',
        interrupt = '<leader>ri',
        exit = '<space>rq',
        clear = '<space>rx',
      },
      -- If the highlight is on, you can change how it looks
      -- For the available options, check nvim_set_hl
      highlight = {
        italic = true,
      },
      ignore_blank_lines = true, -- ignore blank lines when sending visual select lines
    }

    -- iron also has a list of commands, see :h iron-commands for all available commands
    vim.keymap.set('n', '<space>ro', '<cmd>IronRepl<cr>')
    vim.keymap.set('n', '<space>rr', '<cmd>IronRestart<cr>')
    vim.keymap.set('n', '<space>rF', '<cmd>IronFocus<cr>')
    vim.keymap.set('n', '<space>rh', '<cmd>IronHide<cr>')

    -- Add keymap descriptions to which-key
    local wk = require 'which-key'

    wk.add {
      -- functions without commands exposed
      { '<leader>r', group = '[R]epl' },
      { '<leader>rv', desc = '[R]epl Visual' },
      { '<leader>rf', desc = '[R]epl File' },
      { '<leader>rl', desc = '[R]epl Line' },
      { '<leader>rp', desc = '[R]epl Paragraph' },
      { '<leader>r<enter>', desc = '[R]epl Carriage Return' },
      { '<leader>ri', desc = '[R]epl Interrupt' },
      { '<leader>rq', desc = '[R]epl Quit' },
      { '<leader>rx', desc = '[R]epl Clear' },
      -- functions with commands exposed
      { '<leader>ro', desc = '[R]epl Open' },
      { '<leader>rr', desc = '[R]epl Restart' },
      { '<leader>rF', desc = '[R]epl Focus' },
      { '<leader>rh', desc = '[R]epl Hide' },
    }
  end,
}
