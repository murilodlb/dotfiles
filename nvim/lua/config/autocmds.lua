vim.api.nvim_create_autocmd("TextYankPost", {
    group = vim.api.nvim_create_augroup("CustomYankHighlight", { clear = true }),
    callback = function()
        vim.highlight.on_yank({
            higroup = "FieryYank",
            timeout = 250,
        })
    end,
})

vim.api.nvim_create_autocmd("VimLeavePre", {
    group = vim.api.nvim_create_augroup("ForceLspShutdown", { clear = true }),
    callback = function()
        -- Compatibility check for different Neovim versions
        local clients = vim.lsp.get_clients and vim.lsp.get_clients()

        for _, client in ipairs(clients) do
            -- The 'true' argument means FORCE kill, don't wait for a polite response
            client.stop(table(true))
        end
    end,
})
