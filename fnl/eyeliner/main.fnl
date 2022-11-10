;; Utility functions
(local set-autocmd vim.api.nvim_create_autocmd)
(local del-augroup vim.api.nvim_del_augroup_by_name)
(local create-augroup vim.api.nvim_create_augroup)
(local get-current-line vim.api.nvim_get_current_line)

(fn get-cursor []
  (vim.api.nvim_win_get_cursor 0))

(fn get-hl [name]
  (vim.api.nvim_get_hl_by_name name true))

(fn set-hl [name color]
  (vim.api.nvim_set_hl 0 name {:fg color :default true}))


;; Sub-tasks

(fn apply-eyeliner [locations]
  (vim.notify "todo"))

;; traverse through right
(fn traverse [line x]
  (for [i (+ x 1) (# line)]
    (print (line:sub i i))))

(traverse
  (get-current-line)
  (. (get-cursor) 2))

(fn handle-hover []
  (let [line (get-current-line) ; string
        [y x] (get-cursor) ; coordinates
        to-apply (traverse line x)]
    (apply-eyeliner to-apply)))

;; Enable Eyeliner's highlighting
(fn enable-highlights []
  (let [primary (get-hl "Constant")
        secondary (get-hl "Define")]
    (set-hl "EyelinerPrimary" primary.foreground)
    (set-hl "EyelinerSecondary" secondary.foreground)
    (set-autocmd "ColorScheme"
                 {:group "Eyeliner"
                  :callback enable-highlights}))) 

;; Set Eyeliner to listen to keybindings
(fn enable-on-key []
  (vim.notify "todo"))

;; Set Eyeliner to always-on mode
(fn enable-always-on []
  (set-autocmd ["CursorMoved" "WinScrolled" "BufReadPost"]
               {:group "Eyeliner"
                ;; Remember to clear previous highlight!
                :callback handle-hover}))

(fn clear-eyeliner []
  (vim.notify "todo"))

(fn remove-keybinds []
  (let [opts (. (require "eyeliner.config") :opts)]
    (if opts.highlight-on-key
        (print "todo"))))

;; Main functions
(var enabled true)

(fn enable []
  (if (not enabled)
      (let [opts (. (require "eyeliner.config") :opts)]
        (do
          (create-augroup "Eyeliner" {})
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
        (del-augroup "Eyeliner")
        (set enabled false))
      false))

(fn toggle []
  (if enabled (enable) (disable)))

{: enable : disable : toggle}
