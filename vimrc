let $VIMHOME=$HOME."/.dotfiles/.vim/"

set nocompatible
filetype off

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
call vundle#begin()
Plugin 'mileszs/ack.vim'
Plugin 'jeroenbourgois/vim-actionscript'
Plugin 'tpope/vim-bundler'
Plugin 'docunext/closetag.vim'
Plugin 'kchmck/vim-coffee-script'
Plugin 'wincent/Command-T'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-endwise'
Plugin 'tpope/vim-fugitive'
Plugin 'airblade/vim-gitgutter'
Plugin 'jnwhiteh/vim-golang'
Plugin 'plasticboy/vim-markdown'
Plugin 'scrooloose/nerdtree'
Plugin 'kevinw/pyflakes-vim'
Plugin 'tpope/vim-rails'
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-ruby/vim-ruby'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-surround'
Plugin 'majutsushi/tagbar'
Plugin 'zaiste/tmux.vim'
Plugin 'evidens/vim-twig'
call vundle#end()            " required
filetype plugin indent on    " required


" map leader key to comma
let mapleader=","

" activate mouse
set mouse=a

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Color schemes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
 
set encoding=utf8 " Change the encoding to support special characters

set number " line number
set list listchars=tab:▸\ ,trail:· " Highlight the trailing whitespaces
set showcmd " Displays the command currently typing

if has("gui")
  colorscheme Monokai
  set guifont=Source\ Code\ Pro:h12
endif

set t_Co=256 " 256 colors
set background=dark
color grb256

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" indentation
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

function! Stab(value)
  let &tabstop=a:value
  let &shiftwidth=a:value
  let &softtabstop=a:value
endfunction

set smartindent
set expandtab
call Stab(4)

" indent default settings
"for ruby, autoindent with two spaces, always expand tabs
autocmd FileType ruby,haml,eruby,yaml,html,javascript,sass,cucumber set ai sw=2 sts=2 et
autocmd FileType python set sw=4 sts=4 et
autocmd FileType go set sw=4 sts=4 noet

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" search config
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

set hlsearch " highlight search results
set ignorecase " Insensitive search
set smartcase   " smart case (Foo only searches for Foo, foo searches for Foo, foo, fOO, ...)

set hidden " Keep files in the background on :e

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" Handle panes
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" navigate panes with c-hjkl
nnoremap <c-j> <c-w>j
nnoremap <c-k> <c-w>k
nnoremap <c-h> <c-w>h
nnoremap <c-l> <c-w>l

set winwidth=84
" We have to have a winheight bigger than we want to set winminheight. But if
" we set winheight to be huge before winminheight, the winminheight set will
" fail.
set winheight=10
set winminheight=10
set winheight=999

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" commanT
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" configuration
let g:CommandTMaxHeight=20

" commandT global shortcuts
map <leader>f   :CommandTFlush<cr>\|:CommandT<cr>
map <leader>gf  :CommandTFlush<cr>\|:CommandT %%<cr>
map <leader>b   :CommandTFlush<cr>\|:CommandTBuffer<cr>

" rails specific commandT configuration
map <leader>gv :CommandTFlush<cr>\|:CommandT app/views<cr>
map <leader>gc :CommandTFlush<cr>\|:CommandT app/controllers<cr>
map <leader>gm :CommandTFlush<cr>\|:CommandT app/models<cr>
map <leader>gh :CommandTFlush<cr>\|:CommandT app/helpers<cr>
map <leader>gl :CommandTFlush<cr>\|:CommandT lib<cr>
map <leader>gp :CommandTFlush<cr>\|:CommandT public<cr>
map <leader>gs :CommandTFlush<cr>\|:CommandT public/stylesheets<cr>
map <leader>gf :CommandTFlush<cr>\|:CommandT features<cr>
map <leader>gg :topleft 100 :split Gemfile<cr>
map <leader>gt :CommandTFlush<cr>\|:CommandTTag<cr>


""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom key binding
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

" give the ability to record with qq and play back only pressing Q
nnoremap Q @q

" use ; with :
nnoremap ; :

" remap c-c to esc
map <c-c> <esc>

" Insert a hash rocket with <c-l>
imap <c-l> =>

" bind ,, to switch with previous file
nnoremap <leader><leader> <c-^>

" Clear the search buffer when hitting return
function! MapCR()
  nnoremap <cr> :nohlsearch<cr>
endfunction
call MapCR()

" maps %% to expand to current file path
cnoremap %% <C-R>=expand('%:h').'/'<cr>
map <leader>e :edit %%
map <leader>v :view %%

" toggle paste modes
nmap <leader>p :setlocal paste! paste?<cr>

" remap <leader>. to :A
nnoremap <leader>. :A<cr>

" nerd tree bind
nnoremap <leader>d :NERDTreeToggle<cr>
nnoremap <leader>D :NERDTreeFind<cr>

" search with ack
nmap <leader>a :Ack
let g:ackprg = 'ag --nogroup --column' " use the silver searcher instead (its faster)

" tagbar
nmap <leader>] :TagbarToggle<cr>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" MULTIPURPOSE TAB KEY
" Indent if we're at the beginning of a line. Else, do completion.
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
function! InsertTabWrapper()
    let col = col('.') - 1
    if !col || getline('.')[col - 1] !~ '\k'
        return "\<tab>"
    else
        return "\<c-p>"
    endif
endfunction
inoremap <tab> <c-r>=InsertTabWrapper()<cr>
inoremap <s-tab> <c-n>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" disable arrow keys
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" custom syntax configuration
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
autocmd BufNewFile,BufRead *.haml,*.hamlbars setf haml
