" make it sick
execute pathogen#infect()

syntax on
filetype plugin indent on
colorscheme Monokai

nmap <silent> <C-D> :NERDTreeToggle<CR>
set expandtab
set shiftwidth=2
set softtabstop=2
set number
set noshowmode
set numberwidth=3
set mouse=a

" map ctrl-s to save (write) disabled in .zshrc for terminal pausing
inoremap <C-s> <esc>:w<cr>
nnoremap <C-s> :w<cr>

" jumping around windows
noremap <C-J> <C-W>j
noremap <C-K> <C-W>k
noremap <C-L> <C-W>l
noremap <C-H> <C-W>h

" use ag in vim, if possible
if executable('ag')
 let g:ackprg = 'ag --vimgrep'
endif

" make whitespace obvious
set listchars=nbsp:¬,tab:»·,trail:˷

" run specs with thoughtbot/vim-rspec
" RSpec.vim mappings
map <Leader>t :call RunCurrentSpecFile()<CR>
map <Leader>s :call RunNearestSpec()<CR>
map <Leader>l :call RunLastSpec()<CR>
map <Leader>a :call RunAllSpecs()<CR>
