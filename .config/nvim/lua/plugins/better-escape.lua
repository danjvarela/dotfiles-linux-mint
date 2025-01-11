return {
  "max397574/better-escape.nvim",
  enabled = true,
  config = function()
    require("better_escape").setup({
      mappings = {
        t = {
          j = {
            k = "",
            j = "",
          },
          k = {
            k = "",
            j = "",
          },
        },
      },
    })
  end,
}
