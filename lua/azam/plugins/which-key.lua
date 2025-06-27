return
{
  "folke/which-key.nvim",
  event = "VeryLazy",
  init = function()
    vim.o.timeout = true
    vim.o.timeoutlen = 500
  end,
  opts = {
    plugins = {
      spelling = { enabled = true }, -- keep spelling suggestions
    },
    window = {
      border = "single",
    },
    -- you can adjust layout, icons, presets, etc.
  },
  config = function(_, opts)
    local wk = require("which-key")
    wk.setup(opts)

    -- register your key groups and bindings
    wk.register({
      d = { name = "debug" }, -- <leader>d group
      m = { name = "repl" },  -- <leader>m group
    }, { prefix = "<leader>", mode = "n" })

    -- prevent default mapping of <leader>m if you plan to use it manually
    vim.keymap.set("n", "<leader>m", "<Nop>", { noremap = true, silent = true })
  end,
}
