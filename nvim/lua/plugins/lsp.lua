return {
    {
        "neovim/nvim-lspconfig",
        opts = {
            -- 1. Completely disable inlay hints globally
            inlay_hints = { enabled = false },
            -- 2. Force clangd to use 4 spaces if no project file exists
            servers = {
                clangd = {
                    cmd = {
                        "clangd",
                        "--fallback-style={IndentWidth: 4, TabWidth: 4, UseTab: Never}",
                        "--background-index", -- Tell it to index in the background
                        "-j=2",               -- STRICT LIMIT: Only use 2 CPU threads max
                        "--pch-storage=memory", -- Speeds things up by keeping headers in RAM
                    },
                },
                pyright = {
                    cmd = {
                        "node",
                        "--max-old-space-size=1024",
                        vim.fn.stdpath("data") .. "/mason/bin/pyright-langserver",
                        "--stdio"
                    },
                },
            },
        },
    },
}
