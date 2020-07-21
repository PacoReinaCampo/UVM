all: build

build:
	@if [ ! -e work ]; then vlib work; fi
	@vlog -sv -stats=none -f system.vc \
	+incdir+../../../../src +define+UVM_CMDLINE_NO_DPI +define+UVM_REGEX_NO_DPI
	vsim -c -do run.do work.testbench
