return {
    {
        "Vigemus/iron.nvim",
        event = { "BufReadPre *.py", "BufNewFile *.py" },
        config = function()
            local iron = require("iron.core")
            local view = require("iron.view")
            local common = require("iron.fts.common")

            iron.setup({
                config = {
                    scratch_repl = true,
                    repl_definition = {
                        python = {
                            command = { "ipython", "--no-autoindent" },
                            format = common.bracketed_paste_python,
                            block_dividers = { "# %%", "#%%" }, -- Recognize # %% as cell markers
                        },
                    },
                    repl_open_cmd = view.split.vertical.botright(40), -- Same as view.bottom(40) but vertical
                    highlight = {
                        italic = true,
                        bold = true,
                        fg = vim.api.nvim_get_hl_by_name("Normal", true).foreground,
                        bg = vim.api.nvim_get_hl_by_name("NormalFloat", true).background,
                    },
                    ignore_blank_lines = true,
                },
                keymaps = {
                    toggle_repl = "<leader>mr",    -- Open/close REPL (was <space>rr)
                    restart_repl = "<leader>mn",   -- Restart REPL (was <space>rR)
                    send_motion = "<leader>ms",    -- Send motion (was <space>sc)
                    visual_send = "<leader>mv",    -- Send visual selection (was <space>sc)
                    send_file = "<leader>mf",      -- Send file (was <space>sf)
                    send_line = "<leader>ml",      -- Send line (was <space>sl)
                    send_paragraph = "<leader>mg", -- Send paragraph (was <space>sp, avoided <leader>mp)
                    send_until_cursor = "<leader>mu", -- Send until cursor (was <space>su)
                    send_mark = "<leader>mm",      -- Send mark (was <space>sm)
                    send_code_block = "<leader>me", -- Send code block (was <space>sb, now used for cells)
                    send_code_block_and_move = "<leader>mB", -- Send code block and move (was <space>sn)
                    mark_motion = "<leader>mdm",   -- Mark motion (was <space>mc)
                    mark_visual = "<leader>mdv",   -- Mark visual (was <space>mc)
                    remove_mark = "<leader>mdr",   -- Remove mark (was <space>md)
                    cr = "<leader>mc",             -- Send CR (was <space>s<cr>)
                    interrupt = "<leader>mi",      -- Interrupt (was <space>s<space>)
                    exit = "<leader>mq",           -- Exit REPL (was <space>sq)
                    clear = "<leader>mx",          -- Clear REPL (was <space>cl)
                },
            })

            -- Additional commands from the documentation
            vim.keymap.set("n", "<leader>mfp", "<cmd>IronFocus<CR>", { noremap = true, silent = true }) -- Focus REPL (was <space>rf)
            vim.keymap.set("n", "<leader>mh", "<cmd>IronHide<CR>", { noremap = true, silent = true }) -- Hide REPL (was <space>rh)

            -- Visual mode mappings (must be set manually since keymaps table applies to normal mode)
            vim.keymap.set("v", "<leader>mv", "<cmd>IronSend<CR>", { noremap = true, silent = true })  -- Visual send
            vim.keymap.set("v", "<leader>mdv", "<cmd>IronMarkVisual<CR>", { noremap = true, silent = true }) -- Mark visual

            vim.notify("iron.nvim loaded and configured", vim.log.levels.INFO)
        end,
    },
}
