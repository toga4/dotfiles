syntax enable
colorscheme anderson

set termguicolors
" $TERMがxterm以外のときは以下を設定する必要がある。
let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum" " 文字色
let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum" " 背景色

" 入力系
set autoindent      " 自動でインデント
set smartindent     " 次の行を同じインデントで始める
set expandtab       " Tabをスペースに変換
set shiftwidth=4    " Tabをスペース4つ分に変換

" 表示系
set number          " 行番号
set cursorline      " 現在行をハイライト
"set cursorcolumn    " 現在列をハイライト
set list            " 不可視文字を表示
set listchars=tab:>-,trail:-,nbsp:%,extends:>,precedes:<,eol:< " 不可視文字の表示形式
set tabstop=4       " Tabの表示幅はスペース4つ分
set nowrap          " 長い行を折り返さない
set ruler           " いま位置をステータスに表示
set showmode        " 現在のモードを表示
set showcmd         " 入力中のコマンドをステータスに表示する
set visualbell      " beep音を可視化

" 検索系
set incsearch       " インクリメンタルサーチ
set hlsearch        " 検索文字をハイライト
set nowrapscan      " 最後まで検索したあと先頭に戻って検索しない
set ignorecase      " 大文字小文字無視
set smartcase       " 検索文字に大文字があったら区別する

" その他
set hidden          " 編集中でも他のファイルを開けるようにする
set whichwrap=h,l,b,s,<,>,[,]  " 行頭/行末でもカーソルを止めない
set history=2000    " コマンド履歴数
set noswapfile      " スワップファイルを作らない
set backspace=indent,eol,start  " バックスペースでなんでも消せる
set autoread        " 他で書き換えられたら自動で再読み込み

" 現在行ハイライトの色指定
highlight clear CursorLine
highlight CursorLine ctermbg=Black

" バックアップファイル
set backupdir=~/.vim/tmp
set undodir=~/.vim/undo
set viminfo+=n~/.vim/viminfo

" キーバインド
noremap <M-Left>  b
noremap <M-Right> w
noremap <ESC><ESC>^D b
noremap <ESC><ESC>^C w
