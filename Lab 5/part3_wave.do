# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.sv

vsim shiftRegister

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Start} 1
force {reset} 1
force {clock} 1
run 10ns

force {reset} 0
force {clock} 0
run 10ns

force {clock} 1
force {Data_IN} 12'b101110000000
force {enable} 1
run 10ns

force {clock} 0
force {Start} 0
force {enable} 0
run 10ns

force clock 1,0 10 ns -repeat 20 ns
force enable 1,0 20ns -repeat 40 ns
run 1000 ns