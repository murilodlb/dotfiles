return {
    -- 1. Download the theme
    {
        "murilodlb/neolux",
        lazy = false,
        priority = 1000,
    },
    -- 2. Tell LazyVim to force this as the default theme
    {
        "LazyVim/LazyVim",
        opts = {
            colorscheme = "neolux",
        },
    },
}
