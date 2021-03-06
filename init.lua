-- vim: foldmethod=marker
-- Helper functions{{{
function nnoremap(keybind, command)
  vim.api.nvim_set_keymap('n', keybind, command, { noremap = true, silent = true })
end

local hahn_group = vim.api.nvim_create_augroup("HahnConfig", { clear = true })
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

local has_words_before = function()
  local line, col = unpack(vim.api.nvim_win_get_cursor(0))
  return col ~= 0 and vim.api.nvim_buf_get_lines(0, line - 1, line, true)[1]:sub(col, col):match("%s") == nil
end

require('packer').startup(function(use)
  use 'wbthomason/packer.nvim' -- Package manager

  use 'tpope/vim-surround'
  use 'tpope/vim-repeat'

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
  use 'jose-elias-alvarez/null-ls.nvim'
  use 'jose-elias-alvarez/nvim-lsp-ts-utils'

  use {
    'nvim-lualine/lualine.nvim',
    requires = {'kyazdani42/nvim-web-devicons', opt = true}
  }

  -- To enable more of the features of rust-analyzer, such as inlay hints and more!
  use 'simrat39/rust-tools.nvim'

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

  use 'hrsh7th/cmp-buffer'
  use 'hrsh7th/cmp-path'
  use 'hrsh7th/cmp-cmdline'

  use {
    "hrsh7th/nvim-cmp",
    config = function()
      local cmp = require("cmp")

      cmp.setup {
        snippet = {
          expand = function(args)
            require("luasnip").lsp_expand(args.body) 
          end,
        },
        window = {
          completion = cmp.config.window.bordered(),
          documentation = cmp.config.window.bordered(),
        },
        sources = cmp.config.sources {
          { name = 'nvim_lsp' },
          { name = "luasnip" },
          { name = "path" },
        }, {
          { name = 'buffer' },
        },
        -- recommended configuration for <Tab> people:
        mapping = {
          ["<C-p>"] = cmp.mapping.select_prev_item(),
          ["<C-n>"] = cmp.mapping.select_next_item(),
          ["<C-d>"] = cmp.mapping.scroll_docs(-4),
          ["<C-f>"] = cmp.mapping.scroll_docs(4),
          ["<C-Space>"] = cmp.mapping.complete(),
          ["<C-e>"] = cmp.mapping.close(),
          ["<CR>"] = cmp.mapping.confirm {
            behavior = cmp.ConfirmBehavior.Replace,
            select = true,
          },
          -- ["<Tab>"] = cmp.mapping(function(fallback)
          --   if cmp.visible() then
          --     cmp.select_next_item()
          --   elseif require("luasnip").expand_or_jumpable() then
          --     require("luasnip").expand_or_jump()
          --   elseif has_words_before() then
          --     cmp.complete()
          --   else
          --     fallback()
          --   end
          -- end, { "i", "s" }),

          ['<Tab>'] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_next_item()
            else
              fallback()
            end
          end, { "i", "s" }),

          ["<S-Tab>"] = cmp.mapping(function(fallback)
            if cmp.visible() then
              cmp.select_prev_item()
            elseif require("luasnip").jumpable(-1) then
              require("luasnip").jump(-1)
            else
              fallback()
            end
          end, { "i", "s" }),
        }
      }
    end
  }

  use 'saadparwaiz1/cmp_luasnip'
  use {
    'L3MON4D3/LuaSnip',
    after = "nvim-cmp",
    config = function() require('config.snippets') end,
  }

  -- Colorschemes
  use 'pbrisbin/vim-colors-off'
  use {
    "mcchrish/zenbones.nvim",
    requires = "rktjmp/lush.nvim"
  }
  use 'robertmeta/nofrils'
  use 'owickstrom/vim-colors-paramount'
  use 'hardselius/warlock'
  use 'andreasvc/vim-256noir'
  use 'LuRsT/austere.vim'
  use 'igungor/schellar'
  use 'olivertaylor/vacme'

  use 'vimwiki/vimwiki'

  use 'nathangrigg/vim-beancount'

  use 'tpope/vim-abolish'

  use 'tpope/vim-rails'

  use "mattn/emmet-vim"

  use "vim-test/vim-test"

  use {
    "akinsho/bufferline.nvim",
    tag = "v2.*",
    requires = 'kyazdani42/nvim-web-devicons',
    config = function()
      vim.opt.termguicolors = true
      require("bufferline").setup{}
    end,
  }

  use {
    "glepnir/lspsaga.nvim",
    branch = "main",
    config = function()
        local saga = require("lspsaga")

        saga.init_lsp_saga({
          -- your configuration
        })
    end,
  }

  use "vlime/vlime"

  if packer_bootstrap then
    require('packer').sync()
  end
end)
--}}}
--Setup Snippets{{{
vim.cmd [[
]]
--}}}
-- Setup vimwiki{{{
vim.g.vimwiki_global_ext = 0
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
vim.g.indent_blankline_char = '???'
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
    topdelete = { hl = 'GitGutterDelete', text = '???' },
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
local buf_map = function(bufnr, mode, lhs, rhs, opts)
  vim.api.nvim_buf_set_keymap(bufnr, mode, lhs, rhs, opts or {
    silent = true,
  })
end

local on_attach = function(client, bufnr)
  vim.cmd("command! LspDef lua vim.lsp.buf.definition()")
  vim.cmd("command! LspFormatting lua vim.lsp.buf.formatting()")
  vim.cmd("command! LspCodeAction lua vim.lsp.buf.code_action()")
  vim.cmd("command! LspHover lua vim.lsp.buf.hover()")
  vim.cmd("command! LspRename lua vim.lsp.buf.rename()")
  vim.cmd("command! LspRefs lua vim.lsp.buf.references()")
  vim.cmd("command! LspTypeDef lua vim.lsp.buf.type_definition()")
  vim.cmd("command! LspImplementation lua vim.lsp.buf.implementation()")
  vim.cmd("command! LspDiagPrev lua vim.diagnostic.goto_prev()")
  vim.cmd("command! LspDiagNext lua vim.diagnostic.goto_next()")
  vim.cmd("command! LspDiagLine lua vim.diagnostic.open_float()")
  vim.cmd("command! LspSignatureHelp lua vim.lsp.buf.signature_help()")

  buf_map(bufnr, "n", "gd", ":LspDef<CR>")
  buf_map(bufnr, "n", "gr", ":LspRename<CR>")
  buf_map(bufnr, "n", "gy", ":LspTypeDef<CR>")
  buf_map(bufnr, "n", "K", ":LspHover<CR>")
  buf_map(bufnr, "n", "[a", ":LspDiagPrev<CR>")
  buf_map(bufnr, "n", "]a", ":LspDiagNext<CR>")
  buf_map(bufnr, "n", "ga", ":LspCodeAction<CR>")
  buf_map(bufnr, "n", "<Leader>a", ":LspDiagLine<CR>")
  buf_map(bufnr, "i", "<C-x><C-x>", "<cmd> LspSignatureHelp<CR>")
  if client.server_capabilities.document_formatting then
      vim.cmd("autocmd BufWritePre <buffer> lua vim.lsp.buf.formatting_sync()")
  end
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
-- require('lspconfig').tsserver.setup {
--   capabilities = capabilities,
--   on_attach = function(client, bufnr)
--     client.server_capabilities.document_formatting = false
--     client.server_capabilities.document_range_formatting = false
--     local ts_utils = require("nvim-lsp-ts-utils")
--     ts_utils.setup({})
--     ts_utils.setup_client(client)
--     buf_map(bufnr, "n", "gs", ":TSLspOrganize<CR>")
--     buf_map(bufnr, "n", "gi", ":TSLspRenameFile<CR>")
--     buf_map(bufnr, "n", "go", ":TSLspImportAll<CR>")

--     on_attach(client, bufnr)
--   end,
-- }
-- require('lspconfig').eslint.setup {
--   on_attach = on_attach,
--   capabilities = capabilities
-- }
require('lspconfig').gopls.setup {
  capabilities = capabilities,
  on_attach = on_attach,
}
-- require('lspconfig').solargraph.setup {
--   capabilities = capabilities,
--   on_attach = on_attach,
-- }

local null_ls = require("null-ls")
null_ls.setup({
    sources = {
        null_ls.builtins.diagnostics.eslint,
        -- null_ls.builtins.diagnostics.flake8.with({
        --     prefer_local = ".venv/bin",
        -- }),
        -- null_ls.builtins.code_actions.eslint,
        -- null_ls.builtins.formatting.prettier,
        -- null_ls.builtins.formatting.standardrb,
        null_ls.builtins.formatting.black.with({
            extra_args = {"--fast"},
            prefer_local = ".venv/bin",
        }),
        -- null_ls.builtins.formatting.isort.with({
        --     prefer_local = ".venv/bin",
        -- }),
    },
    on_attach = function(client, bufnr)
      if client.supports_method("textDocument/formatting") then
        vim.api.nvim_clear_autocmds({ group = hahn_group, buffer = bufnr })
        vim.api.nvim_create_autocmd("BufWritePre", {
            group = hahn_group,
            buffer = bufnr,
            callback = function()
              vim.lsp.buf.format({ 
                bufnr = bufnr,
                -- filter = function(client)
                --   return client.name == "null-ls"
                -- end,
              })
            end,
          })
      end
    end,
})

require('lspconfig').tsserver.setup {
    on_attach = function(client, bufnr)
        local ts_utils = require("nvim-lsp-ts-utils")

        -- defaults
        ts_utils.setup {
            debug = false,
            disable_commands = false,
            enable_import_on_completion = true,
            import_on_completion_timeout = 5000,

            -- eslint
            eslint_enable_code_actions = true,
            eslint_bin = "eslint",
            eslint_args = {"-f", "json", "--stdin", "--stdin-filename", "$FILENAME"},
            eslint_enable_disable_comments = true,

            -- experimental settings!
            -- eslint diagnostics
            eslint_enable_diagnostics = true,
            eslint_diagnostics_debounce = 250,

            -- formatting
            enable_formatting = true,
            formatter = "prettier",
            formatter_args = {"--stdin-filepath", "$FILENAME"},
            format_on_save = true,
            no_save_after_format = false,

            -- parentheses completion
            complete_parens = false,
            signature_help_in_parens = true,

            -- update imports on file move
            update_imports_on_move = false,
            require_confirmation_on_move = false,
            watch_dir = "/src",
        }

        -- required to enable ESLint code actions and formatting
        ts_utils.setup_client(client)

        -- no default maps, so you may want to define some here
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gs", ":TSLspOrganize<CR>", {silent = true})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "qq", ":TSLspFixCurrent<CR>", {silent = true})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gr", ":TSLspRenameFile<CR>", {silent = true})
        vim.api.nvim_buf_set_keymap(bufnr, "n", "gi", ":TSLspImportAll<CR>", {silent = true})
    end
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
vim.g.go_build_tags = "integration,unit"

-- vim.api.nvim_create_autocmd("BufEnter", {
--   command = ":GoBuildTags integration",
--   group = hahn_group, 
--   pattern = "*.go",
-- })

--}}}

