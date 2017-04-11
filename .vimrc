set nocompatible              " be iMproved, required
filetype off                  " required
set t_Co=256                  " set vim for 256 colored terms

" set the runtime path to include Vundle and initialize
set rtp+=~/.vim/bundle/Vundle.vim
" #################
call vundle#begin()
" alternatively, pass a path where Vundle should install plugins
" call vundle#begin('~/some/path/here')

" let Vundle manage Vundle, required
Plugin 'VundleVim/Vundle.vim'

" The following are examples of different formats supported.
" Keep Plugin commands between vundle#begin/end.
" plugin on GitHub repo
" Plugin 'tpope/vim-fugitive'
" plugin from http://vim-scripts.org/vim/scripts.html
" Plugin 'L9'
" Git plugin not hosted on GitHub
" Plugin 'git://git.wincent.com/command-t.git'
" git repos on your local machine (i.e. when working on your own plugin)
" Plugin 'file:///home/gmarik/path/to/plugin'
" The sparkup vim script is in a subdirectory of this repo called vim.
" Pass the path to set the properly.
" Plugin 'rstacruz/sparkup', {'rtp': 'vim/'}
" Install L9 and avoid a Naming conflict if you've already installed a
" different version somewhere else.
" Plugin 'ascenator/L9', {'name': 'newL9'}

Plugin 'mileszs/ack.vim'
Plugin 'jiangmiao/auto-pairs'
Plugin 'ctrlpvim/ctrlp.vim'
Plugin 'wincent/command-t'
Plugin 'junegunn/goyo.vim'
Plugin 'sjl/gundo.vim'
Plugin 'scrooloose/nerdtree'
Plugin 'Xuyuanp/nerdtree-git-plugin'
Plugin 'mkitt/tabline.vim'
Plugin 'vim-airline/vim-airline'
Plugin 'vim-airline/vim-airline-themes'
Plugin 'flazz/vim-colorschemes'
Plugin 'ap/vim-css-color'
Plugin 'tpope/vim-fugitive'
Plugin 'tpope/vim-sensible'
Plugin 'tpope/vim-bundler'
Plugin 'tpope/vim-rails'
Plugin 'tpope/vim-commentary'
Plugin 'tpope/vim-rake'
Plugin 'tpope/vim-ragtag'
Plugin 'tpope/vim-unimpaired'
Plugin 'tpope/vim-surround'
Plugin 'airblade/vim-gitgutter'
Plugin 'shime/vim-livedown'
Plugin 'terryma/vim-multiple-cursors'
Plugin 'thoughtbot/vim-rspec'
Plugin 'vim-ruby/vim-ruby'
Plugin 'ddrscott/vim-side-search'
Plugin 'adamlowe/vim-slurper'
Plugin 'kchmck/vim-coffee-script'
Plugin 'mxw/vim-jsx'
Plugin 'Valloric/YouCompleteMe'
Plugin 'vim-syntastic/syntastic'
Plugin 'szw/vim-tags'
Plugin 'craigemery/vim-autotag'
Plugin 'Shougo/denite.nvim'
Plugin 'gabrielelana/vim-markdown'
Plugin 'vim-scripts/genutils'
Plugin 'vim-scripts/Nibble'
Plugin 'vim-scripts/TeTrIs.vim'
" vim-tmux
" vim-devicons must load last
Plugin 'ryanoasis/vim-devicons'


" All Plugins must be added before the following line
call vundle#end()            " required
" #################
filetype plugin indent on    " required
" OR to ignore plugin indent changes, instead use:
" filetype plugin on
"
" Some commands
" :PluginList       - lists configured plugins
" :PluginInstall    - installs plugins; append `!` to update or just :PluginUpdate
" :PluginSearch foo - searches for foo; append `!` to refresh local cache
" :PluginClean      - confirms removal of unused plugins; append `!` to auto-approve removal
"
" see :h vundle for more details or wiki for FAQ
" Put your non-Plugin stuff after this line

set encoding=utf-8
syntax on
colorscheme Monokai
let g:airline_theme='distinguished'
" get special font glyphs
let g:airline_powerline_fonts = 1

" set ruler         " show the cursor position all the time
set showcmd       " display incomplete commands
set incsearch     " do incremental searching
" set laststatus=2  " Always display the status line
set autowrite     " Automatically :write before running commands"

