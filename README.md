# 👀 eyeliner.nvim
Move faster with unique `f`/`F` indicators for each word on the line.
Like [quick-scope.vim](https://github.com/unblevable/quick-scope) but in Lua.

(Requires Neovim 0.7+)

🚧 **WIP: The plugin is still in its early stages, feel free to create an issue or a PR!**

## Demo
In the demo, the orange letters indicate the unique letter in the word that you can jump to with `f`/`F` right away.
Blue letters indicate that there is no unique letter in the word, but you can get to it with `f`/`F` and then a repeat with `;`.

https://user-images.githubusercontent.com/40512164/178066018-0d3fa234-a5b5-4a41-a340-430e8c4c2739.mov

## Install
Using [vim-plug](https://github.com/junegunn/vim-plug):
```vim
Plug 'jinh0/eyeliner.nvim'
```

Using [packer.nvim](https://github.com/wbthomason/packer.nvim):
```lua
use 'jinh0/eyeliner.nvim'
```

or with setup options:
```lua
use {
  'jinh0/eyeliner.nvim',
  config = function()
    require('eyeliner').setup {
      bold = true
    }
  end
}
```

## Highlighting
You can customize the highlight colors and styles with the `EyelinerPrimary` and `EyelinerSecondary` highlight groups, for instance:

In Vimscript:
```vim
highlight EyelinerPrimary guifg='#afff5f' gui=underline,bold
highlight EyelinerSecondary gui=underline
```

In Lua:
```lua
vim.api.nvim_set_hl(0, 'EyelinerPrimary', { fg = '#afff5f', bold = true, underline = true })
vim.api.nvim_set_hl(0, 'EyelinerSecondary', { underline = true })
```
<!--
## Configuration
Currently, eyeliner.nvim supports bold and underline options:

```lua
require('eyeliner').setup {
  bold = true, -- Default: false
  underline = true -- Default: false
}
```

<details>
<summary>
Bold & Underline:
</summary>

![Bold & underline](https://user-images.githubusercontent.com/40512164/178532882-2e50ccf6-4134-48df-bd2c-e61e099d00b0.png)

</details>
-->
