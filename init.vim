set nocompatible              " be iMproved, required
filetype off                  " required

call plug#begin('~/.vim/autoload')
"RustLang syntax
Plug 'rust-lang/rust.vim'
"Tab autoexpantion
Plug 'ervandew/supertab'
"Search complete lol
Plug 'vim-scripts/SearchComplete'
"Simple syntax highlinting for GOLANG
Plug 'geekq/vim-go'
Plug 'scrooloose/nerdtree'
Plug 'majutsushi/tagbar'
Plug 'haya14busa/incsearch.vim'
"=============VIM COLORS BEGIN==========
Plug 'joshdick/onedark.vim'
Plug 'Reewr/vim-monokai-phoenix'
"=============VIM COLORS END============


" All of your Plugins must be added before the following line
call plug#end()            " required
filetype plugin on    " required

autocmd Filetype html setlocal ts=2 sts=2 sw=2

syntax on
set number
set tabstop=4
set softtabstop=4
set wildmenu
set shiftwidth=4
set ignorecase
set cursorline
set mouse=a
set termguicolors
colo onedark

let $NVIM_TUI_ENABLE_CURSOR_SHAPE=2

"if has("gui_running") 
"	colorscheme one
"	set background=dark
"	set guifont=Monaco:h12
"else
	"color jellybeans
"endif


"##############PLUGINS####################
"map <silent> / <Plug>(incsearch-forward)


"############PLUGINS END##################
noremap <Down> gj
noremap <Up> gk

"for copy to system clipboard
noremap <C-c> "+y

noremap <Space> %
noremap 9 0
noremap 0 $
noremap w <S-Left>
noremap e <S-Right>
nnoremap <silent> gmt :tabm +1<CR>
nnoremap <silent> gmT :tabm -1<CR>
noremap <silent> <C-s> :vs<CR>
noremap <Tab> gt

"FOR TOGBAR PLUGIN
noremap <A-M> :TagbarTogle<CR>

"making searches highlight the thing
nmap <silent> / :let @/=""<CR>:set hlsearch<CR><Plug>(incsearch-forward)
nmap <silent> ? :let @/=""<CR>:set hlsearch<CR><Plug>(incsearch-backward)
nnoremap <silent> * :set hlsearch<CR>*
nnoremap <silent> # :set hlsearch<CR>#
"but also sometimes i want to search without highlights
noremap <silent> <Space>/ /
noremap <silent> <Space>? ?

nnoremap <silent> g* yiw:let @/=@"<CR>:set hlsearch<CR>
vnoremap <silent> g* <C-C>yiw:let @/=@"<CR>:set hlsearch<CR>gv
vnoremap <silent> g/ y/<C-R>"<CR>:set hlsearch<CR>
nnoremap <silent> g/ :set hlsearch<CR>
nnoremap <silent> <Esc> :set nohlsearch<CR>

