set nocompatible					"Always use vim instead of vi.
syntax enable
set autowriteall					"Always save files when switching buffers.

"-----General Settings------"
set backspace=indent,eol,start  	"Make backspaces work.
let mapleader = ','					"Change the default leader to a comma.
set encoding=utf-8                  "Standard encoding
set number relativenumber           "Hybrid line numbers

"Tabsettings
set tabstop=4
set expandtab                       "Use spaces
set softtabstop=4
set shiftwidth=4
set clipboard=unnamed

"------Plugins-----"
" Specify a directory for plugins
" - Avoid using standard Vim directory names like 'plugin'
call plug#begin($HOME . '/.config/nvim/plugged')

Plug 'w0rp/ale'                        " Async Tool for adding linters,checking,..
Plug 'mileszs/ack.vim'
Plug 'morhetz/gruvbox'                 " Theme
Plug 'tpope/vim-vinegar'               " Smart project-tree navigation
Plug 'tpope/vim-fugitive'              " Git tooling inside vim
Plug 'tpope/vim-commentary'            " Comment blocks/lines can add filetypes
Plug 'tpope/vim-surround'              " Smart surrounding of tags/characters
Plug 'scrooloose/nerdtree'             " Visual project tree
Plug 'vim-airline/vim-airline'         " Status bar pluggable with plugins
Plug 'vim-airline/vim-airline-themes'  " Extra themes for status bar
Plug 'airblade/vim-gitgutter'
Plug 'stephpy/vim-php-cs-fixer'
Plug 'ludovicchabant/vim-gutentags'
Plug 'sheerun/vim-polyglot'
Plug 'tobyS/vmustache'
Plug 'tobyS/pdv'
Plug 'SirVer/ultisnips'
Plug 'ervandew/supertab'
Plug '/usr/local/opt/fzf'               " Reference to homebrew fzf install
Plug 'junegunn/fzf.vim'                 " FZF vim wrapper 
Plug 'phpactor/phpactor', {'for': 'php', 'do': 'composer install'} " PHP refactoring and introspection
Plug 'kristijanhusak/deoplete-phpactor' " PHP Deoplete source'
Plug 'mattn/emmet-vim'                  " Emmet vim
Plug 'vim-vdebug/vdebug'

if has('nvim')
  Plug 'Shougo/deoplete.nvim', { 'do': ':UpdateRemotePlugins' }
else
  Plug 'Shougo/deoplete.nvim'
  Plug 'roxma/nvim-yarp'
  Plug 'roxma/vim-hug-neovim-rpc'
endif

call plug#end()

"-----Visuals-----"
colorscheme gruvbox
let g:gruvbox_contrast_dark = 'soft'

set t_CO=256 						"Use 256 colors. Good for terminal vim.
set guifont=Fira_Code:h12
if has("gui_macvim")
    set macligatures
endif
set linespace=13					"Macvim specific line-height.

set guioptions-=l					"Set of options to remove scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R
set guioptions-=e 					"Disable gui tabs

set showtabline=2 					"Always show tabs.

"------Search---------"
set hlsearch
set incsearch

"-----Mappings--------"
"Vimrc shortcode, you will live here
nmap <Leader>ev :e $MYVIMRC<cr>

"stop search highlight
nmap <Leader><space> :nohlsearch<cr>

"Remap split moving windows
nmap <C-J> <C-W><C-J>					
nmap <C-K> <C-W><C-K>
nmap <C-H> <C-W><C-H>
nmap <C-L> <C-W><C-L>

" Keep visual selection when indenting
xnoremap > >gv
xnoremap < <gv

"-----Auto-Commands------"

"Automatically source the vimrc file on save.
augroup autosourcing
	autocmd!
    "Source vimrc when changing config
	autocmd BufWritePost .vimrc source %
    "Trigger php-cs-fixer on save.
	autocmd BufWritePost *.php silent! call PhpCsFixerFixFile()
augroup END

augroup filetype_settings
  autocmd!
  autocmd FileType php setlocal commentstring=//\ %s omnifunc=phpactor#Complete
augroup END

" If you prefer the Omni-Completion tip window to close when a selection is
" made, these lines close it on movement in insert mode or when leaving
" insert mode
autocmd CursorMovedI * if pumvisible() == 0|silent! pclose|endif
autocmd InsertLeave * if pumvisible() == 0|silent! pclose|endif



"--------Plugin-settings-------"
"" The Silver Searcher
if executable('ag')
  let g:ackprg = 'ag --vimgrep'      
" Use ag over grep
  set grepprg=ag\ --nogroup\ --nocolor
endif

"NerdTree
let NERDTreeHijackNetrw = 0
let NERDTreeShowHidden=1
"Toggle sidebar
nmap <Leader>1 :NERDTreeToggle<cr>


