local ensure_packer = function()
  local fn = vim.fn
  local install_path = fn.stdpath('data')..'/site/pack/packer/start/packer.nvim'
  if fn.empty(fn.glob(install_path)) > 0 then
    fn.system({'git', 'clone', '--depth', '1', 'https://github.com/wbthomason/packer.nvim', install_path})
    vim.cmd [[packadd packer.nvim]]
    return true
  end
  return false
end

local packer_bootstrap = ensure_packer()


-- Initialize packer
require('packer').init({
  compile_path = vim.fn.stdpath('data')..'/site/plugin/packer_compiled.lua',
 -- display = {
 --   open_fn = function()
 --     return require('packer.util').float({ border = 'solid' })
 --   end,
 -- },
})

local use = require('packer').use

 use 'wbthomason/packer.nvim'

 -- Commenting support
 use('tpope/vim-commentary')
-- Fuzzy finder
use({
  'nvim-telescope/telescope.nvim',
  requires = {
    { 'nvim-lua/plenary.nvim' },
    { 'kyazdani42/nvim-web-devicons' },
    { 'nvim-telescope/telescope-fzf-native.nvim', run = 'make' },
    { 'nvim-telescope/telescope-live-grep-args.nvim' },
  },
  config = function()
 --   require('telescope')
  require('ash.plugins.telescope')
  end,
})

-- File tree sidebar
use({
  'kyazdani42/nvim-tree.lua',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('ash.plugins.nvim-tree')
--    require('nvim-tree').setup()
  end,
})

-- Great Status Line
use({
  'nvim-lualine/lualine.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  config = function()
    require('ash.plugins.lualine')
  end,
})

-- This one is really cool: Display buffers as tabs 
use({
  'akinsho/bufferline.nvim',
  requires = 'kyazdani42/nvim-web-devicons',
  after = 'onedark.nvim',
  config = function()
  --  require('bufferline').setup()
   require('ash.plugins.bufferline')
  end,
})

-- Indentation plugin
use('lukas-reineke/indent-blankline.nvim')

-- Dashboard interface
use({
  'glepnir/dashboard-nvim',
  config = function()
    require('ash.plugins.dashboard')
  end,
})

-- Git integration.
use({
  'lewis6991/gitsigns.nvim',
  config = function()
    require('gitsigns').setup({current_line_blame = true })
    vim.keymap.set('n', ']h', ':Gitsigns next_hunk<CR>')
    vim.keymap.set('n', '[h', ':Gitsigns prev_hunk<CR>')
    vim.keymap.set('n', 'gs', ':Gitsigns stage_hunk<CR>')
    vim.keymap.set('n', 'gS', ':Gitsigns undo_stage_hunk<CR>')
    vim.keymap.set('n', 'gp', ':Gitsigns preview_hunk<CR>')
    vim.keymap.set('n', 'gb', ':Gitsigns blame_line<CR>')
  end,
})

-- Git commands.
use({
  'tpope/vim-fugitive',
  requires = 'tpope/vim-rhubarb',
  cmd = 'G',
})

--terminal plugin
use({
  'voldikss/vim-floaterm',
  config = function()
    require('ash.plugins.floaterm')
  end,
})

-- Improved syntax highlighting
use({
  'nvim-treesitter/nvim-treesitter',
  run = ':TSUpdate',
  requires = {
   'nvim-treesitter/playground',
    'nvim-treesitter/nvim-treesitter-textobjects',
    'JoosepAlviste/nvim-ts-context-commentstring',
  },
  config = function()
    require('ash.plugins.treesitter')
  end,
})
vim.g.skip_ts_context_commentstring_module = true

-- Language Server Protocol.
use({
  'neovim/nvim-lspconfig',
  requires = {
    'williamboman/mason.nvim',
    'williamboman/mason-lspconfig.nvim',
    'b0o/schemastore.nvim',
     'jose-elias-alvarez/null-ls.nvim',
    'jayp0521/mason-null-ls.nvim',
  },
  config = function()
    require('ash.plugins.lspconfig')
  end,
})


-- Autocompletion
use({
  'hrsh7th/nvim-cmp',
  requires = {
    'hrsh7th/cmp-nvim-lsp',
    'hrsh7th/cmp-nvim-lsp-signature-help',
    'hrsh7th/cmp-buffer',
    'hrsh7th/cmp-path',
    'L3MON4D3/LuaSnip',
    'saadparwaiz1/cmp_luasnip',
    'onsails/lspkind-nvim',
  },
  config = function()
    require('ash.plugins.cmp')
  end,
})


-- one-dark theme
 use({
  'jessarcher/onedark.nvim',
  config = function()
    vim.cmd('colorscheme onedark')

    -- Hide the characters in FloatBorder
    vim.api.nvim_set_hl(0, 'FloatBorder', {
      fg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
      bg = vim.api.nvim_get_hl_by_name('NormalFloat', true).background,
    })

  -- This one is really cool: Display buffers as tabs

    -- Make the StatusLineNonText background the same as StatusLine
    vim.api.nvim_set_hl(0, 'StatusLineNonText', {
      fg = vim.api.nvim_get_hl_by_name('NonText', true).foreground,
      bg = vim.api.nvim_get_hl_by_name('StatusLine', true).background,
    })

    -- Hide the characters in CursorLineBg
    vim.api.nvim_set_hl(0, 'CursorLineBg', {
      fg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
      bg = vim.api.nvim_get_hl_by_name('CursorLine', true).background,
    })

    vim.api.nvim_set_hl(0, 'NvimTreeIndentMarker', { fg = '#30323E' })
    vim.api.nvim_set_hl(0, 'IndentBlanklineChar', { fg = '#2F313C' })
  end,
})



