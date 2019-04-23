" Keys mapping
let mapleader = "\<space>"
map <esc> :w\|:noh<cr>
map <leader><enter> :Files<cr>
map <leader>[ :Files <cr>
map <leader>\ :History<cr>
map <leader>] :Ag<space>
map <leader>b :Buffers <cr>
map <leader>e :NERDTreeToggle<cr>
map <leader>f :PrettierAsync<cr>
map <leader>n :tabnew<cr>
map <leader>q :q<cr>
map <leader>r :NERDTreeFind<cr>
map <leader>t :tabnew<bar>terminal<cr>i
map <leader>v <C-w>v
map <leader>s <C-w>s
map <leader>w <C-w>w

" Jump back and forth eslint error
map <leader>0 :ALENext<cr>
map <leader>9 :ALEPrevious<cr>

" Copy file path to the clipboard
map <leader>p :let @+ = expand("%")<cr>
" Copy full file path to the clipboard
map <leader>P :let @+ = join([expand('%'),  line(".")], ':')<cr>

" ESC in terminal mode
tnoremap <F2> <C-\><C-n>

" Delete current buffer, includes terminal buffer
map <F3> :bd!<cr>

" Close all buffer except the opening one
map <F4> :%bd\|e#<cr>

" Close all buffers and quit Vim
map <F12> :%bd\|:q<cr>

" Delete without yanking to clipboard "
vnoremap <leader>d "_d
nnoremap <leader>D "_D
nnoremap <leader>d "_d
nnoremap x "_x

" Paste without copy the selected text to clipboard
xnoremap p "_dP

" Always split new windows right
set splitright

" Set theme, font and color scheme
set t_Co=256
set termguicolors
set guifont=Meslo\ LG\ S\ DZ\ Regular\ Nerd\ Font\ Complete\ Mono:h15
colorscheme dracula

" Hide mode in the bottom e.g., -- INSERT --
set noshowmode

" Folding setting
set foldmethod=indent
set foldnestmax=10
set nofoldenable
set foldlevel=20

" Disable MacVim scroll bar left and right
set guioptions=

" Ignore case sensitive when search
set ignorecase

" Enable clipboard to copy from system
set clipboard=unnamedplus

" Hightlight all the search matches
set hlsearch

set encoding=utf8

" Flag to support indent
set expandtab
set tabstop=2
set shiftwidth=2
set autoindent
set smartindent

" Need to zshell because I'm using it, make sure nothing broken
set shell=/bin/zsh

" Using mouse
set mouse=a

" Show line number
set relativenumber

" Use vimrc
set nocompatible

" Show code syntax
syntax enable

" Set persisten undo
set undofile
set undodir=~/.vim/undodir
set undolevels=1000
set undoreload=10000

" Set no backup
set nobackup
set nowb
set noswapfile

" Tags
set tags=tags;/

" Auto reload file changes: check one time after 4s of inactivity in normal mode
set autoread
au CursorHold * checktime

" Quick and dirty function to show the git blame message after the current
" line, depend on `let g:ale_virtualtext_cursor = 1`  to clear the previous text
" :troll:
" Temporary just work with git repo
function ShowGitBlame()
  let l:file = expand('%')
  let l:line = line('.')
  let l:buffer = bufnr('')
  let l:prefix = '¬ '
  
  let l:message = gitblame#commit_summary(l:file, l:line)

  hi GitBlame ctermfg=61 ctermbg=NONE cterm=NONE guifg=#6272a4 guibg=NONE gui=NONE

  call nvim_buf_set_virtual_text(l:buffer, 1, l:line-1, [[l:prefix.l:message, 'GitBlame']], {})
endfunction

au CursorHold * call ShowGitBlame() 

call plug#begin('~/.vim/plugged')

" Prettier
Plug 'prettier/vim-prettier', {'do': 'npm install' }
" Config for auto format
let g:prettier#quickfix_enabled = 0
let g:prettier#autoformat = 0
let g:prettier#config#parser = 'babylon'
" autocmd BufWritePre *.js,*.jsx,*.mjs,*.ts,*.tsx,*.css,*.less,*.scss,*.json,*.graphql,*.md,*.vue PrettierAsync

