return {
  "liquidz/vim-iced",
  dependencies = {
    "guns/vim-sexp"
  },
  config = function()
    vim.cmd [[
      let g:iced_enable_default_key_mappings = v:true
    ]]
  end
}