-- Add, change, and delete surrounding text.
use('leafOfTree/vim-vue-plugin')

-- Add, change, and delete surrounding text.
use('tpope/vim-surround')

-- Useful commands like :Rename and :SudoWrite.
use('tpope/vim-eunuch')

-- Pairs of handy bracket mappings, like [b and ]b.
use('tpope/vim-unimpaired')

-- Indent autodetection with editorconfig support.
use('tpope/vim-sleuth')

-- Allow plugins to enable repeating of commands.
use('tpope/vim-repeat')

-- Add more languages.
use('sheerun/vim-polyglot')

-- Navigate seamlessly between Vim windows and Tmux panes.
use('christoomey/vim-tmux-navigator')

-- Jump to the last location when opening a file.
use('farmergreg/vim-lastplace')

-- Enable * searching with visually selected text.
use('nelstrom/vim-visual-star-search')

-- Automatically create parent dirs when saving.
use('jessarcher/vim-heritage')

-- Text objects for HTML attributes.
use({
  'whatyouhide/vim-textobj-xmlattr',
  requires = 'kana/vim-textobj-user',
})

-- Automatically set the working directory to the project root.
use({
  'airblade/vim-rooter',
  setup = function()
    -- Instead of this running every time we open a file, we'll just run it once when Vim starts.
    vim.g.rooter_manual_only = 1
  end,
  config = function()
    vim.cmd('Rooter')
  end,
})

-- Automatically add closing brackets, quotes, etc.
use({
  'windwp/nvim-autopairs',
  config = function()
    require('nvim-autopairs').setup()
  end,
})

-- Add smooth scrolling to avoid jarring jumps
use({
  'karb94/neoscroll.nvim',
  config = function()
    require('neoscroll').setup()
  end,
})

-- All closing buffers without closing the split window.
use({
  'famiu/bufdelete.nvim',
  config = function()
    vim.keymap.set('n', '<Leader>q', ':Bdelete<CR>')
  end,
})

-- Split arrays and methods onto multiple lines, or join them back up.
use({
  'AndrewRadev/splitjoin.vim',
  config = function()
    vim.g.splitjoin_html_attributes_bracket_on_new_line = 1
    vim.g.splitjoin_trailing_comma = 1
    vim.g.splitjoin_php_method_chain_full = 1
  end,
})

-- Automatically fix indentation when pasting code.
use({
  'sickill/vim-pasta',
  config = function()
    vim.g.pasta_disabled_filetypes = { 'fugitive' }
  end,
})



use('prettier/vim-prettier')
use('jose-elias-alvarez/null-ls.nvim')
use('MunifTanjim/prettier.nvim')

--  Catppuccin theme
use { "catppuccin/nvim", as = "catppuccin" }
require('catppuccin').setup({
        flavour = "latte", -- latte, frappe, macchiato, mocha
  })
-- vim.cmd.colorscheme ""


-- Blade syntax highlighter ""
use('jwalton512/vim-blade')

use ('adalessa/laravel.nvim')

use({
  'phpactor/phpactor',
  run = 'composer install --no-dev --optimize-autoloader ',

  config = function()
    vim.keymap.set("n" , "<leader>m" , "PhpactorContextMenu<CR>" )
    vim.keymap.set("n" , "<leader>j" , "PhpactorContextMenu<CR>" )
    vim.keymap.set("n" , "m" , "PhpactorContextMenu<CR>" )
  end,
})

use({
    'yaegassy/coc-blade',
    run = 'yarn install --frozen-lockfile'
  })

use({
    'yaegassy/coc-laravel',
    run = 'yarn install --frozen-lockfile'
  })
-- Go To Blade
use({
    'ccaglak/larago.nvim',
    requires = "nvim-lua/plenary.nvim",
  config = function()
  vim.keymap.set("n", "<leader>gg", "<cmd>GoBlade<cr>")
  end,
})

use({
    '/home/ash/sites/views-highlighter'
  });
use {
  'VonHeikemen/lsp-zero.nvim',
  branch = 'v3.x',
  requires = {
    --- Uncomment the two plugins below if you want to manage the language servers from neovim
    --- and read this: https://github.com/VonHeikemen/lsp-zero.nvim/blob/v3.x/doc/md/guides/integrate-with-mason-nvim.md
    -- {'williamboman/mason.nvim'},
    -- {'williamboman/mason-lspconfig.nvim'},

    -- LSP Support
    {'neovim/nvim-lspconfig'},
    -- Autocompletion
    {'hrsh7th/nvim-cmp'},
    {'hrsh7th/cmp-nvim-lsp'},
    {'L3MON4D3/LuaSnip'},
  }
}

--codeium code assistant (like copilot)
use {
    "Exafunction/codeium.nvim",
    requires = {
        "nvim-lua/plenary.nvim",
        "hrsh7th/nvim-cmp",
    },
    config = function()
        require("codeium").setup({
        })
    end
}


-- use ( {'phpactor/phpactor', {'for': 'php', 'tag': '*', 'do': 'composer install --no-dev -o'}})

-- ft: "php",
-- run :   "composer install --no-dev --optimize-autoloader ",
if packer_bootstrap then

  -- Automatically set up your configuration after cloning packer.nvim
  -- Put this at the end after all plugins
  if packer_bootstrap then
    require('packer').sync()
  end
end

vim.cmd([[
  augroup packer_user_config
    autocmd!
    autocmd BufWritePost plugins.lua source <afile>
  augroup end
]])