" Airline
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
let g:airline_powerline_fonts = 1
" Hide the git hunk
" %{airline#util#wrap(airline#extensions#hunks#get_hunks(),0)}%{airline#util#wrap(airline#extensions#branch#get_head(),0)}
let g:airline_section_b = '%{airline#util#wrap(airline#extensions#branch#get_head(),0)}'

" remove the filetype part
let g:airline_section_y = ''
let g:airline_skip_empty_sections = 1
let g:webdevicons_enable_airline_statusline_fileformat_symbols = 0

" Airline theme
let g:airline_theme = 'papercolor'

" Color Schemes
Plug 'flazz/vim-colorschemes'

" NERD Commenter
Plug 'scrooloose/nerdcommenter'
" Need to enable plugin to work correctly
filetype plugin on
" Add spaces after comment delimiters by default
let g:NERDSpaceDelims = 1
" Align line-wise comment delimiters flush left instead of following code indentation
let g:NERDDefaultAlign = 'both'

" NERDtree
Plug 'scrooloose/nerdtree'
" show hidden file
let NERDTreeShowHidden=1

" Nerdtree git plugin
Plug 'Xuyuanp/nerdtree-git-plugin'

" Ale ﰲ     
Plug 'w0rp/ale'
let g:ale_linters_explicit = 1
let g:ale_linters = { 'javascript': ['eslint'] }
let g:ale_sign_error = ''
let g:ale_sign_warning = ''
let g:ale_sign_column_always = 1
let g:ale_virtualtext_cursor = 1 
" let g:ale_virtualtext_prefix = ' '
" hi ALEVirtualTextError ctermfg=61 ctermbg=NONE cterm=NONE guifg=#6272a4 guibg=NONE gui=NONE
hi ALEErrorSign guifg=#FF0000
hi ALEWarningSign guifg=#FFD700

" Vim file type icons
Plug 'ryanoasis/vim-devicons'

" Show git diff
Plug 'airblade/vim-gitgutter'
set updatetime=100

" code complete
Plug 'valloric/youcompleteme'
let g:ycm_error_symbol = ''
let g:ycm_warning_symbol = ''
hi YcmErrorSign guifg=#FF0000
hi YcmWarningSign guifg=#FFD700

" Waka time
Plug 'wakatime/vim-wakatime'

" Auto pairs the bracket [ { (...
Plug 'jiangmiao/auto-pairs'

" Javascript syntax
Plug 'pangloss/vim-javascript'
Plug 'mxw/vim-jsx'
" Enable syntax for jsdocs
let g:javascript_plugin_jsdoc = 1

" FZF plugin
Plug '/usr/local/opt/fzf'
Plug 'junegunn/fzf.vim'

" Git plugin
Plug 'tpope/vim-fugitive'

" Git blame status
Plug 'zivyangll/git-blame.vim'

" Snipet
Plug 'SirVer/ultisnips'
" Makes ultisnip works with YCM
" let g:UltiSnipsExpandTrigger = "<nop>"
" let g:ulti_expand_or_jump_res = 0
" function ExpandSnippetOrCarriageReturn()
"     let snippet = UltiSnips#ExpandSnippetOrJump()
"     if g:ulti_expand_or_jump_res > 0
"         return snippet
"     else
"         return "\<CR>"
"     endif
" endfunction
" inoremap <expr> <CR> pumvisible() ? "\<C-R>=ExpandSnippetOrCarriageReturn()\<CR>" : "\<CR>"

" More snipet file
Plug 'honza/vim-snippets'

" Graphql for vim
Plug 'jparise/vim-graphql'

" Manage the tags
Plug 'ludovicchabant/vim-gutentags'

" JSDoc
Plug 'heavenshell/vim-jsdoc'
let g:jsdoc_enable_es6=1

call plug#end()
