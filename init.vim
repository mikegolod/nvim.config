let g:neovide_transparency = 0.8
set guifont=Hack:h16
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
Plug 'kristijanhusak/vim-dadbod-completion'
Plug 'tpope/vim-eunuch'
Plug 'tpope/vim-fugitive'
Plug 'tpope/vim-surround'
Plug 'evanleck/vim-svelte', { 'branch': 'main' }
Plug 'neovim/nvim-lspconfig'
Plug 'mhinz/vim-startify'
Plug 'hrsh7th/nvim-compe'
Plug 'nvim-treesitter/nvim-treesitter', { 'do': ':TSUpdate' }

call plug#end()

if exists('+termguicolors')
	let &t_8f = "\<Esc>[38;2;%lu;%lu;%lum"
	let &t_8b = "\<Esc>[48;2;%lu;%lu;%lum"
endif

colorscheme dracula

set completeopt=menuone,noselect
let g:completion_matching_strategy_list = ['exact', 'substring', 'fuzzy']

" TypeScript LSP server config
lua require'lspconfig'.tsserver.setup{}

" Svelte language server config
lua require'lspconfig'.svelte.setup{}

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

" nvim-compe options
let g:compe = {}
let g:compe.enabled = v:true
let g:compe.autocomplete = v:true
let g:compe.debug = v:false
let g:compe.min_length = 1
let g:compe.preselect = 'enable'
let g:compe.throttle_time = 80
let g:compe.source_timeout = 200
let g:compe.incomplete_delay = 400
let g:compe.max_abbr_width = 100
let g:compe.max_kind_width = 100
let g:compe.max_menu_width = 100
let g:compe.documentation = v:true

let g:compe.source = {}
let g:compe.source.path = v:true
let g:compe.source.buffer = v:true
let g:compe.source.calc = v:true
let g:compe.source.nvim_lsp = v:true
let g:compe.source.nvim_lua = v:true
let g:compe.source.vsnip = v:false
let g:compe.source.vim_dadbod_completion = v:true


" nvim-compe mappings
inoremap <silent><expr> <C-Space> compe#complete()
inoremap <silent><expr> <CR>      compe#confirm('<CR>')
inoremap <silent><expr> <C-e>     compe#close('<C-e>')
inoremap <silent><expr> <C-f>     compe#scroll({ 'delta': +4 })
inoremap <silent><expr> <C-d>     compe#scroll({ 'delta': -4 })


" nnoremap <silent> <c-]> <cmd>lua vim.lsp.buf.definition()<CR>
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


" nvim-treesitter config
lua <<EOF
require'nvim-treesitter.configs'.setup {
	ensure_installed = "maintained",
    highlight = { enable = true },
    incremental_selection = { enable = true },
    textobjects = { enable = true },
}
EOF

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

" fix SCP-paths spaces
function! RobustSave(...)
	let path = expand('%')
	if a:0 == 1
		let path = a:1
	endif
	if (
		\ match(path, "scp://") == 0
		\ && (
		\ 	match(path, '[^\\] ') != -1
		\ 	|| match(path, '^ ') != -1
		\ )
	\ )
	" if the remote filename might cause problems with how netrw tries to
	" invoke scp, correct before saving:
		execute "sav " . escape(escape(path, ' '),' ')
	else
	" otherwise, just write as normal:
		execute "sav " . path
	endif
endfunction

:command! -nargs=? W call RobustSave(<f-args>)
