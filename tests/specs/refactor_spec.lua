local assert = require('luassert')

describe('Refactor API', function()
	local code_action

	before_each(function()
		code_action = vim.lsp.buf.code_action
	end)

	after_each(function()
		vim.lsp.buf.code_action = code_action
	end)

	it('lets Neovim populate code action diagnostics', function()
		local opts
		vim.lsp.buf.code_action = function(value)
			opts = value
		end

		require('java-refactor.api.refactor').extract_variable()

		assert.is_nil(opts.context.diagnostics)
		assert.same({ 'refactor.extract.variable' }, opts.context.only)
	end)
end)