"Php-cs fixer
let g:php_cs_fixer_rules = "@PSR2"          " options: --rules (default:@PSR2)
let g:php_cs_fixer_cache = ".php_cs.cache" " options: --cache-file
let g:php_cs_fixer_config_file = '.php_cs' " options: --config
let g:php_cs_fixer_php_path = '~/.composer/vendor/bin/php-cs-fixer'

"Ale linter
let g:ale_php_phpcs_standard = 'PSR2'

"PHPactor
" Include use statement
nmap <Leader>u :call phpactor#UseAdd()<CR>
" Goto definition of class or class member under the cursor
nmap <Leader>o :call phpactor#GotoDefinition()<CR>
" Transform the classes in the current file
nmap <Leader>tt :call phpactor#Transform()<CR>
" Generate a new class (replacing the current file)
nmap <Leader>cc :call phpactor#ClassNew()<CR>
" Extract expression (normal mode)
nmap <silent><Leader>ee :call phpactor#ExtractExpression(v:false)<CR>
" Extract expression from selection
vmap <silent><Leader>ee :<C
"Search for syntax and change the current file to it-U>call phpactor#ExtractExpression(v:true)<CR>
" Extract method from selection
vmap <silent><Leader>em :<C-U>call phpactor#ExtractMethod()<CR>

"Deoplete autocompletion
let g:deoplete#enable_at_startup = 1
let g:deoplete#auto_completion_start_length = 1

"Gutentags
let g:gutentags_ctags_exclude_wildignore = 1
let g:gutentags_ctags_exclude = ['*.css', '*.html', '*.json', '*.xml',
                            \ 'node_modules/*', '*.map', '*.map', '*.js.map',
                            \ '*.phar', '*.ini', '*.rst', '*.md',
                            \ '*vendor/*', '*var/log*', 'storage/*'] 

"Vim test
" make test commands execute using iterm  
let test#strategy = "iterm"


"PDV docblocks
let g:pdv_template_dir = $HOME ."/.config/nvim/plugged/pdv/templates_snip"
nnoremap <leader>d :call pdv#DocumentWithSnip()<CR>

"Ultisnips
set runtimepath+=~/.dotfiles/.config/nvim/snippets
let g:UltiSnipsSnippetsDir = "~/.config/nvim/snippets/UltiSnips"
let g:UltiSnipsExpandTrigger="<tab>"
let g:UltiSnipsJumpForwardTrigger="<tab>"
let g:UltiSnipsJumpBackwardTrigger="<s-tab>"

" If you want :UltiSnipsEdit to split your window.
let g:UltiSnipsEditSplit="vertical"

"FZF
"File finder keybindings
nmap <Leader>f :GFiles<CR>
nmap <Leader>F :Files<CR>
"Buffer  history finder
nmap <D-e> :Buffer<CR>
"Finding full history
nmap <Leader>h :History<CR>
"Tag Finder
"Search tags in current buffer
nmap <Leader>t :BTags<CR>
"Search tags in project
nmap <Leader>T :Tags<CR>
"Search for specific lines in current buffer, / with fuzzy search
nmap <Leader>l :BLines<CR>
"Line search in all open buffers 
nmap <Leader>L :Lines<CR>
"Search for marks
nmap <Leader>' :Marks<CR>
"Project finding with ag and populate quickfixer
nmap <Leader>a :Ag<Space>
"Search for helptags in documentation. ! will trigger fullscreen
nmap <Leader>H :Helptags!<CR>
"Search defined commands
nmap <Leader>C :Commands<CR>
"Search for keymappings
nmap <Leader>M :Maps<CR>
"Search for syntax and change the current file to it
nmap <Leader>s :Filetypes<CR>

let g:fzf_colors =
\ { 'fg':      ['fg', 'Normal'],
  \ 'bg':      ['bg', 'Normal'],
  \ 'hl':      ['fg', 'Comment'],
  \ 'fg+':     ['fg', 'CursorLine', 'CursorColumn', 'Normal'],
  \ 'bg+':     ['bg', 'CursorLine', 'CursorColumn'],
  \ 'hl+':     ['fg', 'Statement'],
  \ 'info':    ['fg', 'PreProc'],
  \ 'border':  ['fg', 'Ignore'],
  \ 'prompt':  ['fg', 'Conditional'],
  \ 'pointer': ['fg', 'Exception'],
  \ 'marker':  ['fg', 'Keyword'],
  \ 'spinner': ['fg', 'Label'],
  \ 'header':  ['fg', 'Comment'] }

"Vim-emmet
let g:user_emmet_install_global = 0
autocmd FileType html,css,php,blade.php EmmetInstall
imap <expr> <tab> emmet#expandAbbrIntelligent("\<tab>")
