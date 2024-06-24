# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part1_template.sv

vsim part1

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force Clock 1
force Reset 1
run 10ns

force Clock 0
force Reset 0
run 10ns

#test the z = 0
force Clock 1,0 10ns -repeat 20ns
force w 0
run 100ns

#test the z = 1 case A
force Clock 1,0 10ns -repeat 20ns
force w 1
run 100ns

force Clock 1,0 10ns -repeat 20ns
force w 0
run 100ns

#test the z = 1 case B
force Clock 1,0 10ns -repeat 20ns
force w 1, 0 10ns, 1 20ns
run 100ns

force Clock 1,0 10ns -repeat 20ns
force w 0
run 100ns

#test the z = 1
force Clock 1,0 10ns -repeat 20ns
force w 1
run 100ns

#test the z = 1
force Clock 1,0 10ns -repeat 20ns
force w 0, 1 10ns
run 100ns

