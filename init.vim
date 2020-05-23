" vim:ts=4:sw=4
" make sure vim-plug is installed
if empty(glob('~/.config/nvim/autoload/plug.vim'))
	silent !curl -fLo ~/.config/nvim/autoload/plug.vim --create-dirs
	  \ https://raw.githubusercontent.com/junegunn/vim-plug/master/plug.vim
	autocmd VimEnter * PlugInstall --sync | source $MYVIMRC
endif

call plug#begin(stdpath('data') . '/plugged')

Plug 'airblade/vim-gitgutter'
Plug 'diepm/vim-rest-console'
Plug 'dracula/vim', { 'as': 'dracula' }
Plug 'editorconfig/editorconfig-vim'
Plug 'itchyny/lightline.vim'
Plug 'junegunn/fzf', { 'dir': '~/.fzf', 'do': './install --bin' }
Plug 'junegunn/fzf.vim'
Plug 'kristijanhusak/vim-dadbod-ui'
Plug 'lambdalisue/suda.vim' 
Plug 'morhetz/gruvbox'
Plug 'neoclide/coc.nvim', { 'branch': 'release' }
Plug 'preservim/nerdtree'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'

call plug#end()

colorscheme gruvbox

hi Normal guibg=NONE ctermbg=NONE

" let the configuration begin
set hidden
set nobackup
set nowritebackup
set noshowmode

set cmdheight=1
set updatetime=300
set shortmess+=c
set signcolumn=yes

" coc.nvim mappings
inoremap <silent><expr> <TAB>
	\ pumvisible() ? "\<C-n>" :
	\ <SID>check_back_space() ? "\<TAB>" :
	\ coc#refresh()
inoremap <expr><S-TAB> pumvisible() ? "\<C-p>" : "\<C-h>"

function! s:check_back_space() abort
	let col = col('.') - 1
	return !col || getline('.')[col -1] =~# '\s'
endfunction

inoremap <silent><expr> <c-space> coc#refresh()

nmap <silent> gd <Plug>(coc-definition)
nmap <silent> gy <Plug>(coc-type-definition)
nmap <silent> gi <Plug>(coc-implementation)
nmap <silent> gr <Plug>(coc-references)

nmap <silent> K :call <SID>show_documentation()<CR>

function! s:show_documentation()
	if (index(['vim','help'], &filetype) >= 0)
		execute 'h '.expand('<cword>')
	else
		call CocAction('doHover')
	endif
endfunction

" lightline configuration
let g:lightline = {
	\ 'active': {
	\ 	'left': [['mode', 'paste' ], ['gitbranch', 'readonly', 'relativepath', 'modified']]
	\ },
	\ 'component_function': {
	\ 	'gitbranch': 'fugitive#head'
	\ },
	\ }

" use rg as grepprg if available
if executable("rg")
	let &grepprg="rg --vimgrep $*"
end

