"
" _   _ ____     __  ____   __  ___ _   _ ___ _______     _____ __  __ 
"| \ | | __ )   |  \/  \ \ / / |_ _| \ | |_ _|_   _\ \   / /_ _|  \/  |
"|  \| |  _ \   | |\/| |\ V /   | ||  \| || |  | |  \ \ / / | || |\/| |
"| |\  | |_) |  | |  | | | |    | || |\  || |  | |   \ V /  | || |  | |
"|_| \_|____/___|_|  |_| |_|___|___|_| \_|___| |_|____\_/  |___|_|  |_|
"          |_____|        |_____|               |_____|                
"
let mapleader = "\<space>"

"# number line
set number 
set relativenumber
set cursorline
set termguicolors
set ignorecase
set mouse=a



"set foldmethod=indent
set scrolloff=5
" tab = 4
"
set ts=4
set shiftwidth=4
"# 
set hidden

set updatetime=100

set shortmess+=c

let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"

call plug#begin()

Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'nvim-tree/nvim-web-devicons'
Plug 'nvim-tree/nvim-tree.lua' 
Plug 'akinsho/bufferline.nvim', { 'tag': '*' }
Plug 'windwp/nvim-autopairs'
Plug 'nvim-lua/plenary.nvim'
Plug 'nvim-telescope/telescope.nvim', { 'tag': '0.1.5' }
Plug 'folke/tokyonight.nvim'
Plug 'nvim-treesitter/nvim-treesitter', {'do': ':TSUpdate'}
call plug#end()

let g:coc_global_extensions = [
			\'coc-clangd',
			\'coc-json',
			\'coc-vimlsp']

lua <<EOF

require("bufferline").setup {
    options = {
        -- 使用 nvim 内置lsp
        diagnostics = "nvim_lsp",
        -- 左侧让出 nvim-tree 的位置
        offsets = {{
            filetype = "NvimTree",
            text = "File Explorer",
            highlight = "Directory",
            text_align = "left"
        }}
    }
}


require("nvim-tree").setup({
  sort_by = "case_sensitive",
  hijack_cursor = true,
  system_open = {
    cmd = "open",
  },
  view = {
    width = 5,
    adaptive_size = true,
  },
  renderer = {
    group_empty = true,
    icons = {
      show = {
        git = true,
        file = false,
        folder = false,
        folder_arrow = true,
      },
      glyphs = {
        bookmark = " ",
        folder = {
          arrow_closed = "⏵",
          arrow_open = "⏷",
        },
        git = {
          unstaged = "✗",
          staged = "✓",
          unmerged = "⌥",
          renamed = "➜",
          untracked = "★",
          deleted = "⊖",
          ignored = "◌",
        },
      },
    },
  },
  filters = {
    dotfiles = false,
  },
})

require('telescope').setup {
  extensions = {
    fzf = {
      fuzzy = true,                    -- false will only do exact matching
      override_generic_sorter = true,  -- override the generic sorter
      override_file_sorter = true,     -- override the file sorter
      case_mode = "smart_case",        -- or "ignore_case" or "respect_case"
    }
  }
}
EOF


lua require 'nvim-autopairs'.setup{}
lua require'nvim-treesitter.configs'.setup {
			\ ensure_installed = { "c", "cpp" },
			\ highlight = {
			\ enable = true,
			\ }
			\}


lua  require('tokyonight').setup{}

colorscheme tokyonight


inoremap <silent><expr> <TAB>
      \ coc#pum#visible() ? coc#pum#next(1) :
      \ CheckBackspace() ? "\<Tab>" :
      \ coc#refresh()
inoremap <expr><S-TAB> coc#pum#visible() ? coc#pum#prev(1) : "\<C-h>"


inoremap <silent><expr> <CR> coc#pum#visible() ? coc#pum#confirm()
                              \: "\<C-g>u\<CR>\<c-r>=coc#on_enter()\<CR>"


function! CheckBackspace() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" select the complete ctrl + space

inoremap <silent><expr> <C-space> coc#refresh()


nmap Q :q<CR>
inoremap jk <ESC> 


" Use `[g` and `]g` to navigate diagnostics
" Use `:CocDiagnostics` to get all diagnostics of current buffer in location list
nmap <silent> [g <Plug>(coc-diagnostic-prev)
nmap <silent> ]g <Plug>(coc-diagnostic-next)


" GoTo code navigation
nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

" Use K to show documentation in preview window
nnoremap <silent> K :call ShowDocumentation()<CR>

" Highlight the symbol and its references when holding the cursor
autocmd CursorHold * silent call CocActionAsync('highlight')

" Symbol renaming
nmap rn <Plug>(coc-rename)


nnoremap <A-m> :NvimTreeToggle<CR>


nnoremap <C-h> :BufferLineCyclePrev<CR>
nnoremap <C-l> :BufferLineCycleNext<CR>

map <LEADER><up> :res +5<CR>
map <LEADER><down> :res -5<CR>
map <LEADER><left> :vertical resize -5<CR>
map <LEADER><right> :vertical resize +5<CR>

nnoremap <leader>ff :Telescope find_files<cr>
nnoremap <leader>fg :Telescope live_grep<cr>
nnoremap <leader>fb :Telescope buffers<cr>
nnoremap <leader>fh :Telescope help_tags<cr>
