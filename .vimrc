set ts=4
set nu
syntax on
set backspace=2

set nocompatible               " be iMproved
filetype off                   " required!
"colorscheme torte
set rtp+=~/.vim/bundle/vundle/

if &term == "xterm-color" || &term == "xterm-16color"
    set t_Co=16
elseif ! has("gui_running")
    set t_Co=256
endif

" for GVim
if has("gui_running")
    set guioptions-=T
    colorscheme wombat
    set gfn=Consolas:h14
else
    "For Colorscheme
    set bg=dark
    colorscheme peaksea_new
    "colorscheme ir_black_cterm
    "colorscheme torte
endif

" Status Line
set laststatus=2
"set statusline=%<%f\ %m%=\ %h%r\ %-19([%p%%]\ %3l,%02c%03V%)%y
set statusline=File:\ %t\%r%h%w\ [%{&ff},%{&fileencoding},%Y]\ %m%=\ [AscII=\%03.3b]\ [Hex=\%02.2B]\ [Pos=%l,%v,%p%%]\ [LINE=%L]

set noswapfile
set hlsearch
set showmatch
set number

set autoindent     " Auto Indent
set smartindent    " Smart Indent
set cindent        " C-style Indent

set smarttab       " Smart handling of the tab key
set shiftround     " Round indent to multiple of shiftwidth
set shiftwidth=4   " Number of spaces for each indent
set tabstop=4      " Number of spaces for tab key
set softtabstop=4  " Number of spaces for tab key while performing editing operations
"set expandtab     " Use spaces for tabs.

set history=1000   " keep 1000 lines of command line history
set ruler          " show the cursor position all the time
set showcmd        " display incomplete commands
set incsearch      " do incremental searching

set lazyredraw     " Do not redraw while running macros (much faster) (LazyRedraw)

set foldmethod=indent
set foldlevel=1000
set foldnestmax=5

" {{{ file encoding setting
set fileencodings=utf-8,big5,euc-jp,gbk,euc-kr,utf-bom,iso8859-1
set termencoding=utf-8
set enc=utf-8
set tenc=utf8
set fenc=utf-8
" }}}

" For ambiguous characters, ex: and BBS XD
set ambiwidth=single

" Favorite file types
set ffs=unix,dos,mac

"tab function hotkey
nmap tl :tabnext<CR>
nmap th :tabprev<CR>
nmap tn :tabnew<CR>
nmap tc :tabclose<CR>
nmap <SPACE> :noh<CR>
nmap ff :FufFile<CR>
nmap ft :FufTag<CR>

filetype plugin indent on     " required!
set completeopt=longest,menu,menuone
set wildmenu
"in ESC: (command mode), disbled auto completion next part, Cool!
set wildmode=list:longest
set wildignore+=*.o,*.a,*.so,*.obj,*.exe,*.lib,*.ncb,*.opt,*.plg,.svn,.git

" for :TOhtml
"let html_use_css=1
"let use_xhtml = 1
let html_number_lines = 1
let html_no_pre = 1
let html_ignore_folding = 1

set scrolloff=10
set sidescrolloff=10
set ignorecase
set smartcase

"show CursorLine
set cursorline

