# 👀 eyeliner.nvim
Move faster with unique `f`/`F` indicators for each word on the line.
Like [quick-scope.vim](https://github.com/unblevable/quick-scope) but in Lua.

🚧 **WIP: The main functionality should work, but at the current moment, the plugin is very limited in customizability.**

## Demo
In the demo, the orange letters indicate the unique letter in the word that you can jump to with `f`/`F` right away.
Blue letters indicate that there is no unique letter in the word, but you can get to it with `f`/`F` and then a repeat with `;`.

https://user-images.githubusercontent.com/40512164/178066018-0d3fa234-a5b5-4a41-a340-430e8c4c2739.mov

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
