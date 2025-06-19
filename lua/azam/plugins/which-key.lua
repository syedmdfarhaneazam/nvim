return {
    "folke/which-key.nvim",
    event = "VeryLazy",
    init = function()
        vim.o.timeout = true
        vim.o.timeoutlen = 500 -- Keep as 500ms for responsiveness
    end,
    opts = {
        plugins = {
            spelling = { enabled = true },
        },
        window = {
            border = "single",
        },
    },
    config = function()
        local wk = require("which-key")
        -- Register prefixes
        wk.register({
            { "<leader>d", group = "debug" },
            { "<leader>m", group = "repl", noremap = true, silent = true }, -- Changed to <leader>m
        })
        vim.keymap.set("n", "<leader>m", "<Nop>", { noremap = true, silent = true })
    end,
}
