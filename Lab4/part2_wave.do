# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.sv

#load simulation using mux as the top level simulation module
vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Reset_b} 1
force {Data} 4'b0000
force {Function} 2'b11
force {Clock} 1
run 10ns

force {Reset_b} 0
force {Data} 4'b0000
force {Function} 2'b11
force {Clock} 0
run 10ns

force {Reset_b} 0
force {Data} 4'b1000
force {Function} 2'b00
force {Clock} 0
run 10ns

force {Reset_b} 0
force {Data} 4'b1010
force {Function} 2'b11
force {Clock} 1
run 10ns

force {Reset_b} 0
force {Data} 4'b1010
force {Function} 2'b00
force {Clock} 0
run 10ns

force {Reset_b} 0
force {Data} 4'b1010
force {Function} 2'b11
force {Clock} 1
run 10ns

force {Reset_b} 0
force {Data} 4'b1111
force {Function} 2'b01
force {Clock} 0
run 10ns

force {Reset_b} 0
force {Data} 4'b1111
force {Function} 2'b11
force {Clock} 1
run 10ns

force {Reset_b} 0
force {Data} 4'b0110
force {Function} 2'b10
force {Clock} 0
run 10ns


force {Reset_b} 0
force {Data} 4'b1111
force {Function} 2'b11
force {Clock} 1
run 10ns
