return {
  {
    "folke/tokyonight.nvim",
    priority = 1000, -- make sure to load this before all the other start plugins
    config = function()
      -- Define custom colors
      local bg = "#011628"
      local bg_dark = "#011423"
      local bg_highlight = "#143652"
      local bg_search = "#0A64AC"
      local bg_visual = "#275378"
      local fg = "#CBE0F0"
      local fg_dark = "#B4D0E9"
      local fg_gutter = "#627E97"
      local border = "#547998"

      -- Configure tokyo night theme with custom colors
      require("tokyonight").setup({
        style = "night",  -- You can switch between "night" or "day"
        transparent = true,  -- Enable transparency in the background
        on_colors = function(colors)
          -- Set custom background and foreground colors
          colors.bg = bg
          colors.bg_dark = bg_dark
          colors.bg_float = bg_dark
          colors.bg_highlight = bg_highlight
          colors.bg_popup = bg_dark
          colors.bg_search = bg_search
          colors.bg_sidebar = bg_dark
          colors.bg_statusline = bg_dark
          colors.bg_visual = bg_visual
          colors.border = border
          colors.fg = fg
          colors.fg_dark = fg_dark
          colors.fg_float = fg
          colors.fg_gutter = fg_gutter
          colors.fg_sidebar = fg_dark

          -- Set transparent backgrounds where necessary
          colors.bg = "none"  -- Make the normal background transparent
          colors.bg_dark = "none"  -- Make the dark background transparent
          colors.bg_float = "none"  -- Make the floating window background transparent
          colors.bg_highlight = "none"  -- Make highlighted backgrounds transparent
          colors.bg_sidebar = "none"  -- Make sidebar transparent
          colors.bg_statusline = "none"  -- Make statusline background transparent
        end,
      })

      -- Load the theme
      vim.cmd([[colorscheme tokyonight]])
    end,
  },
}

