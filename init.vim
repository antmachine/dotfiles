set termguicolors

" Specify a directory for plugins
" - For Neovim: ~/.local/share/nvim/plugged
" - Avoid using standard Vim directory names like 'plugin'

" auto-install vim-plug                                                                                                                
"if empty(glob('~/.config/nvim/autoload/plug.vim'))                                                                                    
"  silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs \                                                                  
"      https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim                                                             
"  autocmd VimEnter * PlugInstall                                                                                                      
"endif                                                                                                                                 
call plug#begin('~/.config/nvim/plugged')   

function! BuildComposer(info)
  if a:info.status != 'unchanged' || a:info.force
    if has('nvim')
      !cargo build --release
    else
      !cargo build --release --no-default-features --features json-rpc
    endif
  endif
endfunction

"language compatability 
Plug 'vim-ruby/vim-ruby'
Plug 'mxw/vim-jsx'
Plug 'kchmck/vim-coffee-script'

"Ruby stuff
" Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
" Plug 'tpope/vim-rake'

"Git stuff
Plug 'tpope/vim-fugitive'
Plug 'shumphrey/fugitive-gitlab.vim'
Plug 'airblade/vim-gitgutter'

"Completion
Plug 'ncm2/ncm2'
Plug 'roxma/nvim-yarp'
Plug 'ncm2/ncm2-bufword'
Plug 'fgrsnau/ncm2-otherbuf'
Plug 'ncm2/ncm2-path'
"Plug 'ncm2/ncm2-github'
"Plug 'filipekiss/ncm2-look.vim' => this is for normal English words
Plug 'ncm2/ncm2-syntax' | Plug 'Shougo/neco-syntax'
Plug 'ncm2/ncm2-tern'
"Plug 'pbogut/ncm2-alchemist' => Elixir completion

" Plug 'joshdick/onedark.vim'
Plug 'antmachine/palenight.vim'
Plug 'itchyny/lightline.vim'
" Plug 'ap/vim-buftabline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'baopham/vim-nerdtree-unfocus'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
Plug 'posva/vim-vue'
"Plug 'tpope/vim-vinegar'
"Plug 'roxma/nvim-completion-manager'
"Plug 'roxma/ncm-rct-complete'
Plug 'junegunn/rainbow_parentheses.vim'
Plug 'junegunn/fzf.vim'
Plug '/usr/local/opt/fzf'
Plug 'terryma/vim-multiple-cursors'
Plug 'chrisbra/csv.vim'
Plug 'google/vim-searchindex'
Plug 'dense-analysis/ale'
"Plug 'eugen0329/vim-esearch'
Plug 'ap/vim-css-color'
"Plug 'fmoralesc/nlanguagetool.nvim'
"Plug 'KabbAmine/zeavim.vim', {'on': [
"			\	'Zeavim', 'Docset',
"			\	'<Plug>Zeavim',
"			\	'<Plug>ZVVisSelection',
"			\	'<Plug>ZVKeyDocset',
"			\	'<Plug>ZVMotion'
"			\ ]}
Plug 'euclio/vim-markdown-composer', { 'do': function('BuildComposer') }

" vim-devicons must load last
Plug 'ryanoasis/vim-devicons'

" Initialize plugin system
call plug#end()

syntax on
" colorscheme onedark
set background=dark
colorscheme palenight
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

"CSS, SASS, etc completion
"taken from github.com/ncm2/ncm2-cssomni
call ncm2#register_source({'name' : 'css',
            \ 'priority': 9, 
            \ 'subscope_enable': 1,
            \ 'scope': ['css', 'scss', 'less', 'sass'],
            \ 'mark': 'css',
            \ 'word_pattern': '[\w\-]+',
            \ 'complete_pattern': ':\s*',
            \ 'on_complete': ['ncm2#on_complete#omni',
            \               'csscomplete#CompleteCSS'],
            \ })

" let g:lightline.colorscheme = 'palenight'
let g:palenight_terminal_italics=1
let g:lightline = {
      \ 'colorscheme': 'one',
      \ 'active': {
      \   'left': [ [ 'mode' ],
      \             [ 'readonly', 'filename', 'modified', 'gitbranch' ] ]
      \ },
      \ 'component_function': {
      \   'gitbranch': 'fugitive#head',
      \   'filetype': 'DevIconFileType',
      \   'fileformat': 'DevIconFileFormat'
      \ },
      \ }

function! DevIconFileType()
  return winwidth(0) > 70 ? (strlen(&filetype) ? &filetype . ' ' . WebDevIconsGetFileTypeSymbol() : '') : ''
endfunction

function! DevIconFileFormat()
  return winwidth(0) > 70 ? (&fileformat . ' ' . WebDevIconsGetFileFormatSymbol()) : ''
endfunction

let g:closetag_filenames = '*.jsx, *.vue'
let g:fugitive_gitlab_domains = ['https://gitlab.brivity.com']

" shortcut to toggle ALE on/off
cabbrev AT :ALEToggle<CR>

" Use system clipboard
set clipboard+=unnamedplus

" See preview of command in buffer
set inccommand=nosplit

" <Esc> to exit terminal-mode:
:tnoremap <Esc> <C-\><C-n>

" enable ncm2 for all buffers
autocmd BufEnter * call ncm2#enable_for_buffer()

" IMPORTANT: :help Ncm2PopupOpen for more information
" (menuone, noselect are optiontal)
set completeopt=noinsert,menuone,noselect

" use tab to complete words
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab>"

" NerdTree opens to file, or toggles closed if already open
nmap <silent> <C-D> :NERDTreeFind<CR>

function! NerdTreeOpen()
    return exists('t:NERDTreeBufName') && bufwinnr(t:NERDTreeBufName) != -1
endfunction

if exists(NerdTreeOpen())
    nmap <silent> <C-D> :NERDTreeToggle<CR>
endif

set expandtab
set shiftwidth=2
set softtabstop=2
set number
set noshowmode
set numberwidth=3
set mouse=a

set showcmd 	" display incomplete commands
set incsearch 	" do incremental searching 
set hlsearch	" highlight th searched term
set autowrite	" Auomatically :wriate before running commands

" open splits below and to the right
set splitbelow
set splitright

" jumping around windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h

" Creating splits with empty buffers in all directions
nnoremap <Leader>hn :leftabove  vnew<CR>
nnoremap <Leader>ln :rightbelow vnew<CR>
nnoremap <Leader>kn :leftabove  new<CR>
nnoremap <Leader>jn :rightbelow new<CR>

" map ctrl-s to save (write) disabled in .zshrc for terminal pausing
inoremap <C-s> <esc>:w<cr>
nnoremap <C-s> :w<cr>

" Use ctrl-p to search project for files with fzf
" - via Gfiles which respects .gitignore
nnoremap <c-p> :GFiles<cr>

" Search for word under cursor with Ag fzf
function! SearchWordWithAg()
  execute 'Ag' expand('<cword>')
endfunction

nnoremap <silent> K :call SearchWordWithAg()<CR>


" Search project for word
nnoremap <c-f> :Ag 

" ERB tags snippet
imap <C-t> <%= %><Left><Left><Left>

" pry snippet
iab pry binding.pry

" tn makes new empty tab
cab tn tabnew


" check with lanugage tool need 'copen' command to see them
cabbrev CL call nlanguagetool#call()

" Show when lines extend past column 80
highlight ColorColumn ctermfg=208 ctermbg=Black


" Reselect visual block after indent
vnoremap < <gv
vnoremap > >gv

