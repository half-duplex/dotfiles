"runtime bundle/vim-pathogen/autoload/pathogen.vim
"execute pathogen#infect()

syntax on
set cindent
set tabstop=4
set softtabstop=4
set shiftwidth=4
set expandtab
set number
set tw=79
set nowrap
set fo-=t
"set colorcolumn=80
set background=dark

" save sudo-only files
cmap w!! %!sudo tee > /dev/null %

" ex mode commands made easy
nnoremap ; :

" absolute line numbers in insert mode, relative otherwise for easy movement
au InsertEnter * :set nu
au InsertLeave * :set rnu

noremap H ^
noremap L $

" save and run (requires shebang and +x)
map <F5> <Esc>:w<CR>:!clear<CR>:! time ./%<CR>

" scroll before reaching edge
set scrolloff=8 " Number of lines from vertical edge to start scrolling
set sidescrolloff=15 " Number of cols from horizontal edge to start scrolling
set sidescroll=1 " Number of cols to scroll at a time

" move the cursor in insert mode
"imap <C-h> <C-o>h
"imap <C-j> <C-o>j
"imap <C-k> <C-o>k
"imap <C-l> <C-o>l

let mapleader = ","

" easier to reach Esc
inoremap ii <Esc>

nnoremap U <C-r>

" I can type :help on my own, thanks.
noremap <F1> <Esc>
inoremap <F1> <Esc>

" disable arrow keys
inoremap  <Up>     <NOP>
inoremap  <Down>   <NOP>
inoremap  <Left>   <NOP>
inoremap  <Right>  <NOP>
noremap   <Up>     <NOP>
noremap   <Down>   <NOP>
noremap   <Left>   <NOP>
noremap   <Right>  <NOP>

" bind C-<key> to move between windows instead of C-w-<key>
"map <c-j> <c-w>j
"map <c-k> <c-w>k
"map <c-l> <c-w>l
"map <c-h> <c-w>h

" easier moving between tabs
"" map <Leader>n <esc>:tabprevious<CR>
"" map <Leader>m <esc>:tabnext<CR>

" Use only real tabs in makefiles
autocmd FileType make setlocal noexpandtab

" git diff in window split when commiting
"autocmd FileType gitcommit DiffGitCached | wincmd p

set pastetoggle=<F2>

" Append modeline after last line in buffer.
" Use substitute() instead of printf() to handle '%%s' modeline in LaTeX
" files.
function! AppendModeline()
    let l:modeline = printf(" vim: set ts=%d sw=%d tw=%d %set :",
            \ &tabstop, &shiftwidth, &textwidth, &expandtab ? '' : 'no')
    let l:modeline = substitute(&commentstring, "%s", l:modeline, "")
    call append(line("$"), l:modeline)
endfunction
nnoremap <silent> <Leader>ml :call AppendModeline()<CR>

" Use space-tabs only at the beginning of lines
" inoremap <Silent> <Tab> <C-R>=(col('.') > (matchend(getline('.'), '^\s*') + 1))?'<C-V><C-V><Tab>':'<Tab>'<CR>

" Show < or > when characters are not displayed on the left or right.
:set list listchars=precedes:<,extends:>
" Same, but also show tabs and trailing spaces.
:set list listchars=tab:>-,trail:.,precedes:<,extends:>

highlight ExtraWhitespace ctermbg=red guibg=red
match ExtraWhitespace /\s\+$/
autocmd BufWinEnter * match ExtraWhitespace /\s\+$/
autocmd InsertEnter * match ExtraWhitespace /\s\+\%#\@<!$/
autocmd InsertLeave * match ExtraWhitespace /\s\+$/
autocmd BufWinLeave * call clearmatches()

" Better navigating through omnicomplete option list
" See http://stackoverflow.com/questions/2170023/how-to-map-keys-for-popup-menu-in-vim
"set completeopt=longest,menuone
"function! OmniPopup(action)
"    if pumvisible()
"        if a:action == 'j'
"            return "\<C-N>"
"        elseif a:action == 'k'
"            return "\<C-P>"
"        endif
"    endif
"    return a:action
"endfunction
"inoremap <silent><C-j> <C-R>=OmniPopup('j')<CR>
"inoremap <silent><C-k> <C-R>=OmniPopup('k')<CR>


" Python folding
" mkdir -p ~/.vim/ftplugin
" wget -O ~/.vim/ftplugin/python_editing.vim http://www.vim.org/scripts/download_script.php?src_id=5492
"set nofoldenable
