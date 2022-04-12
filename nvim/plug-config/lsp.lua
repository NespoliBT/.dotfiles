local nvim_lsp = require('lspconfig')
local saga = require 'lspsaga'

nvim_lsp.tsserver.setup {}

saga.init_lsp_saga {
  error_sign = '',
  warn_sign = '',
  hint_sign = '',
  infor_sign = '',
  border_style = "round",
}

local on_attach = function(client, bufnr)
  require'completion'.on_attach(client, bufnr)
end
