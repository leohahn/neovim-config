-- vim: foldmethod=marker
-- Helper functions{{{
function nnoremap(keybind, command)
  vim.api.nvim_set_keymap('n', keybind, command, { noremap = true, silent = true })
end
--}}}
-- Packages!{{{
local install_path = vim.fn.stdpath 'data' .. '/site/pack/packer/start/packer.nvim'

if vim.fn.empty(vim.fn.glob(install_path)) > 0 then
  vim.fn.execute('!git clone https://github.com/wbthomason/packer.nvim ' .. install_path)
end

vim.cmd [[
  runtime macros/matchit.vim
]]

vim.cmd [[
  augroup Packer
    autocmd!
    autocmd BufWritePost init.lua PackerCompile
  augroup end
]]

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager

  use 'tpope/vim-surround'

  use 'tpope/vim-fugitive' -- Git commands in nvim
  use 'tpope/vim-commentary' -- "gc" to comment visual regions/lines

  -- UI to select things (files, grep results, open buffers...)
  use { 'nvim-telescope/telescope.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Add git related info in the signs columns and popups
  use { 'lewis6991/gitsigns.nvim', requires = { 'nvim-lua/plenary.nvim' } }

  -- Highlight, edit, and navigate code using a fast incremental parsing library
  use 'nvim-treesitter/nvim-treesitter'
  -- Additional textobjects for treesitter
  use 'nvim-treesitter/nvim-treesitter-textobjects'
  use 'sheerun/vim-polyglot' -- Add multiple languages support

  use 'andreypopp/vim-colors-plain' -- Boring colorscheme

  use 'editorconfig/editorconfig-vim' -- Support for EditorConfig

  use 'qpkorr/vim-bufkill'

  use {
    'kyazdani42/nvim-web-devicons',
    config = function() require'nvim-web-devicons'.setup {} end
  }

  use 'davidosomething/vim-colors-meh'

  -- LSP setup
  use 'neovim/nvim-lspconfig'
  use 'hrsh7th/cmp-nvim-lsp'
  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'
  use 'hrsh7th/nvim-cmp'

  use 'L3MON4D3/LuaSnip'
  use 'saadparwaiz1/cmp_luasnip'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- To enable more of the features of rust-analyzer, such as inlay hints and more!
  use 'simrat39/rust-tools.nvim'

  -- Helper plugin to more easily manage terminals
  use {
    'akinsho/toggleterm.nvim',
    requires = {{'nvim-telescope/telescope.nvim'}},
  }

  use 'nvim-telescope/telescope-fzy-native.nvim'

  -- Color scheme used in the GIFs!
  -- use 'arcticicestudio/nord-vim'

  -- Project management inside vim
  use 'ahmedkhalf/project.nvim'

  use {
    'kyazdani42/nvim-tree.lua',
    requires = {
      'kyazdani42/nvim-web-devicons', -- optional, for file icon
    },
    config = function() require'nvim-tree'.setup {} end
  }

  -- use 'darrikonn/vim-gofmt'
  use 'fatih/vim-go'

  use 'jiangmiao/auto-pairs'

  -- Colorschemes
  use 'pbrisbin/vim-colors-off'
  use {
    "mcchrish/zenbones.nvim",
    requires = "rktjmp/lush.nvim"
  }
  use 'robertmeta/nofrils'
  use 'owickstrom/vim-colors-paramount'
  use 'hardselius/warlock'
  use 'mcchrish/zenbones.nvim'
  use 'andreasvc/vim-256noir'
  use 'LuRsT/austere.vim'
  use 'igungor/schellar'
  use 'olivertaylor/vacme'
end)
--}}}
-- Global defaults setup{{{
-- I'm used to text editors opening side panels to the right of/below the current one
vim.o.splitright = true
vim.o.splitbelow = true

vim.cmd [[ set grepprg=rg\ --vimgrep ]]

vim.cmd [[ set nrformats= ]]

vim.cmd [[
  set tabstop=4
  set expandtab
  set shiftwidth=4
]]

-- Set hidden buffers
vim.o.hidden = true

--Set highlight on search
vim.o.hlsearch = true

-- Highlight all instances of a word
vim.cmd [[
    nnoremap <F8> :let @/='\<<C-R>=expand("<cword>")<CR>\>'<CR>:set hls<CR>
]]

--Make line numbers default
vim.wo.number = true

--Enable mouse mode
vim.o.mouse = 'a'

--Enable break indent
vim.o.breakindent = true

--Save undo history
vim.opt.undofile = true

--Case insensitive searching UNLESS /C or capital in search
vim.o.ignorecase = true
vim.o.smartcase = true

--Decrease update time
vim.o.updatetime = 250
vim.wo.signcolumn = 'yes'

-- Enable tree list style by default
vim.g.netrw_liststyle = 3

-- Show tabs
vim.cmd [[
  set list
  set listchars=tab:>-
]]

--Set colorscheme (order is important here)
vim.o.termguicolors = true
-- vim.cmd [[colorscheme vacme]]
vim.cmd [[colorscheme off]]
-- vim.cmd [[highlight LineNr ctermfg=red]]

vim.cmd [[
  highlight LineNr term=bold cterm=NONE ctermfg=DarkGrey ctermbg=NONE gui=bold guifg=#55767d guibg=NONE
]]

--Remap space as leader key
vim.api.nvim_set_keymap('', '<Space>', '<Nop>', { noremap = true, silent = true })
vim.g.mapleader = ' '
vim.g.maplocalleader = ' '

--Remap for dealing with word wrap
vim.api.nvim_set_keymap('n', 'k', "v:count == 0 ? 'gk' : 'k'", { noremap = true, expr = true, silent = true })
vim.api.nvim_set_keymap('n', 'j', "v:count == 0 ? 'gj' : 'j'", { noremap = true, expr = true, silent = true })

-- Make it easier to move between splits
vim.api.nvim_set_keymap('n', '<C-h>', [[<C-W>h]], {})
vim.api.nvim_set_keymap('n', '<C-j>', [[<C-W>j]], {})
vim.api.nvim_set_keymap('n', '<C-k>', [[<C-W>k]], {})
vim.api.nvim_set_keymap('n', '<C-l>', [[<C-W>l]], {})

-- Handling buffers more easily
-- vim.api.nvim_set_keymap('n', '<leader>fs', [[:w<CR>]], {})
-- vim.api.nvim_set_keymap('n', '<leader>bd', [[:bd<CR>]], {})

-- Stolen from https://github.com/neovim/neovim/issues/6289
vim.api.nvim_set_keymap('n', '<BS>', '<Cmd>nohlsearch<CR><BS>', {noremap = true})

--Remove annoying command
vim.api.nvim_set_keymap('', 'Q', '', {}) -- Begone, foul beast. I can invoke your wrath with gQ anyway.

-- Highlight on yank and restore cursor position
vim.cmd [[
  augroup hl_yank
    autocmd!
    autocmd TextYankPost * lua require('vim.highlight').on_yank()
  augroup END

  augroup restore_curpos
    autocmd!
    autocmd BufReadPost * if line("'\"") >= 1 && line("'\"") <= line("$") && &ft !~# 'commit' | exe "normal! g`\"" | endif
  augroup END
]]

--Map blankline
vim.g.indent_blankline_char = '┊'
vim.g.indent_blankline_filetype_exclude = { 'help', 'packer' }
vim.g.indent_blankline_buftype_exclude = { 'terminal', 'nofile' }
vim.g.indent_blankline_show_trailing_blankline_indent = false

-- Make it easier to move in and out of a terminal
function _G.set_terminal_keymaps()
  local opts = {noremap = true}
  vim.api.nvim_buf_set_keymap(0, 't', '<esc>', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', 'jk', [[<C-\><C-n>]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-h>', [[<C-\><C-n><C-W>h]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-j>', [[<C-\><C-n><C-W>j]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-k>', [[<C-\><C-n><C-W>k]], opts)
  vim.api.nvim_buf_set_keymap(0, 't', '<C-l>', [[<C-\><C-n><C-W>l]], opts)
end

-- if you only want these mappings for toggle term use term://*toggleterm#* instead
vim.cmd('autocmd! TermOpen term://* lua set_terminal_keymaps()')

-- Make command autocompletion similar to the ones in shell.
vim.cmd [[
  set wildmenu
  set wildmode=full
]]

-- Set larger history for command line mode
vim.cmd [[
  set history=500
]]

-- Allow not using cursor keys when scrolling through history in command mode.
vim.cmd [[
  cnoremap <C-p> <Up>
  cnoremap <C-n> <Down>
]]
--}}}
-- Basic Keybindings{{{
nnoremap("<leader>bd", ":BD<CR>") -- easily delete buffers
nnoremap("<leader>fs", ":w<CR>") -- easily write buffers
nnoremap("<leader><TAB>", ":e #<CR>") -- switch to previous buffer
-- Dealing with splits
nnoremap("<leader>wv", ":vsplit<CR>")
nnoremap("<leader>ws", ":split<CR>")
nnoremap("<leader>wd", "<C-w>c")
-- Moving between splits
nnoremap("<leader>wh", "<C-w>h")
nnoremap("<leader>wl", "<C-w>l")
nnoremap("<leader>wk", "<C-w>k")
nnoremap("<leader>wj", "<C-w>j")
-- Open nvim tree
nnoremap("<leader>ft", ":NvimTreeToggle<CR>")
---}}}
-- Gitsigns{{{
require('gitsigns').setup {
  signs = {
    add = { hl = 'GitGutterAdd', text = '+' },
    change = { hl = 'GitGutterChange', text = '~' },
    delete = { hl = 'GitGutterDelete', text = '_' },
    topdelete = { hl = 'GitGutterDelete', text = '‾' },
    changedelete = { hl = 'GitGutterChange', text = '~' },
  },
}
--}}}
-- Telescope{{{
require('telescope').setup {
  defaults = {
    file_ignore_patterns = {
      "node_modules",
      "vendor",
      "mysql-data",
      "mysql-data-bk",
    },
    mappings = {
      i = {
        ['<C-u>'] = false,
        ['<C-d>'] = false,
      },
    },
  },
}
require('telescope').load_extension('fzy_native')
--Add leader shortcuts
nnoremap('<leader>ff', [[<cmd>lua require('telescope.builtin').find_files()<CR>]])
nnoremap('<leader>fb', [[<cmd>lua require('telescope.builtin').buffers()<CR>]])
nnoremap('<leader>fh', [[<cmd>lua require('telescope.builtin').help_tags()<CR>]])
nnoremap('<leader>fd', [[<cmd>lua require('telescope.builtin').grep_string()<CR>]])
nnoremap('<leader>fp', [[<cmd>lua require('telescope.builtin').live_grep()<CR>]])
nnoremap('<leader>?', [[<cmd>lua require('telescope.builtin').oldfiles()<CR>]])
--}}}
-- Treesitter configuration{{{
-- Parsers must be installed manually via :TSInstall
require('nvim-treesitter.configs').setup {
  highlight = {
    enable = true, -- false will disable the whole extension
  },
  incremental_selection = {
    enable = true,
    keymaps = {
      init_selection = 'gnn',
      node_incremental = 'grn',
      scope_incremental = 'grc',
      node_decremental = 'grm',
    },
  },
  indent = {
    enable = true,
  },
  textobjects = {
    select = {
      enable = true,
      lookahead = true, -- Automatically jump forward to textobj, similar to targets.vim
      keymaps = {
        -- You can use the capture groups defined in textobjects.scm
        ['af'] = '@function.outer',
        ['if'] = '@function.inner',
        ['ac'] = '@class.outer',
        ['ic'] = '@class.inner',
      },
    },
    move = {
      enable = true,
      set_jumps = true, -- whether to set jumps in the jumplist
      goto_next_start = {
        [']m'] = '@function.outer',
        [']]'] = '@class.outer',
      },
      goto_next_end = {
        [']M'] = '@function.outer',
        [']['] = '@class.outer',
      },
      goto_previous_start = {
        ['[m'] = '@function.outer',
        ['[['] = '@class.outer',
      },
      goto_previous_end = {
        ['[M'] = '@function.outer',
        ['[]'] = '@class.outer',
      },
    },
  },
}
--}}}
-- LSP settings{{{
local on_attach = function(_, bufnr)
  vim.api.nvim_buf_set_option(bufnr, 'omnifunc', 'v:lua.vim.lsp.omnifunc')

  local opts = { noremap = true, silent = true }
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gD', '<cmd>lua vim.lsp.buf.declaration()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gd', '<cmd>lua vim.lsp.buf.definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'K', '<cmd>lua vim.lsp.buf.hover()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gi', '<cmd>lua vim.lsp.buf.implementation()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<C-k>', '<cmd>lua vim.lsp.buf.signature_help()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wa', '<cmd>lua vim.lsp.buf.add_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>wr', '<cmd>lua vim.lsp.buf.remove_workspace_folder()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>D', '<cmd>lua vim.lsp.buf.type_definition()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>rn', '<cmd>lua vim.lsp.buf.rename()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', 'gr', '<cmd>lua vim.lsp.buf.references()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>ca', '<cmd>lua vim.lsp.buf.code_action()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>e', '<cmd>lua vim.diagnostic.open_float()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '[d', '<cmd>lua vim.diagnostic.goto_prev()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', ']d', '<cmd>lua vim.diagnostic.goto_next()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>q', '<cmd>lua vim.diagnostic.setloclist()<CR>', opts)
  vim.api.nvim_buf_set_keymap(bufnr, 'n', '<leader>so', [[<cmd>lua require('telescope.builtin').lsp_document_symbols()<CR>]], opts)
  vim.cmd [[ command! Format execute 'lua vim.lsp.buf.formatting()' ]]
end

-- Set completeopt to have a better completion experience
vim.o.completeopt = 'menu,menuone,noselect'

-- nvim-cmp supports additional completion capabilities
local capabilities = require('cmp_nvim_lsp').update_capabilities(vim.lsp.protocol.make_client_capabilities())

-- Enable the following language servers
require('lspconfig').rust_analyzer.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
require('lspconfig').pyright.setup {
  on_attach = on_attach,
  capabilities = capabilities
}
local pid = vim.fn.getpid()
local omnisharp_bin = "/Users/leonardohahn/omnisharp-osx-x64-net6.0/OmniSharp"
require('lspconfig').omnisharp.setup {
  cmd = {omnisharp_bin, "--languageserver", "--hostPID", tostring(pid)},
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig').tsserver.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig').gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
require('lspconfig').zls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}


-- nvim-cmp setup
local luasnip = require 'luasnip'
local cmp = require 'cmp'
cmp.setup {
  snippet = {
    expand = function(args)
      luasnip.lsp_expand(args.body)
    end,
  },
  mapping = {
    ['<C-p>'] = cmp.mapping.select_prev_item(),
    ['<C-n>'] = cmp.mapping.select_next_item(),
    ['<C-d>'] = cmp.mapping.scroll_docs(-4),
    ['<C-f>'] = cmp.mapping.scroll_docs(4),
    ['<C-Space>'] = cmp.mapping(cmp.mapping.complete(), { 'i', 'c' }),
    ['<C-e>'] = cmp.mapping.close(),
    ['<CR>'] = cmp.mapping.confirm {
      behavior = cmp.ConfirmBehavior.Replace,
      select = true,
    },
    ['<C-y>'] = cmp.config.disable,
    ['<Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_next_item()
      elseif luasnip.expand_or_jumpable() then
        luasnip.expand_or_jump()
      else
        fallback()
      end
    end,
    ['<S-Tab>'] = function(fallback)
      if cmp.visible() then
        cmp.select_prev_item()
      elseif luasnip.jumpable(-1) then
        luasnip.jump(-1)
      else
        fallback()
      end
    end,
  },
  sources = cmp.config.sources({
    { name = 'nvim_lsp' },
    { name = 'luasnip' }, -- For luasnip users.
  }, {
    { name = 'buffer' },
  })
}

-- Use buffer source for `/` (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline('/', {
--   sources = {
--     { name = 'buffer' }
--   }
-- })

 -- -- Use cmdline & path source for ':' (if you enabled `native_menu`, this won't work anymore).
-- cmp.setup.cmdline(':', {
 --  sources = cmp.config.sources({
 --    { name = 'path' }
 --  }, {
 --    { name = 'cmdline' }
 --  })
-- })

--}}}
-- ToggleTerm{{{
require("toggleterm").setup{
  -- size can be a number or function which is passed the current terminal
  size = function(term)
    if term.direction == "horizontal" then
      return 15
    elseif term.direction == "vertical" then
      return vim.o.columns * 0.4
    end
  end,
  open_mapping = [[<c-\>]],
}
--}}}
-- Project.nvim{{{
require("project_nvim").setup {
  silent_chdir = false,
}
require('telescope').load_extension('projects')
--}}}
-- Setting terminal colors{{{
vim.g.terminal_color_0  = '#2e3436'
vim.g.terminal_color_1  = '#cc0000'
vim.g.terminal_color_2  = '#4e9a06'
vim.g.terminal_color_3  = '#c4a000'
vim.g.terminal_color_4  = '#3465a4'
vim.g.terminal_color_5  = '#75507b'
vim.g.terminal_color_6  = '#0b939b'
vim.g.terminal_color_7  = '#d3d7cf'
vim.g.terminal_color_8  = '#555753'
vim.g.terminal_color_9  = '#ef2929'
vim.g.terminal_color_10 = '#8ae234'
vim.g.terminal_color_11 = '#fce94f'
vim.g.terminal_color_12 = '#729fcf'
vim.g.terminal_color_13 = '#ad7fa8'
vim.g.terminal_color_14 = '#00f5e9'
vim.g.terminal_color_15 = '#eeeeec'
--}}}
-- Setup gui{{{
vim.cmd [[
  set guifont=JetBrains\ Mono:h12
  let neovide_remember_window_size = v:true
  let g:neovide_cursor_animation_length=0.01
  let g:neovide_cursor_trail_length=0.4
]]
--}}}
-- Setup rust-tools{{{
require('rust-tools').setup({
  tools = { -- rust-tools options
    autoSetHints = true,
    hover_with_actions = true,
    inlay_hints = {
      show_parameter_hints = false,
      parameter_hints_prefix = "",
      other_hints_prefix = "",
    },
  },

  -- all the opts to send to nvim-lspconfig
  -- these override the defaults set by rust-tools.nvim
  -- see https://github.com/neovim/nvim-lspconfig/blob/master/CONFIG.md#rust_analyzer
  server = {
    -- on_attach is a callback called when the language server attachs to the buffer
    -- on_attach = on_attach,
    settings = {
      -- to enable rust-analyzer settings visit:
      -- https://github.com/rust-analyzer/rust-analyzer/blob/master/docs/user/generated_config.adoc
      ["rust-analyzer"] = {
        -- enable clippy on save
        -- checkOnSave = {
        --   command = "clippy"
        -- },
      }
    }
  },
})
--}}}
-- Setup Lualine{{{
require('lualine').setup()
--}}}
-- Setup GUI fonts{{{
vim.o.guifont = "Victor Mono Medium:h13"
--}}}
--Setup Go code{{{
vim.g.go_fmt_autosave = 1 -- Format go code when saving.
--}}}
