local o = vim.opt

vim.cmd("colorscheme adwaita")

vim.cmd("command Tab2 %s/  /\t/g")

o.number = true
o.relativenumber = true
o.mouse = 'a'
o.tabstop = 4
o.shiftwidth = 4
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
