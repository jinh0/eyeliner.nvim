vim.api.nvim_create_user_command('EyelinerEnable', function () require('eyeliner').enable() end, {})
vim.api.nvim_create_user_command('EyelinerDisable', function () require('eyeliner').disable() end, {})
vim.api.nvim_create_user_command('EyelinerToggle', function () require('eyeliner').toggle() end, {})

require('eyeliner').setup({ highlight_on_key = false, debug = true })
require('eyeliner').enable()
