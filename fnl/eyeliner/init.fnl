(local config (require :eyeliner.config))
(local main (require :eyeliner.main))

{:setup config.setup
 :enable main.enable
 :disable main.disable
 :toggle main.toggle}
