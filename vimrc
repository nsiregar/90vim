"Base Config
 set title
 set relativenumber
 set ruler
 set hlsearch
 set mouse=
 set completeopt-=preview
 set backspace=indent,eol,start
 set tabstop=2
 set shiftwidth=2
 set expandtab
 set smarttab
 set cmdheight=2
 set encoding=utf-8 nobomb
 set cursorline
 set background=dark
 set autoindent
 set smartindent
 set hidden
 set nostartofline
 set splitbelow
 set splitright
 set wildmenu
 set wildmode=list:longest,list:full
 set wildignore+=*.o,*.obj,.git,*.rbc,*.pyc,__pycache__
 set nowrap
 set showcmd
 set t_Co=256

 filetype on
 filetype plugin on
 filetype indent on
 set completeopt=longest,menuone
 set omnifunc=syntaxcomplete#Complete

"swap file
 set swapfile
 set dir=/tmp

 set autoread
 augroup checktime
  autocmd!
  autocmd CursorHold,FocusGained,BufEnter * silent! checktime
 augroup END

"COLORING
"line number
 highlight LineNr ctermfg=grey
"cursorline
 highlight clear CursorLine
 highlight clear CursorLineNr
 highlight clear CursorLineTabLine
 highlight CursorLineNR ctermbg=DarkGray
 highlight CursorLine ctermbg=DarkGray
"splitbar
 highlight VertSplit ctermbg=black ctermfg=black
"tab bar
 highlight Tabline cterm=None
 highlight TablineSel term=bold ctermbg=4 guibg=DarkBlue

"show whitespaces
 set list
 set listchars=tab:>\ ,trail:-,extends:>,precedes:<,nbsp:⍽

"show tabline
 set tabline=%!NumberingTab()
 set showtabline=2

 function NumberingTab()
    let s = ''
    for i in range(tabpagenr('$'))
        let idx = i + 1
        if idx == tabpagenr()
            let s .= '%#TabLineSel#'
        else
            let s .= '%#TabLine#'
        endif

        let s .= ' ' . idx . ' %{LabelingTab(' . idx . ')} '
    endfor
    let s .= '%#TabLineFill#%T'

    return s
 endfunction

 function LabelingTab(n)
    let buflist = tabpagebuflist(a:n)
    let winnr = tabpagewinnr(a:n)
    let name = bufname(buflist[winnr - 1])

    if name == ''
        return '[New File]'
    endif

    return name
 endfunction

"syntax highlight
 syntax on
 syntax enable

"file explorer with netrw
function! ToggleVExplorer()
  if exists("t:expl_buf_num")
    let expl_win_num = bufwinnr(t:expl_buf_num)
    let cur_win_num = winnr()

    if expl_win_num != -1
      while expl_win_num != cur_win_num
        exec "wincmd w"
        let cur_win_num = winnr()
      endwhile

      close
    endif
    unlet t:expl_buf_num
  else
    Vexplore
    let t:expl_buf_num = bufnr("%")
  endif
endfunction

 let g:netrw_banner = 0
 let g:netrw_liststyle = 3
 let g:netrw_browse_split = 4
 let g:netrw_altv = 1
 let g:netrw_winsize = -28

 nnoremap <silent> <Leader>g :call ToggleVExplorer()<CR>

"customize statusline
"when encounter error keys not found in dictionary, input visual block in char
"insert mode

let g:currentmode={
    \ 'n'  : 'Normal',
    \ 'no' : 'Normal·Operator Pending',
    \ 'v'  : 'Visual',
    \ 'V'  : 'V·Line',
    \ '' : 'V·Block',
    \ 's'  : 'Select',
    \ 'S'  : 'S·Line',
    \ '' : 'S·Block',
    \ 'i'  : 'Insert',
    \ 'R'  : 'Replace',
    \ 'Rv' : 'V·Replace',
    \ 'c'  : 'Command',
    \ 'cv' : 'Vim Ex',
    \ 'ce' : 'Ex',
    \ 'r'  : 'Prompt',
    \ 'rm' : 'More',
    \ 'r?' : 'Confirm',
    \ '!'  : 'Shell',
    \ 't'  : 'Terminal'
    \}

 set noshowmode "do not show mode in command pane
 set laststatus=2 "always show status line
 set statusline=
 set statusline+=%#DiffAdd#       " colour
 set statusline+=\ %{toupper(g:currentmode[mode()])}%{'\ '}
 set statusline+=%#StatusLine#           " colour
 set statusline+=\ %n\               " buffer number
 set statusline+=%{&paste?'\ PASTE\ ':''}
 set statusline+=%{&spell?'\ SPELL\ ':''}
 set statusline+=%R                  " readonly flag
 set statusline+=\ %F\               " full path file name
 set statusline+=%M                  " modified [+] flag
 set statusline+=%=                  " right align
 set statusline+=\ %Y\               " file type
 set statusline+=\ %3l:%-2c\         " line + column
 set statusline+=\ %3p%%\            " percentage

"key mapping
 map <Space> <Leader>
 nnoremap <silent> <Leader><Space> :noh<CR>
 nnoremap <silent> <C-p> :Files<CR>

"language specific settings
 autocmd BufNewFile,BufRead *.go setlocal noexpandtab tabstop=2 shiftwidth=2 softtabstop=2
 autocmd BufNewFile,BufRead *.rb setlocal expandtab tabstop=2 shiftwidth=2 softtabstop=2
 autocmd BufNewFile,BufRead *.py setlocal expandtab tabstop=4 shiftwidth=4 softtabstop=4

"remove trailing whitespace on save
 autocmd BufWritePre * %s/\s\+$//e

 if exists('&fixeol')
   set nofixeol
 endif

 "keymap
 nmap <C-Up> :m -2<cr>
 nmap <C-Down> :m +1<cr>

 vmap <C-Up> :m '<-2<cr>gv=gv
 vmap <C-Down> :m '>+1<cr>gv=gv
