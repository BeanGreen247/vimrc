set shell=bash
syntax on
set nu
set relativenumber
set wildmenu
set ruler
set smartcase
set hlsearch
set incsearch
set lazyredraw
set noerrorbells
set novisualbell
set t_vb=
set tm=500
set autoindent
set splitbelow
set termwinsize=10x0

vnoremap <silent> * :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy/<C-R><C-R>=substitute(
  \escape(@", '/\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>
vnoremap <silent> # :<C-U>
  \let old_reg=getreg('"')<Bar>let old_regtype=getregtype('"')<CR>
  \gvy?<C-R><C-R>=substitute(
  \escape(@", '?\.*$^~['), '\_s\+', '\\_s\\+', 'g')<CR><CR>
  \gV:call setreg('"', old_reg, old_regtype)<CR>

" Highlight trailing spaces,etc
:highlight ExtraWhitespace ctermbg=red guibg=red
:match ExtraWhitespace /\s\+$/

set hidden

" Cycle/Move across buffers using CTRL + H and CTRL + L
:map <C-L> :bnext<CR>
:map <C-H> :bprevious<CR>

" Open new buffer with CTRL + T
:map <C-T> :enew<CR>

" Close buffer with CTRL + C, (Opens the previous buffer after closing the
" current one, this makes closing work as expected)
:map <C-C> :bp\|bd #<CR>

" Use CtrlP in regex mode by default
let g:ctrlp_regexp = 1

" Makes CtrlP fuzzy searching work more like the one I use in Sublime Text
" Specifically, this will match spaces with underscores
let g:ctrlp_abbrev = {
    \ 'gmode': 't',
    \ 'abbrevs': [
        \ {
        \ 'pattern': ' ',
        \ 'expanded': '.*',
        \ 'mode': 'pfrz',
        \ },
        \ ]
    \ }

" Disable Line numbers
:map <Leader>q :set norelativenumber<CR> <bar> :set nonumber<CR>

" Enable Line numbers
:map <Leader>w :set number<CR> <bar> :set relativenumber<CR>

" easytags config:
" Make tagging async
" Tag all the files (instead of the current one) WARNING: Do not open vim in a
" big directory structure ( eg. ~/ )
"let g:easytags_async = 1
"let g:easytags_autorecurse = 1
let g:airline_section_y = "%{gutentags#statusline('Generating Tags My guy......')}"
let g:airline_theme = 'codedark'

let g:ctrlp_cache_dir = $HOME . '/.cache/ctrlp'

" Time for rg instead of ag, Thanks: https://elliotekj.com/2016/11/22/setup-ctrlp-to-use-ripgrep-in-vim/
" and http://www.wezm.net/technical/2016/09/ripgrep-with-vim/
if executable('rg')
  set grepprg=rg\ --vimgrep\ --no-heading
  set grepformat=%f:%l:%c:%m,%f:%l:%m

  let g:ctrlp_user_command = 'rg %s --files --color=never --glob ""'
  let g:ctrlp_use_caching = 0
endif

" bind K to grep for word under cursor
nnoremap K :exe 'Ag' expand('<cword>')<cr>

" bind :Ag to grep shortcut
command -nargs=+ -complete=file -bar Ag silent! grep! "<args>"|cwindow|redraw!

" Auto close quickfix when exiting Vim.
function! s:CloseIfOnlyControlWinLeft()
  if winnr("$") != 1
    return
  endif
  if (exists("t:NERDTreeBufName") && bufwinnr(t:NERDTreeBufName) != -1)
        \ || &buftype == 'quickfix'
    q
  endif
endfunction
augroup CloseIfOnlyControlWinLeft
  au!
  au BufEnter * call s:CloseIfOnlyControlWinLeft()
augroup END

:autocmd BufNewFile  *.cpp  0r ~/.vim/templates/cpp.cpp

set foldmethod=indent
set foldnestmax=10
set foldlevel=2

autocmd StdinReadPre * let s:std_in=1

" Disable arrow keys
no <down> <Nop>
no <left> <Nop>
no <right> <Nop>
no <up> <Nop>

ino <down> <Nop>
ino <left> <Nop>
ino <right> <Nop>
ino <up> <Nop>

vno <down> <Nop>
vno <left> <Nop>
vno <right> <Nop>
vno <up> <Nop>