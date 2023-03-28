;;; [main.fnl] Main functions: enable, disable, toggle

(local shared (require :eyeliner.shared))
(local always-on (require :eyeliner.always-on))
(local on-key (require :eyeliner.on-key))
(local utils (require :eyeliner.utils))
(local {: opts} (require :eyeliner.config))

;; We need to keep track of whether the plugin has been enabled already or not
(var enabled false)

(fn enabled? [] enabled)

;; TODO: use pcall
(fn enable []
  (if (not enabled)
      (do (utils.create-augroup "Eyeliner" {})
          (shared.enable-highlights)
          (if opts.highlight_on_key
              (on-key.enable)
              (always-on.enable))
          (if opts.debug (vim.notify "Enabled eyeliner.nvim"))
          (set enabled true)
          true)
      false))
      
(fn disable []
  (if enabled
      (do (let [[y _] (utils.get-cursor)]
            (shared.clear-eyeliner y))
          (utils.del-augroup "Eyeliner")
          (if opts.highlight_on_key (on-key.remove-keybinds))
          (if opts.debug (vim.notify "Disabled eyeliner.nvim"))
          (set enabled false)
          true)
      false))

(fn toggle []
  (if enabled (disable) (enable)))


{: enable
 : disable
 : toggle
 : enabled?}
