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


Plug 'joshdick/onedark.vim'
Plug 'itchyny/lightline.vim'
" Plug 'ap/vim-buftabline'
Plug 'scrooloose/nerdtree'
Plug 'Xuyuanp/nerdtree-git-plugin'
Plug 'baopham/vim-nerdtree-unfocus'
Plug 'Yggdroot/indentLine'
Plug 'jiangmiao/auto-pairs'
Plug 'alvan/vim-closetag'
Plug 'tpope/vim-obsession'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-rhubarb'
Plug 'tpope/vim-bundler'
Plug 'tpope/vim-rails'
Plug 'tpope/vim-commentary'
Plug 'tpope/vim-rake'
Plug 'tpope/vim-ragtag'
Plug 'tpope/vim-unimpaired'
Plug 'tpope/vim-surround'
Plug 'tpope/vim-endwise'
"Plug 'tpope/vim-vinegar'
Plug 'airblade/vim-gitgutter'
Plug 'roxma/nvim-completion-manager'
Plug 'roxma/ncm-rct-complete'
Plug 'calebeby/ncm-css'
Plug 'junegunn/rainbow_parentheses.vim'
Plug '/usr/bin/fzf'
Plug 'junegunn/fzf.vim'
Plug 'kchmck/vim-coffee-script'
Plug 'mxw/vim-jsx'
Plug 'chrisbra/csv.vim'
Plug 'terryma/vim-multiple-cursors'
Plug 'roxma/nvim-cm-tern',  {'do': 'npm install'}
Plug 'vim-ruby/vim-ruby'
Plug 'w0rp/ale'
"Plug 'eugen0329/vim-esearch'
Plug 'ap/vim-css-color'
Plug 'fmoralesc/nlanguagetool.nvim'
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
colorscheme onedark
let g:rainbow#pairs = [['(', ')'], ['[', ']'], ['{', '}']]

let g:lightline = {
      \ 'colorscheme': 'onedark',
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

let g:closetag_filenames = '*.jsx'

	
" shortcut to toggle ALE on/off
cabbrev AT :ALEToggle<CR>

" Use system clipboard
set clipboard+=unnamedplus


" <Esc> to exit terminal-mode:
:tnoremap <Esc> <C-\><C-n>

" use tab to complete words
inoremap <expr> <Tab> pumvisible() ? "\<C-n>" : "\<Tab>"
inoremap <expr> <S-Tab> pumvisible() ? "\<C-p>" : "\<S-Tab

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
