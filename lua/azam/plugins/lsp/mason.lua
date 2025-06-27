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
    cmd = "Mason",
    config = function()
      require("mason").setup()
      require("mason-lspconfig").setup({
        ensure_installed = {
          "html",
          "cssls",
          "tailwindcss",
          "lua_ls",
          "graphql",
          "pyright",
          "jdtls", -- Added for Java
        },
        automatic_installation = true,
      })
      require("mason-tool-installer").setup({
        ensure_installed = {
          "prettier",
          "isort",
          "black",
          "pylint",
          "eslint_d",
          "debugpy", -- Ensure debugpy for Python debugging
        },
        auto_update = true,
        run_on_start = true,
      })
    end,
  },
}
