function _G.reload_config()
	for name, _ in pairs(package.loaded) do
		if name:match("^c?[%w_]+") then
			package.loaded[name] = nil
		end
	end
	dofile(vim.env.MYVIMRC)
end

function _G.print_hello()
	print("Hello, Matthew's Neovim!")
end

function _G.matt_test()
	print("Hello, matt_test")
	local my_thing = vim.fn.expand("%")
	print(my_thing)
	return require("neotest").run.run()
end
