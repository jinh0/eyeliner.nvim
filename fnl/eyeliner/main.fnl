;;; [main.fnl] Main functions: enable, disable, toggle

;; Imports
(local shared (require :eyeliner.shared))
(local always-on (require :eyeliner.always-on))
(local on-key (require :eyeliner.on-key))
(local utils (require :eyeliner.utils))

;; We need to keep track of whether the plugin has been
;; enabled already or not
(var enabled false)

;; For syntax highlighting, we create a namespace which allows us
;; to easily clear all Eyeliner-related highlights
(var ns-id (vim.api.nvim_create_namespace "eyeliner"))

;; TODO: use pcall
(fn enable []
  (if (not enabled)
      (let [opts (. (require :eyeliner.config) :opts)]
        (do
          (utils.create-augroup "Eyeliner" {})
          (shared.enable-highlights)
          (if opts.highlight-on-key
              (on-key.enable)
              (always-on.enable))
          (set enabled true)
          true))
      false))
      
(fn disable []
  (if enabled
      (do 
        (shared.remove-keybinds) ; is this shared?
        (shared.clear-eyeliner)
        (utils.del-augroup "Eyeliner")
        (set enabled false))
      false))

(fn toggle []
  (if enabled (enable) (disable)))


{: enable
 : disable
 : toggle}
