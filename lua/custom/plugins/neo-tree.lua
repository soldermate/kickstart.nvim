return {
  'nvim-neo-tree/neo-tree.nvim',
  branch = 'v3.x',
  dependencies = {
    'nvim-lua/plenary.nvim',
    'nvim-tree/nvim-web-devicons', -- Required for file icons
    'MunifTanjim/nui.nvim',
  },
  cmd = 'Neotree',
  -- Only call the setup function
  config = function()
    require('neo-tree').setup {
      -- Your Neo-tree settings here
      window = {
        -- For example, if you had this, make sure it's false or removed:
        open_on_startup = false,
      },
      filesystem = {
        -- This is where you might configure the default root
        -- For example, if you set it to the current directory, it will open there
        -- You usually want this, but it doesn't *force* opening.
        -- path = vim.fn.getcwd(),
      },
      -- ... other configurations
    }
  end,
}
