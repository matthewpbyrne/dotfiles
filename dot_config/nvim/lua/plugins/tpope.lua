return {
  { "tpope/vim-abolish", cmd = { "Abolish", "Subvert" } },
  { "tpope/vim-eunuch", cmd = { "Rename", "Delete", "Move", "Mkdir", "Chmod" } },
  { "tpope/vim-fugitive", cmd = { "Git", "G" }, dependencies = { "tpope/vim-rhubarb" } },
  { "tpope/vim-repeat", event = "VeryLazy" },
  { "tpope/vim-speeddating", keys = { "<C-A>", "<C-X>" } },
}
