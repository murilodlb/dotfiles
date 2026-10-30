return {
  -- 1. Tell Tree-sitter to automatically install the VHDL syntax parser
  {
    "nvim-treesitter/nvim-treesitter",
    opts = function(_, opts)
      if type(opts.ensure_installed) == "table" then
        table.insert(opts.ensure_installed, "vhdl")
      end
    end,
  },

  -- 2. Bind the VHDL Language Server (vhdl_ls) to Neovim's LSP manager
  {
    "neovim/nvim-lspconfig",
    opts = {
      servers = {
        -- vhdl_ls handles code completion, syntax validation, and type tracking
        vhdl_ls = {},
      },
    },
  },
}
