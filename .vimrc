"---------------------------------------------------------------------
" ベースセッティング
"---------------------------------------------------------------------
set nocompatible 
set number
set expandtab
set tabstop=4
set shiftwidth=4
set softtabstop=4
set cursorline
"highlight cursorline term=reverse cterm=reverse
set autoread
set backspace=indent,eol,start


autocmd BufNewFile,BufRead *.fcgi set filetype=perl
autocmd BufNewFile,BufRead *.cgi set filetype=perl
autocmd BufNewFile,BufRead *.tmpl set filetype=html

syntax on


filetype plugin indent on

"------------------------
" Vundleを使うための設定
"------------------------
set rtp+=~/.vim/vundle/
call vundle#rc('~/.vim/bundle')


"------------------------
" 使うプラグイン指定
"------------------------
Bundle 'Shougo/neocomplcache'
Bundle 'Shougo/neosnippet'
Bundle 'petdance/vim-perl'
Bundle 'hotchpotch/perldoc-vim'
Bundle 'thinca/vim-quickrun'
Bundle 'The-NERD-tree'
Bundle 'The-NERD-Commenter'
Bundle 'tpope/vim-surround'
Bundle 'sudo.vim'


"neocomplecacheを起動時に有効化
let g:neocomplcache_enable_at_startup = 1
"Disable AutoComplPop.
let g:acp_enableAtStartup=0
"Use smartcase.
let g:neocomplcache_enable_smart_case=1
"Use camel case completion.
let g:neocomplcache_enable_camel_case_completion=1
"Select with <TAB>
inoremap <expr><TAB> pumvisible() ? "\<C-n>" : "\<TAB>"


"NERDtreeで隠しファイルを表示
let g:NERDTreeShowHidden=1

"snippetsパス指定
let g:neocomplacache_snippets_dir="~/.vim/snippets"





"snippetのショートカットキー設定
imap <C-n> <Plug>(neosnippet_expand_or_jump)
smap <C-n> <Plug>(neosnippet_expand_or_jump)



"挿入モード時限定のショートカットキー設定
inoremap <C-g> <Home>
inoremap <C-e> <End> 
inoremap <C-d> <Del>

inoremap <C-h> <Left>
inoremap <C-j> <Down>
inoremap <C-k> <Up>
inoremap <C-l> <Right>

inoremap <Leader>k <ESC>d$i
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
nnoremap <C-e> :NERDTreeToggle<CR>
nnoremap <silent> <C-x>1 :only<CR>
nnoremap <silent> <C-x>2 :sp<CR>
nnoremap <silent> <C-x>3 :vsp<CR>

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