set backspace=indent,eol,start  " Allow backspacing over these

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [ Bundle configuration ]                                                   {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    
call vundle#rc()

" let Vundle manage Vundle
" required! 
Bundle 'gmarik/vundle'

" My Bundles here:
"
" original repos on github
Bundle 'tpope/vim-fugitive'
Bundle 'Lokaltog/vim-easymotion'
Bundle 'rstacruz/sparkup', {'rtp': 'vim/'}
Bundle 'tpope/vim-rails.git'
Bundle 'scrooloose/syntastic'
" Bundle 'YouCompleteMe'
" vim-scripts repos
Bundle 'L9'
Bundle 'FuzzyFinder'
Bundle 'taglist.vim'
" non github repos
" Bundle 'git://git.wincent.com/command-t.git'
" git repos on your local machine (ie. when working on your own plugin)
" Bundle 'file:///Users/gmarik/path/to/plugin'
" ...

"
" Brief help
" :BundleList          - list configured bundles
" :BundleInstall(!)    - install(update) bundles
" :BundleSearch(!) foo - search(or refresh cache first) for foo
" :BundleClean(!)      - confirm(or auto-approve) removal of unused bundles
"
" see :h vundle for more details or wiki for FAQ
" NOTE: comments after Bundle command are not allowed..

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [ Tab Operation Mac-Mapping by Klaymen ]                                   {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

"Tab Highlight color
hi TabLine     ctermfg=fg   ctermbg=28   cterm=underline
hi TabLineFill ctermfg=fg   ctermbg=28   cterm=underline
hi TabLineSel  ctermfg=fg   ctermbg=NONE cterm=NONE
hi Title       ctermfg=219  ctermbg=NONE cterm=NONE

autocmd TabLeave * let g:LastUsedTabPage = tabpagenr()
function! SwitchLastUsedTab()
    if exists("g:LastUsedTabPage")
        execute "tabnext " g:LastUsedTabPage
    endif
endfunction
nmap tt :call SwitchLastUsedTab()<CR>

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [ Programming Language ]                                                   {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
    
    """"""""""""""""""""""""""""""
    " ctags
    """"""""""""""""""""""""""""""
    " Set tags path
    set tags=tags,../tags,../../tags,../../../tags,../../../../tags

    """"""""""""""""""""""""""""""
    " cscope
    """"""""""""""""""""""""""""""
    " init cscope hotkey
    function! UseAwesomeCscope()
        try
            set tags+=/home/kent/horus/apps/tags
            exe "cs add ../cscope.out .."
            exe "cs add /home/kent/cscope_ctag/Horus/cscope.out /home/kent/Project/Horus/apps"
        catch /duplicate/
                silent exe "!tag_rebuild .."
                silent exe "cs reset"
                exe "redraw!"
                echohl Wildmenu | echo "cscope database inuse, update and re-init all connections" | echohl None
        catch /stat/
            silent exe "!tag_rebuild .."
            try
                exe "cs add ../cscope.out .."
                exe "cs add /home/kent/cscope_ctag/Horus/cscope.out /home/kent/Project/Horus/apps"
                exe "redraw!"
                echohl Wildmenu | echo "cscope file not found, exec tag_rebuild" | echohl None
            catch
                exe "redraw!"
                echohl ErrorMsg | echo "You don't have enough privilege XD" | echohl None
            endtry
        endtry
    endfun
    nnoremap <F11> <ESC>:call UseAwesomeCscope()<CR>

    " [Web Dev] Gernerate tags file for *.js only!
    nnoremap <F11>w <ESC>:!tag_rebuild ..<CR><ESC>:redraw!<CR>

    " To avoid using wrong cscope(/opt/montavista/pro5.0/bin/cscope) once sourcing devel_IP8161_VVTK
    if match(system('ls ~/usr/bin/cscope'), 'cscope') != -1
        set cscopeprg=~/usr/bin/cscope
    endif

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [ Plugin configuration ]                                                   {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""

    """"""""""""""""""""""""""""""
    " Tag List
    """"""""""""""""""""""""""""""
    nmap <F12>   :TlistToggle<CR>
	map > <C-w>><C-w>
	map < <C-w><<C-w>

    " Split to the right side of the screen
    let g:Tlist_Use_Right_Window = 1
    " Sort by the order
    let g:Tlist_Sort_Type = "order"
    " If you are the last, kill yourself
    let g:Tlist_Exit_OnlyWindow = 1
    " Do not show folding tree
    let g:Tlist_Enable_Fold_Column = 0
    " Always display one file tags
    let g:Tlist_Show_One_File = 1

    """"""""""""""""""""""""""""""
    " YouCompleteMe
    """"""""""""""""""""""""""""""
    "let g:ycm_global_ycm_extra_conf = '~/.vim/bundle/YouCompleteMe/.ycm_extra_conf.py'
    "nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>

" }}}

""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" [ Functions & autocmd ]                                                    {{{
""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""""
" set vim to chdir for each file
if exists('+autochdir')
    set autochdir
else
    autocmd BufEnter * silent! lcd %:p:h:gs/ /\\ /
endif
" Automatically update 'Last Modified' field
" If buffer modified, update any 'Last modified: ' in the first 20 lines.
function! LastModified()
  if &modified
    normal ms
    let n = min([20, line("$")])
    exe '1,' . n . 's#^\(.\{,10}Last Modified: \).*#\1' .
          \ strftime('%a %b %d, %Y  %I:%M%p') . '#e'
    normal `s
  endif
endfun
autocmd BufWritePre * call LastModified()

" Remember the line number been edited last time
"if has("autocmd")
    "autocmd BufRead *.txt set tw=78
    "autocmd BufReadPost *
       "\ if line("'\"") > 0 && line ("'\"") <= line("$") |
       "\   exe "normal g'\"" |
       "\ endif
"endif

"autocmd BufWinLeave * if expand("%") != "" | mkview | endif
"autocmd BufWinEnter * if expand("%") != "" | loadview | endif
"Restore cursor to file position in previous editing session
autocmd BufReadPost * if line ("'\"") > 0 && line ("'\"") <= line("$") | exe "normal g'\"" | endif


" QUICKFIX WINDOW for :make
command -bang -nargs=? QFix call QFixToggle(<bang>0)
function! QFixToggle(forced)
    if exists("g:qfix_win") && a:forced == 0
        cclose
        unlet g:qfix_win
    else
        botright copen 10
        let g:qfix_win = bufnr("$")
    endif
endfunction
nnoremap <leader>q :QFix<CR>

" Remove unnecessary spaces in the end of line
"autocmd FileType c,cpp,perl,python,sh,html,js autocmd FileWritePre,BufWritePre <buffer> :call setline(1,map(getline(1,"$"),'substitute(v:val,"\\s\\+$","","")'))

" [Highlight column matching { } pattern], A very cool stuff(Kent)
"let s:hlflag=0
"function! ColumnHighlight()
"   let c=getline(line('.'))[col('.') - 1]
"   if c=='{' || c=='}'
"       set cuc
"       let s:hlflag=1
"   else
"       if s:hlflag==1
"           set nocuc
"           let s:hlflag=0
"       endif
"   endif
"endfunction
"
"autocmd CursorMoved * call ColumnHighlight()

" Vim Eval snippet by c9s
fun! EvalVimScriptRegion(s,e)
    let lines = getline(a:s,a:e)
    let file = tempname()
    cal writefile(lines,file)
    silent exec ':source '.file
    redraw
    cal delete(file)
    echo "Region evaluated."
    sleep 500m
    "normal gv
endf
augroup VimEval
    au!
    au filetype vim :command! -range Eval :cal EvalVimScriptRegion(<line1>,<line2>)
    au filetype vim :vnoremap <silent> e :Eval<CR>
augroup END

set foldtext=MyFoldText()
function! MyFoldText()
    let lines = 1 + v:foldend - v:foldstart
    let ind = indent(v:foldstart)

    let spaces = ''
    let i = 0
    while i < ind
        let spaces .= ' '
        let i += 1
    endwhile

    let linestxt = 'lines'
    if lines == 1
        linestxt = 'line'
    endif

    let firstline = getline(v:foldstart)
    let line = firstline[ind : ind+80]

    return spaces . '+' . v:folddashes . ' ' . lines . ' ' . linestxt . ': ' . line . ' '
endfunction

" Highlight long lines
nnoremap <silent> <Leader>l
      \ :if exists('w:long_line_match') <Bar>
      \   silent! call matchdelete(w:long_line_match) <Bar>
      \   unlet w:long_line_match <Bar>
      \ elseif &textwidth > 0 <Bar>
      \   let w:long_line_match = matchadd('ErrorMsg', '\%>'.&tw.'v.\+', -1) <Bar>
      \ else <Bar>
      \   let w:long_line_match = matchadd('ErrorMsg', '\%<81v.\%>77v', -1) <Bar>
      \ endif<CR>

" trigger by :call HtmlEscape()
function HtmlEscape()
    silent s/&/\&amp;/eg
    silent s/</\&lt;/eg
    silent s/>/\&gt;/eg
    silent s/"/\&quot;/eg
endfunction

" trigger by :call HtmlUnEscape()
function HtmlUnEscape()
    silent s/&lt;/</eg
    silent s/&gt;/>/eg
    silent s/&amp;/\&/eg
    silent s/&quot;/"/eg
endfunction

" }}}
