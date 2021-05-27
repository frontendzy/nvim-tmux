set nocompatible
filetype on
filetype indent on
filetype plugin on
filetype plugin indent on
set encoding=utf-8
let &t_ut=''
set cursorline
set number
set laststatus=2
set noeb
syntax enable
set nobackup
set tabstop=2
set scrolloff=20
set softtabstop=2
set shiftwidth=2
set mouse -=a
" set list
" set listchars=tab:▸\ ,trail:▫
set norelativenumber
set ttimeout
set ttimeoutlen=100
set relativenumber
set nowrap
set wildmenu
set updatetime=100
set laststatus=2
set guicursor=i:hor100-ncvCursor
" 记录上一次编辑的位置
if has("autocmd")  
au BufReadPost * if line("'\"") > 1 && line("'\"") <= line("$") | exe "normal! g'\"" | endif  
endif 
" 快捷键设置
nmap <C-t> :NERDTreeToggle<CR>
map <space>v "+p<CR>
map <space>c "+y<CR>
map W :w<CR>
map Q :q<CR>
map R :source ~/.config/nvim/init.vim<CR>

" 插件安装
call plug#begin('~/.config/nvim/plugged')
Plug 'scrooloose/nerdtree', { 'on':  'NERDTreeToggle' }
Plug 'jiangmiao/auto-pairs'
Plug 'vim-airline/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'mhinz/vim-startify'
Plug 'kaicataldo/material.vim', { 'branch': 'main' }
Plug 'yuezk/vim-js'
Plug 'chemzqm/vim-jsx-improve'
Plug 'mg979/vim-visual-multi', {'branch': 'master'}
Plug 'posva/vim-vue'
Plug 'pangloss/vim-javascript'
Plug 'MaxMEllon/vim-jsx-pretty'
Plug 'tbodt/deoplete-tabnine', { 'do': './install.sh' }
Plug 'Yggdroot/indentLine' 
Plug 'mattn/emmet-vim' 
Plug 'iamcco/markdown-preview.nvim', { 'do': { -> mkdp#util#install() }, 'for' :['markdown', 'vim-plug'] }
Plug 'chr4/nginx.vim'
Plug 'neoclide/coc.nvim', {'branch': 'release'}  
Plug 'voldikss/vim-translator'
" Plug 'junegunn/fzf.vim'
call plug#end()
" 背景透明
autocmd vimenter * hi Normal guibg=NONE ctermbg=NONE " transparent bg
" 主题设置
colorscheme material

" emmet配置
let g:user_emmet_install_global = 0 " 取消全局作用
autocmd FileType html,css,js,vue,jsx EmmetInstall " 仅对前端的几个类型的文件起作用
let g:user_emmet_leader_key='<C-Y>' " emmet的热键

let g:material_theme_style = 'default'

" tab 标线设置
 let g:indentLine_color_term = 243 " 对齐线的颜色
 let g:indentLine_char = '┊' " 用字符串代替默认的标示线


" 热键 + m 打开markdown文件预览
autocmd Filetype markdown map <LEADER>m :MarkdownPreview <CR>

" 彩色括号
let g:rbpt_colorpairs = [
    \ ['brown',       'RoyalBlue3'],
    \ ['Darkblue',    'SeaGreen3'],
    \ ['darkgray',    'DarkOrchid3'],
    \ ['darkgreen',   'firebrick3'],
    \ ['darkcyan',    'RoyalBlue3'],
    \ ['darkred',     'SeaGreen3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['brown',       'firebrick3'],
    \ ['gray',        'RoyalBlue3'],
    \ ['darkmagenta', 'DarkOrchid3'],
    \ ['Darkblue',    'firebrick3'],
    \ ['darkgreen',   'RoyalBlue3'],
    \ ['darkcyan',    'SeaGreen3'],
    \ ['darkred',     'DarkOrchid3'],
    \ ['red',         'firebrick3'],
    \ ]

let g:vue_pre_processors = ['scss', 'sass', 'JavaScript', 'Css', 'less']
if (has('nvim'))
  let $NVIM_TUI_ENABLE_TRUE_COLOR = 1
endif

if (has('termguicolors'))
  set termguicolors
endif
let g:javascript_plugin_jsdoc = 1
let g:vim_jsx_pretty_colorful_config = 1

" coc
let g:coc_global_extensions = ['coc-json', 'coc-html', 'coc-tsserver']

" ctrl + b 跳转到函数，并在新的tab页面中打开
nmap <silent> <C-b> :call CocAction('jumpDefinition', 'tab drop')<CR>

" 设置按下tab时，是选择补全，而不是输入tab
inoremap <silent><expr> <TAB>
      \ pumvisible() ? "\<C-n>" :
      \ <SID>check_back_space() ? "\<TAB>" :
      \ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
  let col = col('.') - 1
  return !col || getline('.')[col - 1]  =~# '\s'
endfunction

" 回车选中补全，而不是换行
if exists('*complete_info')
  inoremap <expr> <cr> complete_info()["selected"] != "-1" ? "\<C-y>" : "\<C-g>u\<CR>"
else           
  inoremap <expr> <cr> pumvisible() ? "\<C-y>" : "\<C-g>u\<CR>" 
endif

nmap <Leader>t :TranslateW<CR>
nmap <Leader>m :TranslateWV<CR>

" 取消高亮括号
let loaded_matchparen=1
" 光标样式
highlight iCursor guifg=red guibg=steelblue


let &t_SI = "\<Esc>]50;CursorShape=1\x7"
let &t_SR = "\<Esc>]50;CursorShape=2\x7"
let &t_EI = "\<Esc>]50;CursorShape=0\x7"


" 自动添加文件头
autocmd BufNewFile *.js,*.md exec ":call SetComment()"
func SetComment()
        call setline(1,"/*================================================================")
        call append(line("."),   "*   Copyright (C) ".strftime("%Y")." IEucd Inc. All rights reserved.")
        call append(line(".")+1, "*   ")
        call append(line(".")+2, "*   文件名称：".expand("%:t"))
        call append(line(".")+3, "*   创 建 者：ZY")
        call append(line(".")+4, "*   创建日期：".strftime("%Y年%m月%d日"))
        call append(line(".")+5, "*   描    述：")
        call append(line(".")+6, "*")
        call append(line(".")+7, "================================================================*/")
        call append(line(".")+8, "")
        call append(line(".")+9, "")
endfunc
