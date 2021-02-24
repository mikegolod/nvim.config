" vim:ts=4:sw=4
" make sure vim-plug is installed
if empty(glob(stdpath('config') . '/autoload/plug.vim'))
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
Plug 'kylef/apiblueprint.vim'
Plug 'lambdalisue/suda.vim' 
Plug 'morhetz/gruvbox'
Plug 'preservim/nerdtree'
Plug 'sheerun/vim-polyglot'
Plug 'tpope/vim-dadbod'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'evanleck/vim-svelte', { 'branch': 'main' }
Plug 'neovim/nvim-lspconfig'
Plug 'nvim-lua/completion-nvim'
Plug 'mhinz/vim-startify'

call plug#end()

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme dracula

set completeopt=menuone,noinsert,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" TypeScript LSP server config
lua require'lspconfig'.tsserver.setup{on_attach=require'completion'.on_attach}

" Svelte language server config
lua require'lspconfig'.svelte.setup{on_attach=require'completion'.on_attach}

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

nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
nnoremap <silent> K     <cmd>lua vim.lsp.buf.hover()<CR>
nnoremap <silent> gD    <cmd>lua vim.lsp.buf.implementation()<CR>
nnoremap <silent> <c-k> <cmd>lua vim.lsp.buf.signature_help()<CR>
nnoremap <silent> 1gD   <cmd>lua vim.lsp.buf.type_definition()<CR>
nnoremap <silent> gr    <cmd>lua vim.lsp.buf.references()<CR>
nnoremap <silent> g0    <cmd>lua vim.lsp.buf.document_symbol()<CR>
nnoremap <silent> gW    <cmd>lua vim.lsp.buf.workspace_symbol()<CR>
nnoremap <silent> gd    <cmd>lua vim.lsp.buf.declaration()<CR>


" Git Gutter mappings
nnoremap <silent> <Leader>ggP <cmd>GitGutterPreview<CR>
nnoremap <silent> <Leader>ggp <cmd>GitGutterPrevHunk<CR>
nnoremap <silent> <Leader>ggn <cmd>GitGutterNextHunk<CR>
nnoremap <silent> <Leader>ggX <cmd>GitGutterUndoHunk<CR>
nnoremap <silent> <Leader>ggS <cmd>GitGutterStageHunk<CR>


" Git mappings
nnoremap <silent> <Leader>gc <cmd>Git commit<CR>


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

