return {
    {
        "mfussenegger/nvim-dap",
        dependencies = {
            "rcarriga/nvim-dap-ui",
            "mfussenegger/nvim-dap-python",
            "nvim-neotest/nvim-nio",
        },
        config = function()
            local dap = require("dap")
            local dapui = require("dapui")

            -- Setup DAP UI
            dapui.setup({
                layouts = {
                    {
                        elements = {
                            { id = "scopes",      size = 0.25 },
                            { id = "breakpoints", size = 0.25 },
                            { id = "stacks",      size = 0.25 },
                            { id = "watches",     size = 0.25 },
                        },
                        size = 40,
                        position = "left",
                    },
                    {
                        elements = { "repl", "console" },
                        size = 10,
                        position = "bottom",
                    },
                },
            })

            -- Automatically open/close DAP UI
            dap.listeners.after.event_initialized["dapui_config"] = function()
                dapui.open()
            end
            dap.listeners.before.event_terminated["dapui_config"] = function()
                dapui.close()
            end
            dap.listeners.before.event_exited["dapui_config"] = function()
                dapui.close()
            end

            -- Python DAP configuration
            require("dap-python").setup("~/.venv/nvim-tools/bin/python") -- Path to your virtualenv python

            -- Ensure debugpy is installed in your virtualenv
            -- Run: pip install debugpy (if not already installed)

            -- Apply theme from coloursscheme.lua (assumes a colorscheme like catppuccin or similar)
            vim.api.nvim_set_hl(0, "DapBreakpoint", { link = "DiagnosticError" }) -- Red breakpoint icon
            vim.api.nvim_set_hl(0, "DapStopped", { link = "DiagnosticWarn" }) -- Yellow for current line
            vim.api.nvim_set_hl(0, "DapLogPoint", { link = "DiagnosticInfo" }) -- Blue for log points

            -- Sign definitions for DAP
            vim.fn.sign_define("DapBreakpoint", { text = "🛑", texthl = "DapBreakpoint", linehl = "", numhl = "" })
            vim.fn.sign_define("DapStopped", { text = "➡️", texthl = "DapStopped", linehl = "DapStopped", numhl = "" })
            vim.fn.sign_define("DapLogPoint", { text = "📝", texthl = "DapLogPoint", linehl = "", numhl = "" })

            -- Which-key integration
                        -- Which-key integration
            local wk = require("which-key")
            wk.add({
              { "<leader>d", group = "debug" },
              { "<leader>db", dap.toggle_breakpoint, desc = "Toggle Breakpoint" },
              { "<leader>dc", dap.continue, desc = "Continue" },
              { "<leader>di", dap.step_into, desc = "Step Into" },
              { "<leader>do", dap.step_over, desc = "Step Over" },
              { "<leader>du", dap.step_out, desc = "Step Out" },
              { "<leader>dr", dapui.toggle, desc = "Toggle DAP UI" },
              { "<leader>dt", dap.terminate, desc = "Terminate" },
            })
        end,
    },
}
