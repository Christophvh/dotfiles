syntax enable


"-----General Settings------"
set backspace=indent,eol,start  			"Make backspaces work.
let mapleader = ','					"Change the default leader to a comma.
set number						"Activate line-numbers.

"-----Visuals-----"
colorscheme gruvbox
set t_CO=256 						"Use 256 colors. Good for terminal vim.
set guifont=Fira_Code:h12
set linespace=13					"Macvim specific line-height.

set guioptions-=l					"Set of options to remove scrollbars.
set guioptions-=L
set guioptions-=r
set guioptions-=R

"------Search---------"
set hlsearch
set incsearch

"-----Mappings--------"
nmap <Leader>ev :e $MYVIMRC
nmap <Leader><space> :nohlsearch<cr>

"-----Auto-Commands------"

"Automatically source the vimrc file on save.
augroup autosourcing
	autocmd!
	autocmd BufWritePost .vimrc source %
augroup END
