return {
  "williamboman/mason.nvim",
  version = "1.*",
  dependencies = {
    { "williamboman/mason-lspconfig.nvim",         version = "1.*" },
    { "WhoIsSethDaniel/mason-tool-installer.nvim", version = "1.*" },
    "neovim/nvim-lspconfig",
    "hrsh7th/nvim-cmp",
    "hrsh7th/cmp-nvim-lsp",
  },
  config = function()
    local has_mason, mason = pcall(require, "mason")
    local has_mason_lspconfig, mason_lspconfig = pcall(require, "mason-lspconfig")
    local has_lspconfig, lspconfig = pcall(require, "lspconfig")
    local has_cmp_nvim_lsp, cmp_nvim_lsp = pcall(require, "cmp_nvim_lsp")

    if not (has_mason and has_mason_lspconfig and has_lspconfig and has_cmp_nvim_lsp) then
      vim.notify("❌ Mason or LSP plugins failed to load", vim.log.levels.ERROR)
      return
    end

    mason.setup({
      ui = {
        icons = {
          package_installed = "✓",
          package_pending = "➜",
          package_uninstalled = "✗",
        },
      },
    })

    local capabilities = cmp_nvim_lsp.default_capabilities()

    mason_lspconfig.setup({
      ensure_installed = {
        "html",
        "cssls",
        "tailwindcss",
        "lua_ls",
        "graphql",
        "emmet_ls",
        "prismals",
        "pyright",
        "svelte",
      },
      automatic_installation = true,
      handlers = {
        function(server_name)
          lspconfig[server_name].setup({
            capabilities = capabilities,
          })
        end,

        ["svelte"] = function()
          lspconfig.svelte.setup({
            capabilities = capabilities,
            on_attach = function(client, bufnr)
              vim.api.nvim_create_autocmd("BufWritePost", {
                pattern = { "*.js", "*.ts" },
                callback = function(ctx)
                  client.notify("$/onDidChangeTsOrJsFile", { uri = ctx.match })
                end,
              })
            end,
          })
        end,

        ["graphql"] = function()
          lspconfig.graphql.setup({
            capabilities = capabilities,
            filetypes = { "graphql", "gql", "svelte", "typescriptreact", "javascriptreact" },
          })
        end,

        ["emmet_ls"] = function()
          lspconfig.emmet_ls.setup({
            capabilities = capabilities,
            filetypes = {
              "html",
              "typescriptreact",
              "javascriptreact",
              "css",
              "sass",
              "scss",
              "less",
              "svelte",
            },
          })
        end,

        ["lua_ls"] = function()
          lspconfig.lua_ls.setup({
            capabilities = capabilities,
            settings = {
              Lua = {
                diagnostics = {
                  globals = { "vim" },
                },
                completion = {
                  callSnippet = "Replace",
                },
              },
            },
          })
        end,
      },
    })

    -- Optional tools installer
    local has_tool_installer, mason_tool_installer = pcall(require, "mason-tool-installer")
    if has_tool_installer then
      mason_tool_installer.setup({
        ensure_installed = {
          "prettier",
          "isort",
          "black",
          "pylint",
          "eslint_d",
        },
      })
    end
  end,
}
