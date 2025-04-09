require("azam.core.options")
require("azam.core.keymaps")
vim.diagnostic.config({
  virtual_text = true, -- show inline error text
  signs = true,        -- show signs in sign column
  underline = true,    -- underline problematic code
  update_in_insert = false,
  severity_sort = true,
})
-- Show floating diagnostic window on cursor hover (like VS Code)
vim.api.nvim_create_autocmd("CursorHold", {
  callback = function()
    vim.diagnostic.open_float(nil, { focus = false })
  end,
})
