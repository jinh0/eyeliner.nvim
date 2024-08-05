(local config (require :eyeliner.config))
(local main (require :eyeliner.main))
(local {: highlight} (require :eyeliner.on-key)) 

{:setup config.setup
 :enable main.enable
 :disable main.disable
 :toggle main.toggle
 : highlight}
