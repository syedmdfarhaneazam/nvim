return {
  "lewis6991/gitsigns.nvim",
  event = { "BufReadPre", "BufNewFile" },
  opts = {
    -- Enables virtual text blame for the current line
    current_line_blame = true,

    -- Options for how the blame text should appear
    current_line_blame_opts = {
      delay = 100,               -- Delay in milliseconds before blame text appears
      virt_text = true,          -- Display blame info as virtual text (inline)
      virt_text_pos = 'eol',     -- Position the text at the end of the line ('eol' = end of line)
      ignore_whitespace = false, -- Don't ignore whitespace when determining blame
    },

    -- Format of the blame text shown
    current_line_blame_formatter = '<author>, <author_time:%Y-%m-%d> - <summary>',
    -- Shows: Author name, date, and short commit message
    on_attach = function(bufnr)
      local gs = package.loaded.gitsigns

      local function map(mode, l, r, desc)
        vim.keymap.set(mode, l, r, { buffer = bufnr, desc = desc })
      end

      -- Navigation
      map("n", "]h", gs.next_hunk, "Next Hunk")
      map("n", "[h", gs.prev_hunk, "Prev Hunk")

      -- Actions
      map("n", "<leader>hs", gs.stage_hunk, "Stage hunk")
      map("n", "<leader>hr", gs.reset_hunk, "Reset hunk")
      map("v", "<leader>hs", function()
        gs.stage_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Stage hunk")
      map("v", "<leader>hr", function()
        gs.reset_hunk({ vim.fn.line("."), vim.fn.line("v") })
      end, "Reset hunk")

      map("n", "<leader>hS", gs.stage_buffer, "Stage buffer")
      map("n", "<leader>hR", gs.reset_buffer, "Reset buffer")

      map("n", "<leader>hu", gs.undo_stage_hunk, "Undo stage hunk")

      map("n", "<leader>hp", gs.preview_hunk, "Preview hunk")

      map("n", "<leader>hb", function()
        gs.blame_line({ full = true })
      end, "Blame line")
      map("n", "<leader>hB", gs.toggle_current_line_blame, "Toggle line blame")

      map("n", "<leader>hd", gs.diffthis, "Diff this")
      map("n", "<leader>hD", function()
        gs.diffthis("~")
      end, "Diff this ~")

      -- Text object
      map({ "o", "x" }, "ih", ":<C-U>Gitsigns select_hunk<CR>", "Gitsigns select hunk")
    end,
  },
}
