local separator = { '"▏"', color = 'StatusLineNonText' }

require('lualine').setup({
  options = {
    globalstatus= true,
  sections = {
    lualine_b = {
      '"🖧  " .. tostring(#vim.tbl_keys(vim.lsp.buf_get_clients()))',
    },
    },
  },
})
