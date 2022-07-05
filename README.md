# 👀 eyeliner.nvim
Show f/F indicators for faster movement inline. Like [quick-scope.vim](https://github.com/unblevable/quick-scope) but in Lua.

🚧 **WIP: The main functionality should work, but at the current moment, the plugin is very limited in customizability.**

## Setup

Packer:
```lua
use {
  'jinh0/eyeliner.nvim',
  config = function()
    require('eyeliner').setup{}
  end
}
```
