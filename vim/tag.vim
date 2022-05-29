" 配置vim-gutentags
" 设置tags
" ./.tags; 代表从当前文件所在目录下查找名字为.tags的符号文件,
" 其中的;表示找不到则向上一级目录递归寻找
" .tags表示指在当前目录下寻找.tags文件
" set tags=./.tags;,.tags

let $GTAGSLABEL='native-pygments'
let $GTAGSCONF='/usr/local/share/gtags/gtags.conf'

let g:gutentags_define_advanced_commands=1 
" gutentags 搜索工程目录的标志，当前文件路径向上递归直到碰到这些文件/目录名
let g:gutentags_project_root = ['.root', '.svn', '.git', '.hg', '.project']

" 所生成的数据文件的名称
let g:gutentags_ctags_tagfile = '.tags' "
" 指定生成的tag文件名称附加到项目的根目录, 这里没有用到

" 同时开启 ctags 和 gtags 支持：
let g:gutentags_modules = []
if executable('gtags-cscope') && executable('gtags')
        let g:gutentags_modules += ['gtags_cscope']
endif

" 将自动生成的 ctags/gtags 文件全部放入 ~/.cache/tags 目录中，避免污染工程目录
let s:vim_tags = expand('~/.cache/tags')
let g:gutentags_cache_dir = s:vim_tags

" 检测~/.cache/tags文件夹是否存在不存在则新建
if !isdirectory(s:vim_tags)
        silent! call mkdir(s:vim_tags, 'p')
endif

" 配置 ctags 的参数，老的 Exuberant-ctags 不能有 --extra=+q，注意
let g:gutentags_ctags_extra_args = ['--fields=+niazS', '--extra=+q']
let g:gutentags_ctags_extra_args += ['--c++-kinds=+px']
let g:gutentags_ctags_extra_args += ['--c-kinds=+px']

" 如果使用 universal ctags 需要增加下面一行，老的 Exuberant-ctags 不能加下一行
let g:gutentags_ctags_extra_args += ['--output-format=e-ctags']

" 禁用 gutentags 自动加载 gtags 数据库的行为
let g:gutentags_auto_add_gtags_cscope = 0
let g:gutentags_plus_switch = 1 " 搜索后将焦点更改为快速可恢复窗口

" 设置cscope使用gtags-cscope
set cscopetag " 设置cscope使用gtags
set cscopeprg='/usr/local/bin/gtags-cscope'
set csverb
