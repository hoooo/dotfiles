"---------------------------------------------------------------------
" ベースセッティング
"---------------------------------------------------------------------
set nocompatible
set number
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set backspace=indent,eol,start
set laststatus=2
set t_Co=256
set list
set listchars=tab:»\ ,trail:▸
set cursorline
highlight CursorLine term=reverse cterm=none ctermbg=238
set cursorcolumn
highlight CursorColumn term=reverse cterm=none ctermbg=238
set hlsearch
set showcmd
set whichwrap=b,s,h,s,<,>,[,]


highlight ZenkakuSpace cterm=underline ctermbg=red guibg=#666666
au BufWinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')
au WinEnter * let w:m3 = matchadd("ZenkakuSpace", '　')


filetype off

autocmd BufNewFile,BufRead *.fcgi set filetype=perl
autocmd BufNewFile,BufRead *.cgi set filetype=perl
autocmd BufNewFile,BufRead *.tmpl set filetype=html


if has('vim_starting')
    set runtimepath+=~/.vim/bundle/neobundle.vim/
    call neobundle#rc(expand('~/.vim/bundle/'))
endif


"------------------------
" 使うプラグイン指定
"------------------------
NeoBundle 'Shougo/neobundle.vim'
NeoBundle 'Shougo/neocomplcache'
NeoBundle 'Shougo/neosnippet'
NeoBundle 'thinca/vim-quickrun'
NeoBundle 'Shougo/vimfiler'
NeoBundle 'itchyny/lightline.vim'
NeoBundle 'tpope/vim-surround'
NeoBundle 'osyo-manga/vim-anzu'
NeoBundle 'Shougo/vimshell'
NeoBundle 'Shougo/vimproc'

NeoBundle 'VimClojure'
NeoBundle 'Shougo/unite.vim'
NeoBundle 'jpalardy/vim-slime'
NeoBundle 'scrooloose/syntastic'



filetype plugin indent on
filetype indent on
syntax on







"neocomplecacheを起動時に有効化
let g:neocomplcache_enable_at_startup = 1
"Use smartcase.
let g:neocomplcache_enable_smart_case=1
"Use camel case completion.
let g:neocomplcache_enable_camel_case_completion=1

"vimshellの設定
let g:vimshell_interactive_update_time = 10
let g:vimshell_prompt_expr = 'getcwd()." > "'
let g:vimshell_prompt_pattern = '^\f\+ > '

"Select with <TAB>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"

"Disable AutoComplPop.
let g:acp_enableAtStartup=0

"lightline設定
let g:lightline = {
            \ 'colorscheme': 'landscape',
            \ 'mode_map': {'c': 'NORMAL'},
            \ 'active': {
            \   'left': [
            \     ['mode', 'paste'],
            \     ['fugitive', 'filename', 'anzu'],
            \   ],
            \   'right': [
            \     ['lineinfo', 'syntastic'],
            \     ['percent'],
            \     ['charcode', 'fileformat', 'fileencoding', 'filetype'],
            \   ]
            \ },
            \ 'component_function': {
            \   'anzu': 'anzu#search_status',
            \   'modified': 'MyModified',
            \   'readonly': 'MyReadonly',
            \   'filename': 'MyFilename',
            \   'mode': 'MyMode',
            \ }
            \ }

function! MyModified()
  return &ft =~ 'help\|vimfiler\|gundo' ? '' : &modified ? '+' : &modifiable ? '' : '-'
endfunction

function! MyReadonly()
  return &ft !~? 'help\|vimfiler\|gundo' && &readonly ? 'RO' : ''
endfunction

function! MyFilename()
  return ('' != MyReadonly() ? MyReadonly() . ' ' : '') .
        \ (&ft == 'vimfiler' ? vimfiler#get_status_string() :
        \  &ft == 'unite' ? unite#get_status_string() :
        \  &ft == 'vimshell' ? vimshell#get_status_string() :
        \ '' != expand('%:p') ? expand('%:p') : '[No Name]') .
        \ ('' != MyModified() ? ' ' . MyModified() : '')
endfunction

function! MyMode()
  return winwidth('.') > 60 ? lightline#mode() : ''
endfunction


