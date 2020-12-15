filetype plugin indent on
set number
set tabstop=4
set shiftwidth=4
set expandtab
set cursorline
set cursorcolumn
set encoding=UTF-8
set modifiable

call plug#begin()
Plug 'scrooloose/nerdtree'
Plug 'xuyuanp/nerdtree-git-plugin'
Plug 'ryanoasis/vim-devicons'
Plug 'tiagofumo/vim-nerdtree-syntax-highlight'
Plug 'octol/vim-cpp-enhanced-highlight'
Plug 'neoclide/coc.nvim', {'branch': 'release'}
Plug 'honza/vim-snippets'
Plug 'SirVer/ultisnips'
Plug 'dart-lang/dart-vim-plugin'
Plug 'uiiaoo/java-syntax.vim'
Plug 'bling/vim-airline'
Plug 'vim-airline/vim-airline-themes'
Plug 'NLKNguyen/papercolor-theme'
Plug 'iamcco/markdown-preview.vim'
Plug 'tpope/vim-fugitive'
Plug 'iamcco/markdown-preview.vim'
call plug#end()

set background=dark
colorscheme PaperColor

"Keyboard Shortcut
source ~/.config/nvim/key.vim

"NERDTree Config
map <C-@> :NERDTreeToggle<CR>
autocmd StdinReadPre * let s:std_in=1
autocmd VimEnter * if argc() == 1 && isdirectory(argv()[0]) && !exists("s:std_in") | exe 'NERDTree' argv()[0] | wincmd p | ene | exe 'cd '.argv()[0] | endif

"NERDTree GIT Config
let g:NERDTreeGitStatusIndicatorMapCustom = {
                \ 'Modified'  :'✹',
                \ 'Staged'    :'✚',
                \ 'Untracked' :'✭',
                \ 'Renamed'   :'➜',
                \ 'Unmerged'  :'═',
                \ 'Deleted'   :'✖',
                \ 'Dirty'     :'✗',
								\ 'Ignored'   :'☒',
                \ 'Clean'     :'✔︎',
                \ 'Unknown'   :'?',
                \ }
let g:NERDTreeGitStatusUseNerdFonts = 1
let g:NERDTreeGitStatusUntrackedFilesMode = 'all'
let g:NERDTreeGitStatusShowClean = 1
let g:NERDTreeGitStatusConcealBrackets = 1

augroup ProgrammingLanguageSettings
    "the command below execute the script for the specific filetype C
    autocmd FileType c source ~/.config/nvim/language/c.vim

    "the command below execute the script for the specific filetype Java
    autocmd FileType java source ~/.config/nvim/language/java.vim
augroup END

"Vim CPP Highlight Config
let g:cpp_class_scope_highlight = 1
let g:cpp_member_variable_highlight = 1
let g:cpp_class_decl_highlight = 1
let g:cpp_posix_standard = 1

"Vim AirLine Config
let g:airline_theme='wombat'

