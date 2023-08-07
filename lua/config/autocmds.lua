vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "fugitive",
    "fugitiveblame",
    "Jaq",
    "qf",
    "fzf",
    "help",
    "man",
    "lspinfo",
    "lir",
    "DressingSelect",
    "OverseerList",
    "tsplayground",
    "Markdown",
    "git",
  },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      nnoremap <silent> <buffer> <esc> :close<CR>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd({ "BufEnter" }, {
  pattern = { "" },
  callback = function()
    local buf_ft = vim.bo.filetype
    if buf_ft == "" or buf_ft == nil then
      vim.cmd([[
      nnoremap <silent> <buffer> q :close<CR>
      nnoremap <silent> <buffer> <c-j> j<CR>
      nnoremap <silent> <buffer> <c-k> k<CR>
      set nobuflisted
    ]])
    end
  end,
})

vim.api.nvim_create_autocmd({ "FileType" }, {
  pattern = {
    "DiffviewFileHistory",
    "DiffviewFiles",
  },
  callback = function()
    vim.cmd([[
      nnoremap <silent> <buffer> q :DiffviewClose<CR>
      nnoremap <silent> <buffer> <esc> :DiffviewClose<CR>
      set nobuflisted
    ]])
  end,
})

vim.api.nvim_create_autocmd({ "DiffUpdated" }, {
  pattern = { "" },
  callback = function()
    if vim.wo.diff then
      vim.diagnostic.disable()
      local bufnr = vim.api.nvim_get_current_buf()
      vim.keymap.set("n", "2", function()
        return ":diffget //2<CR>"
      end, { expr = true, silent = true, buffer = bufnr })

      vim.keymap.set("n", "3", function()
        return ":diffget //3<CR>"
      end, { expr = true, silent = true, buffer = bufnr })
    end
  end,
})
