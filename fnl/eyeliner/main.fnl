(var ns-id (vim.api.nvim_create_namespace "eyeliner"))
(local utils (require :eyeliner.utils))
(local liner (require :eyeliner.liner))

;; Sub-tasks
(fn apply-eyeliner [locations] nil)

(fn hl-words [scores]
  (each [idx val (ipairs scores)]
    nil)
  scores)
    
;; traverse through right
(fn traverse [line x]
  (let [scores (liner.get-scores line x)]
    (hl-words scores)))

(fn handle-hover []
  (let [line (get-current-line) ; string
        [y x] (get-cursor) ; coordinates
        to-apply (traverse line x)]
    (apply-eyeliner to-apply)))

;; Enable Eyeliner's highlighting
(fn enable-highlights []
  (let [primary (utils.get-hl "Constant")
        secondary (utils.get-hl "Define")]
    (utils.set-hl "EyelinerPrimary" primary.foreground)
    (utils.set-hl "EyelinerSecondary" secondary.foreground)
    (utils.set-autocmd "ColorScheme"
                 {:group "Eyeliner"
                  :callback enable-highlights}))) 

;; Set Eyeliner to listen to keybindings
(fn enable-on-key []
  (vim.notify "todo"))

;; Set Eyeliner to always-on mode
(fn enable-always-on []
  (vim.notify "always on")
  (utils.set-autocmd ["CursorMoved" "WinScrolled" "BufReadPost"]
               {:group "Eyeliner"
                :callback handle-hover}))

(fn clear-eyeliner []
  (vim.notify "todo: clear-eyeliner"))

(fn remove-keybinds []
  (let [opts (. (require "eyeliner.config") :opts)]
    (if opts.highlight-on-key
        (print "todo: remove-keybinds"))))

;; Main functions
(var enabled false)

(fn enable []
  (if (not enabled)
      (let [opts (. (require "eyeliner.config") :opts)]
        (do
          (utils.create-augroup "Eyeliner" {})
          (enable-highlights)
          (if opts.highlight-on-key
              (enable-on-key)
              (enable-always-on))
          (set enabled true)
          true))
      false))
      
(fn disable []
  (if enabled
      (do 
        (remove-keybinds)
        (clear-eyeliner)
        (utils.del-augroup "Eyeliner")
        (set enabled false))
      false))

(fn toggle []
  (if enabled (enable) (disable)))

{: enable : disable : toggle}
