# 👀 eyeliner.nvim

Move faster with unique `f`/`F` indicators for each word on the line. Like [quick-scope](https://github.com/unblevable/quick-scope), but in Lua.

<!-- ![demo](https://user-images.githubusercontent.com/40512164/181354222-b4487f22-e947-468a-8739-653074e2c012.gif) -->

https://user-images.githubusercontent.com/40512164/178066018-0d3fa234-a5b5-4a41-a340-430e8c4c2739.mov

The orange letters indicate the unique letter in the word that you can jump to with `f`/`F` right away.
Blue letters indicate that there is no unique letter in the word, but you can get to it with `f`/`F` and then a repeat with `;`.

## 📦 Installation
Requirement: Neovim >= 0.7.0

Using [vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'jinh0/eyeliner.nvim'
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):
```lua
use 'jinh0/eyeliner.nvim'
```

## ⚙️ Configuration

Default values (in lazy.nvim):
```lua
{
  'jinh0/eyeliner.nvim',
  config = function()
    require'eyeliner'.setup {
      -- show highlights only after keypress
      highlight_on_key = true,

      -- dim all other characters if set to true (recommended!)
      dim = false,             

      -- set the maximum number of characters eyeliner.nvim will check from
      -- your current cursor position; this is useful if you are dealing with
      -- large files: see https://github.com/jinh0/eyeliner.nvim/issues/41
      max_length = 9999,

      -- filetypes for which eyeliner should be disabled;
      -- e.g., to disable on help files:
      -- disable_filetypes = {"help"}
      disable_filetypes = {},

      -- buftypes for which eyeliner should be disabled
      -- e.g., disable_buftypes = {"nofile"}
      disable_buftypes = {},

      -- add eyeliner to f/F/t/T keymaps;
      -- see section on advanced configuration for more information
      default_keymaps = true,
    }
  end
}
```

## ✨ Show highlights only after keypress
If you prefer to have eyeliner's highlights shown only after you press `f`/`F`/`t`/`T`, set `highlight_on_key` to `true` in the setup function.

In Lua:
```lua
use {
  'jinh0/eyeliner.nvim',
  config = function()
    require'eyeliner'.setup {
      highlight_on_key = true
    }
  end
}
```

<details>
<summary>Demo</summary>

https://user-images.githubusercontent.com/40512164/180614964-c1a63671-7fa8-438d-ad4f-c90079adf098.mov

</details>

### Highlight + Dim

When using `highlight_on_key`, you may want to dim the rest of the characters since they are unimportant. You can do this with the `dim` option:

```lua
require'eyeliner'.setup {
  highlight_on_key = true, -- this must be set to true for dimming to work!
  dim = true,
}
```

https://user-images.githubusercontent.com/40512164/211218941-ac7df0b6-67ea-4aa2-af9a-110ef9e3091f.mov


## 🖌 Customize highlight colors
You can customize the highlight colors and styles with the `EyelinerPrimary` and `EyelinerSecondary` highlight groups.

For instance, if you wanted to make eyeliner.nvim more subtle by only using bold and underline, with no color,

In Vimscript:
```vim
highlight EyelinerPrimary gui=underline,bold
highlight EyelinerSecondary gui=underline
```

In Lua:
```lua
vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { underline = true })
```

If you want to set a custom color:

In Vimscript:
```vim
highlight EyelinerPrimary guifg=#000000 gui=underline,bold
highlight EyelinerSecondary guifg=#ffffff gui=underline
```

In Lua:
```lua
vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg='#000000', bold = true, underline = true })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { fg='#ffffff', underline = true })
```

### Update highlights when the colorscheme is changed
In Vimscript:
```vim
autocmd ColorScheme * :highlight EyelinerPrimary ...
```
In Lua:
```lua
vim.api.nvim_create_autocmd('ColorScheme', {
  pattern = '*',
  callback = function()
    vim.api.nvim_set_hl(0, 'EyelinerPrimary', { bold = true, underline = true })
  end,
})
```

## Advanced Configuration

There are two common use cases that require more configuration:
- You want to use other plugins that change the f/F/t/T functionality, like https://github.com/rhysd/clever-f.vim
- You want to map eyeliner's highlights to other keys than f/F/t/T

eyeliner.nvim by default maps the f/F/t/T keys. You can disable this with the `default_keymaps` option:
```lua
require'eyeliner'.setup {
  highlight_on_key = true,
  default_keymaps = false
}
```

eyeliner.nvim exposes the highlight functionality:
```lua
require("eyeliner").highlight({ forward = true })
```
Set `forward = true` for f/t highlights and `forward = false` for F/T highlights.

### Example: Integration with clever-f.vim

The following code adds eyeliner.nvim highlights to clever-f's `f` functionality:
```lua
vim.g.clever_f_not_overwrites_standard_mappings = 1

vim.keymap.set(
  {"n", "x", "o"},
  "f",
  function() 
    require("eyeliner").highlight({ forward = true })
    return "<Plug>(clever-f-f)"
  end,
  {expr = true}
)
```

### Example: Mapping a different character for `f` functionality

Note, the purpose of eyeliner is to provide highlights. It is up to you to replicate the functionality of `f`. Here is a starting point:
```lua
vim.keymap.set(
  {"n", "x", "o"},
  "x",
  function()

    -- Eyeliner only adds highlights, nothing else
    require("eyeliner").highlight({ forward = true })


    -- Replicating `f` functionality:
    -- Note: this doesn't work with the dot command

    -- Get a character from the user
    local char = vim.fn.getcharstr()

    -- For repeated calls, e.g., `3f`
    local cnt = vim.v.count1
    while cnt > 0 do
      -- vim's builtin search function
      vim.fn.search(char, "", vim.fn.line("."))
      cnt = cnt - 1
    end

     -- Optional: Set charsearch for repeats using ; and ,
     vim.fn.setcharsearch({ char = char, forward = 1, ["until"] = 0 })
  end
)
```

## Commands
Enable/disable/toggle:
```
:EyelinerEnable
:EyelinerDisable
:EyelinerToggle
```

## Troubleshooting

- To disable eyeliner.nvim on the [nvim-tree](https://github.com/nvim-tree/nvim-tree.lua) plugin, you need to add `nofile` as a disabled buftype to your configuration, i.e., `disable_buftypes = {"nofile"}` and `NvimTree` as a disabled filetype, i.e., `disable_filetypes = {"NvimTree"}`.

## Contributing

The plugin is written using the [Fennel](https://fennel-lang.org) programming language in the `fnl/` directory. The transpiled Lua code is committed along with the original Fennel code in the `lua/` directory, so that Fennel is not a dependency for users. Therefore, for development, you must first have Fennel installed. [See here for instructions](https://fennel-lang.org/setup).

To build the project, simply run `make`, which will transpile the Fennel code into Lua.

This repository uses the [Conventional Commits specification](https://www.conventionalcommits.org/en/v1.0.0/) for commit messages.