" set guifont=Inconsolata\ For\ Powerline\ Nerd\ Font\ Complete:h11
" These are the basic settings to get the font to work (required):
" set guifont=DroidSansMonoForPowerline\ Nerd\ Font\ Complete:h12
" required if using https://github.com/bling/vim-airline
" let g:airline_powerline_fonts=1

nmap <silent> <C-D> :NERDTreeToggle<CR>
set expandtab
set shiftwidth=2
set softtabstop=2
set number
set noshowmode
set numberwidth=3
set mouse=a

" get autocomplete suggestions
set omnifunc=complete#Complete

" recommended syntastic settings
let g:syntastic_always_populate_loc_list = 1
let g:syntastic_auto_loc_list = 1
let g:syntastic_check_on_open = 1
let g:syntastic_check_on_wq = 0

set statusline+=%#warningmsg#
set statusline+=%{SyntasticStatuslineFlag()}
set statusline+=%*
" set the height of the syntastic location window
let g:syntastic_loc_list_height=5

" shortcut to toggle syntastic in/ out of passive mode
cabbrev ST SyntasticToggleMode

" map ctrl-s to save (write) disabled in .zshrc for terminal pausing
inoremap <C-s> <esc>:w<cr>
nnoremap <C-s> :w<cr>

" open splits below and to the right
set splitbelow
set splitright
" jumping around windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h

" use ag in vim, if possible
" if executable('ag')
"  let g:ackprg = 'ag --vimgrep'
" endif

" The Silver Searcher
if executable('ag')
" Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor

" Use ag in CtrlP for listing files. Lightning fast and respects .gitignore
  let g:ctrlp_user_command = 'ag %s -l --nocolor -g ""'

" ag is fast enough that CtrlP doesn't need to cache
  let g:ctrlp_use_caching = 0
endif

" bind K to grep word under cursor
nnoremap K :grep! "\b<C-R><C-W>\b"<CR>:cw<CR>

" map ctrlp to use mixed mode
let g:ctrlp_map = '<c-p>'
let g:ctrlp_cmd = 'CtrlPMixed'
" get buffer list with ctrl-b
map <C-b> :CtrlPBuffer<CR>

" make whitespace obvious
set listchars=nbsp:¬,tab:»·,trail:˷

" toggle the markdown preview
nmap gm :LivedownToggle<CR>

" SideSearch current word and return to original window
nnoremap <Leader>ss :SideSearch <C-r><C-w><CR> | wincmd p
" Create an shorter `SS` command
command! -complete=file -nargs=+ SS execute 'SideSearch <args>'
" or command abbreviation
cabbrev SS SideSearch

" use the system clipboard when yanking
set clipboard=unnamed

" ERB tags snippet
imap <C-t> <%= %><Left><Left><Left>

" pry snippet
iab pry binding.pry

" tn makes a new empty tab
cab tn tabnew


"====[ Show when lines extend past column 80 ]=================================>-<=====================

highlight ColorColumn ctermfg=208 ctermbg=Black

function! MarkMargin (on)
    if exists('b:MarkMargin')
        try
            call matchdelete(b:MarkMargin)
        catch /./
        endtry
        unlet b:MarkMargin
    endif
    if a:on
        let b:MarkMargin = matchadd('ColorColumn', '\%81v\s*\S', 100)
    endif
endfunction

augroup MarkMargin
    autocmd!
    autocmd  BufEnter  *       :call MarkMargin(1)
    autocmd  BufEnter  *.vp*   :call MarkMargin(0)
augroup END

"====[ I'm sick of typing :%s/.../.../g ]=======

nmap S  [Shortcut for :s///g]  :%s//g<LEFT><LEFT>
vmap S                         :Blockwise s//g<LEFT><LEFT>

nmap <expr> M  [Shortcut for :s/<last match>//g]  ':%s/' . @/ . '//g<LEFT><LEFT>'
vmap <expr> M                                     ':s/' . @/ . '//g<LEFT><LEFT>'

" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

" Make vaa select the entire file...
vmap aa VGo1G

" run specs with thoughtbot/vim-rspec
" RSpec.vim mappings
" map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
map <Leader>c :call RunCurrentSpecFile()<CR>
