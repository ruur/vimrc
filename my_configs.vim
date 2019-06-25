" Shows line numbers
set number relativenumber

" tab 操作
map <leader>th :tabfirst<cr>
map <leader>tl :tablast<cr>

map <C-n> :tabnext<cr>
map <leader>tk :tabprev<cr>
map <leader>tn :tabnext<cr>
map <leader>tp :tabprev<cr>

map <leader>te :tabedit<cr>
map <leader>td :tabclose<cr>
map <leader>tm :tabm<cr>

" 新建tab  Ctrl+t
nnoremap <C-t>     :tabnew<CR>
inoremap <C-t>     <Esc>:tabnew<CR>

" normal模式下切换到确切的tab
noremap <leader>1 1gt
noremap <leader>2 2gt
noremap <leader>3 3gt
noremap <leader>4 4gt
noremap <leader>5 5gt
noremap <leader>6 6gt
noremap <leader>7 7gt
noremap <leader>8 8gt
noremap <leader>9 9gt
noremap <leader>0 :tablast<cr>

" Toggles between the active and last active tab "
" The first tab is always 1 "
let g:last_active_tab = 1

nnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
vnoremap <silent> <leader>tt :execute 'tabnext ' . g:last_active_tab<cr>
autocmd TabLeave * let g:last_active_tab = tabpagenr()

"==========================================
" FileType Settings  文件类型设置
"==========================================

autocmd FileType python set tabstop=4 shiftwidth=4 expandtab ai
autocmd FileType ruby set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType html,wxml set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType css,styl,wxss set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai
autocmd FileType javascript set tabstop=2 shiftwidth=2 softtabstop=2 expandtab ai

" 关闭方向键, 强迫自己用 hjkl
map <Left> <Nop>
map <Right> <Nop>
map <Up> <Nop>
map <Down> <Nop>

" F4 换行开关
nnoremap <F4> :set wrap! wrap?<CR>

" 取消markdown 代码折叠
let g:vim_markdown_folding_disabled = 1

" 代码自动补全
let g:ycm_key_list_select_completion = ['<Down>']
let g:ycm_key_list_previous_completion = ['<Up>']
let g:ycm_complete_in_comments = 1  "在注释输入中也能补全
let g:ycm_complete_in_strings = 1   "在字符串输入中也能补全

" 跳转到定义处, 分屏打开
let g:ycm_goto_buffer_command = 'horizontal-split'
nnoremap <leader>jd :YcmCompleter GoToDefinitionElseDeclaration<CR>
nnoremap <leader>gd :YcmCompleter GoToDeclaration<CR>

" 让复制粘贴格式不会错乱
function! WrapForTmux(s)
  if !exists('$TMUX')
    return a:s
  endif

  let tmux_start = "\<Esc>Ptmux;"
  let tmux_end = "\<Esc>\\"

  return tmux_start . substitute(a:s, "\<Esc>", "\<Esc>\<Esc>", 'g') . tmux_end
endfunction

let &t_SI .= WrapForTmux("\<Esc>[?2004h")
let &t_EI .= WrapForTmux("\<Esc>[?2004l")

function! XTermPasteBegin()
  set pastetoggle=<Esc>[201~
  set paste
  return "
endfunction

inoremap <special> <expr> <Esc>[200~ XTermPasteBegin()]"]])]")

" remap U to <C-r> for easier redo
nnoremap U <C-r>

" Prettier Config
" max line length that prettier will wrap on
" Prettier default: 80
let g:prettier#config#print_width = 80
" number of spaces per indentation level
" Prettier default: 2
let g:prettier#config#tab_width = 2
" use tabs over spaces
" Prettier default: false
let g:prettier#config#use_tabs = 'false'
" print semicolons
" Prettier default: true
let g:prettier#config#semi = 'true'
" single quotes over double quotes
" Prettier default: false
let g:prettier#config#single_quote = 'true'
" print spaces between brackets
" Prettier default: true
let g:prettier#config#bracket_spacing = 'true'
" put > on the last line instead of new line
" Prettier default: false
let g:prettier#config#jsx_bracket_same_line = 'false'
" avoid|always
" Prettier default: avoid
let g:prettier#config#arrow_parens = 'avoid'
" none|es5|all
" Prettier default: none
let g:prettier#config#trailing_comma = 'es5'
" flow|babylon|typescript|css|less|scss|json|graphql|markdown
" Prettier default: babylon
let g:prettier#config#parser = 'babylon'
" cli-override|file-override|prefer-file
let g:prettier#config#config_precedence = 'prefer-file'
" always|never|preserve
let g:prettier#config#prose_wrap = 'preserve'

" rust 文件用 rustfmt 格式化，其他的用 prettier
autocmd FileType javascript,typescript,json,markdown,css,less,sass,scss,html,yaml map <leader>p <Plug>(Prettier)
autocmd FileType rust map <leader>p :RustFmt<CR>
autocmd FileType go map <leader>p :GoFmt<CR>

:vnoremap <C-c> "+y
:vnoremap <C-x> "+d

au FileType rust nmap gs <Plug>(rust-def-split)
au FileType rust nmap <leader>gd <Plug>(rust-doc)
