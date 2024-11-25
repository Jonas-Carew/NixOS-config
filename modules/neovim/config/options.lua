local o = vim.opt

vim.cmd("colorscheme adwaita")

vim.cmd("command Tab2 %s/  /\t/g")

o.number = true
o.relativenumber = true
o.mouse = 'a'
o.tabstop = 4
o.shiftwidth = 4
o.expandtab = false
o.smartindent = true
o.clipboard = 'unnamedplus'
o.undofile = true
o.list = true
o.colorcolumn = "81"
vim.opt.listchars = {
	tab = '  ',
	multispace = '··',
	extends = '⟩',
	precedes = '⟨',
	trail = '·'
}

vim.cmd[[
augroup FileTypeSettings
	autocmd!
	autocmd BufEnter *.md setlocal noexpandtab
	autocmd BufEnter *.md :Markview splitEnable
augroup END
]]
