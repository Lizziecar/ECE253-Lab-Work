# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part3.sv

vsim part3

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

force {Reset} 1
force {ClockIn} 1
run 10ns

force {Reset} 0
force {ClockIn} 0
force {Letter} 011
run 10ns

force {ClockIn} 1
force {Start} 1
run 10ns

force {ClockIn} 0
force {Start} 0
run 10ns

force ClockIn 1 0 ns, 0 10 ns -repeat 20 ns
run 60000 ns

force {Reset} 1
force {ClockIn} 1
run 10ns

force {Reset} 0
force {ClockIn} 0
force {Letter} 100
run 10ns

force {ClockIn} 1
force {Start} 1
run 10ns

force {ClockIn} 0
force {Start} 0
run 10ns

force ClockIn 1 0 ns, 0 10 ns -repeat 20 ns
run 60000 ns

force {Reset} 1
force {ClockIn} 1
run 10ns

force {Reset} 0
force {ClockIn} 0
force {Letter} 010
run 10ns

force {ClockIn} 1
force {Start} 1
run 10ns

force {ClockIn} 0
force {Start} 0
run 10ns

force ClockIn 1 0 ns, 0 10 ns -repeat 20 ns
run 60000 ns

force {Reset} 1
force {ClockIn} 1
run 10ns

force {Reset} 0
force {ClockIn} 0
force {Letter} 000
run 10ns

force {ClockIn} 1
force {Start} 1
run 10ns

force {ClockIn} 0
force {Start} 0
run 10ns

force ClockIn 1 0 ns, 0 10 ns -repeat 20 ns
run 60000 ns

force {Reset} 1
force {ClockIn} 1
run 10ns

force {Reset} 0
force {ClockIn} 0
force {Letter} 101
run 10ns

force {ClockIn} 1
force {Start} 1
run 10ns

force {ClockIn} 0
force {Start} 0
run 10ns

force ClockIn 1 0 ns, 0 10 ns -repeat 20 ns
run 60000 ns

