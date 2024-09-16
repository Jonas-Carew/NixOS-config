-- This file configures galaxyline, a fast and small statusline for nvim.
-- The configuration was taken from github.com/siduck76/neovim-dotfiles/
-- All I did was change the colors. Full credit goes to siduck76

local gl = require("galaxyline")
local gls = gl.section
local condition = require("galaxyline.condition")

-- gl.short_line_list = { "NvimTree", "minimap" }

vim.api.nvim_command("hi GalaxyLineFillSection guibg=NONE")

local colors = {
	-- Dark
	adw0 = "#1D1D1D", -- Black
	adw1 = "#303030", -- Dark Grey
	adw2 = "#504E55", -- Grey
	adw3 = "#77767B", -- Light Grey
	-- Light
	adw4 = "#9A9996", -- Darkest White
	adw5 = "#DEDDDA", -- Darker White
	adw6 = "#FCFCFC", -- White
	-- Frost
	adw7 = "#000000", -- Unused
	adw8 = "#5BC8AF", -- Teal
	adw9 = "#99C1F1", -- Light Blue
	adw10 = "#1A5FB4", -- Blue
	-- Aurora
	adw11 = "#F66151", -- Red
	adw12 = "#E66100", -- Orange
	adw13 = "#E5A50A", -- Yellow
	adw14 = "#8FF0A4", -- Green
	adw15 = "#9141AC", -- Purple
	none = "NONE",
}

gls.left[1] = {
	ViMode = {
		provider = function()
			local alias = {
				n = "NORMAL",
				i = "INSERT",
				c = "COMMAND",
				V = "VISUAL",
				[""] = "VISUAL",
				v = "VISUAL",
				R = "REPLACE",
			}
			return alias[vim.fn.mode()]
		end,
--		separator = { " ", " " },
--		separator_highlight = { colors.adw13, colors.adw13 },
		highlight = { colors.adw2, colors.adw13, 'bold' },
	},
}

gls.left[2] = {
	leftMid = {
		provider = function()
			return " "
		end,
		highlight = { colors.adw13, colors.adw2 },
	},
}

gls.left[3] = {
	FileIcon = {
		provider = "FileIcon",
		condition = condition.buffer_not_empty,
		highlight = { require("galaxyline.providers.fileinfo").get_file_icon_color, colors.adw2 },
	},
}

gls.left[4] = {
	FileName = {
		provider = { "FileName", "FileSize" },
		condition = condition.buffer_not_empty,
		highlight = { colors.adw13, colors.adw2 },
	},
}

gls.left[5] = {
	leftEnd = {
		provider = function()
			return ""
		end,
		separator = " ",
		highlight = { colors.adw2, colors.adw0 },
	},
}

gls.mid[1] = {
	midStart = {
		provider = function()
			return ""
		end,
		highlight = { colors.adw2, colors.adw0 },
	},
}

gls.mid[2] = {
	GetLspClient = {
		provider = "GetLspClient",
		separator = { " ", " " },
		separator_highlight = { colors.adw2, colors.adw2 },
		highlight = { colors.adw14, colors.adw2 },
	},
}

gls.mid[3] = {
	DiagnosticError = {
		provider = "DiagnosticError",
		icon = " ",
		highlight = { colors.adw11, colors.adw2 },
	},
}

gls.mid[4] = {
	DiagnosticWarn = {
		provider = "DiagnosticWarn",
		icon = " ",
		highlight = { colors.adw12, colors.adw2 },
	},
}

gls.mid[5] = {
	DiagnosticInfo = {
		provider = "DiagnosticInfo",
		icon = " ",
		highlight = { colors.adw6, colors.adw2 },
	},
}

gls.mid[6] = {
	DiagnosticHint = {
		provider = "DiagnosticHint",
		icon = " ",
		highlight = { colors.adw8, colors.adw2 },
	},
}

gls.mid[7] = {
	midEnd = {
		provider = function()
			return ""
		end,
		highlight = { colors.adw2, colors.adw0 },
	},
}

gls.right[1] = {
	GitIcon = {
		provider = function()
			return ""
		end,
		condition = require("galaxyline.providers.vcs").check_git_workspace,
		highlight = { colors.adw10, colors.adw0 },
	},
}

gls.right[2] = {
	GitBranch = {
		provider = "GitBranch",
		condition = require("galaxyline.providers.vcs").check_git_workspace,
		separator = " ",
		separator_highlight = { colors.adw0, colors.adw0 },
		highlight = { colors.adw10, colors.adw0 },
	},
}

gls.right[3] = {
	GitSpace = {
		provider = function()
			return " "
		end,
		condition = require("galaxyline.providers.vcs").check_git_workspace,
		highlight = { colors.adw0, colors.adw0 },
	},
}

gls.right[4] = {
	DiffAdd = {
		provider = "DiffAdd",
		condition = condition.hide_in_width,
		icon = " ",
		highlight = { colors.adw14, colors.adw0 },
	},
}

gls.right[5] = {
	DiffModified = {
		provider = "DiffModified",
		condition = condition.hide_in_width,
		icon = " ",
		highlight = { colors.adw12, colors.adw0 },
	},
}

gls.right[6] = {
	DiffRemove = {
		provider = "DiffRemove",
		condition = condition.hide_in_width,
		icon = " ",
		highlight = { colors.adw13, colors.adw0 },
	},
}

gls.right[7] = {
	rightStart = {
		provider = function()
			return " "
		end,
		highlight = { colors.adw8, colors.adw0 },
	},
}

gls.right[8] = {
	rightEnd = {
		provider = function()
			return "  "
		end,
		highlight = { colors.adw8, colors.adw8 },
	},
}

gls.right[9] = {
	PerCent = {
		provider = "LinePercent",
		highlight = { colors.adw2, colors.adw8 },
	},
}
--[[
gls.right[9] = {
	rightEnd = {
		provider = function()
			return ""
		end,
		highlight = { colors.adw8, colors.adw0 },
	},
}
--]]
