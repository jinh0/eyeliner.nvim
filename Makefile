src_files = $(wildcard fnl/eyeliner/*.fnl)
out_files = $(src_files:fnl/eyeliner/%.fnl=lua/eyeliner/%.lua)

compile: $(out_files)

lua/eyeliner/%.lua: fnl/eyeliner/%.fnl
	fennel --compile $< > $@
