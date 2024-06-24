# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.sv

vsim DisplayCounter

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Reset} 1
force {Clock} 1
run 10ns

force {Reset} 0
force {Clock} 0
run 10ns

force Clock 1 0 ns, 0 10 ns -repeat 20 ns
force EnableDC 1 0ns, 0 2ns -repeat 100 ns
run 500 ns