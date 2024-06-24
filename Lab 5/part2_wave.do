# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.sv

vsim RateDivider

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Reset} 1
force {ClockIn} 1
force {Speed} 00
run 10ns

force {Reset} 0
force {ClockIn} 0
run 10ns

force ClockIn 1,0 10 ns -repeat 20 ns
run 1000 ns