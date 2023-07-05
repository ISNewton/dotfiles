vim.keymap.set('n', '<F2>', ':FloatermToggle scratch<CR>')
vim.keymap.set('t', '<F2>', '<C-\\><C-n>:FloatermToggle scratch<CR>')

vim.keymap.set('n', '<leader>1', ':FloatermPrev<CR>')
vim.keymap.set('n', '<leader>2', ':FloatermNext<CR>')


vim.keymap.set('t', '<leader>1', '<C-\\><C-n>:FloatermPrev <CR>')
vim.keymap.set('t', '<leader>2', '<C-\\><C-n>:FloatermNext <CR>')

vim.g.floaterm_gitcommit = 'floaterm'
vim.g.floaterm_autoinsert = 1
vim.g.floaterm_width = 0.8
vim.g.floaterm_height = 0.8
vim.g.floaterm_wintitle = 0

vim.cmd([[
  highlight link Floaterm CursorLine
  highlight link FloatermBorder CursorLineBg
]])