" vim-anzu関連
nmap n <Plug>(anzu-n)
nmap N <Plug>(anzu-N)
nmap * <Plug>(anzu-star)
nmap # <Plug>(anzu-sharp)
augroup vim-anzu
" 一定時間キー入力がないとき、ウインドウを移動したとき、タブを移動したときに
" 検索ヒット数の表示を消去する
    autocmd!
    autocmd CursorHold,CursorHoldI,WinLeave,TabLeave * call anzu#clear_search_status()
augroup END



"snippetのショートカットキー設定
imap <C-n> <Plug>(neosnippet_expand_or_jump)
smap <C-n> <Plug>(neosnippet_expand_or_jump)
" SuperTab like snippets behavior.
imap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : pumvisible() ? "\<C-n>" : "\<TAB>"
smap <expr><TAB> neosnippet#expandable() <Bar><bar> neosnippet#jumpable() ? "\<Plug>(neosnippet_expand_or_jump)" : "\<TAB>"
" For snippet_complete marker.
if has('conceal')
  set conceallevel=2 concealcursor=i
endif



"挿入モード時限定のショートカットキー設定
inoremap <C-d> <Del>
inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

inoremap <C-p> <ESC>p
inoremap <C-v> <ESC>v
inoremap <C-V> <ESC>V
inoremap <C-o> <ESC>o

inoremap {} {}<LEFT>
inoremap [] []<LEFT>
inoremap () ()<LEFT>
inoremap "" ""<LEFT>
inoremap '' ''<LEFT>
inoremap <> <><LEFT>




"ノーマルモード時限定のショートカットキー設定
nnoremap vsh :VimShell<CR>

nnoremap <C-e> :VimFiler -split<CR>
nnoremap <C-a> :Unite file<CR>

nnoremap <C-l> <End>
nnoremap <C-h> <Home>

nmap <Leader>r <Plug>(quickrun)






" 文字コードの自動認識
if &encoding !=# 'utf-8'
  set encoding=japan
  set fileencoding=japan
endif
if has('iconv')
  let s:enc_euc = 'euc-jp'
  let s:enc_jis = 'iso-2022-jp'
  " iconvがeucJP-msに対応しているかをチェック
  if iconv("\x87\x64\x87\x6a", 'cp932', 'eucjp-ms') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'eucjp-ms'
    let s:enc_jis = 'iso-2022-jp-3'
  " iconvがJISX0213に対応しているかをチェック
  elseif iconv("\x87\x64\x87\x6a", 'cp932', 'euc-jisx0213') ==# "\xad\xc5\xad\xcb"
    let s:enc_euc = 'euc-jisx0213'
    let s:enc_jis = 'iso-2022-jp-3'
  endif
  " fileencodingsを構築
  if &encoding ==# 'utf-8'
    let s:fileencodings_default = &fileencodings
    let &fileencodings = s:enc_jis .','. s:enc_euc .',cp932'
    let &fileencodings = &fileencodings .','. s:fileencodings_default
    unlet s:fileencodings_default
  else
    let &fileencodings = &fileencodings .','. s:enc_jis
    set fileencodings+=utf-8,ucs-2le,ucs-2
    if &encoding =~# '^\(euc-jp\|euc-jisx0213\|eucjp-ms\)$'
      set fileencodings+=cp932
      set fileencodings-=euc-jp
      set fileencodings-=euc-jisx0213
      set fileencodings-=eucjp-ms
      let &encoding = s:enc_euc
      let &fileencoding = s:enc_euc
    else
      let &fileencodings = &fileencodings .','. s:enc_euc
    endif
  endif
  " 定数を処分
  unlet s:enc_euc
  unlet s:enc_jis
endif
" 日本語を含まない場合は fileencoding に encoding を使うようにする
if has('autocmd')
  function! AU_ReCheck_FENC()
    if &fileencoding =~# 'iso-2022-jp' && search("[^\x01-\x7e]", 'n') == 0
      let &fileencoding=&encoding
    endif
  endfunction
  autocmd BufReadPost * call AU_ReCheck_FENC()
endif
" 改行コードの自動認識
set fileformats=unix,dos,mac
" □とか○の文字があってもカーソル位置がずれないようにする
if exists('&ambiwidth')
  set ambiwidth=double
endif

