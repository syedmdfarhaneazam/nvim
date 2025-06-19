
return {
  {
    "williamboman/mason.nvim",
    version = "1.11.0",
    dependencies = {
      {
        "williamboman/mason-lspconfig.nvim",
        version = "1.11.0",
      },
      "WhoIsSethDaniel/mason-tool-installer.nvim",
    },
    cmd = "Mason",        -- lazy-load only when used
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "html", "cssls", "tailwindcss",
          "lua_ls", "graphql", "pyright", "debugpy",
        },
        automatic_installation = true,
        automatic_enable = false,  -- avoid v2 API
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier", "isort", "black", "pylint", "eslint_d"
        },
        auto_update = true,
        run_on_start = true,
      })
    end,
  },
}

