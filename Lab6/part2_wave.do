# set the working dir, where all compiled verilog goes
vlib work

# compile all verilog modules in mux.v to working dir
# could also have multiple verilog files
vlog part2.sv

vsim part2

#log all signals and add some signals to waveform window
log {/*}
# add wave {/*} would add all items in top level simulation module
add wave {/*}

add wave -position insertpoint  \
sim:/part2/C0/current_state
add wave -position insertpoint  \
sim:/part2/C0/next_state
add wave -position end  sim:/part2/D0/alu_a
add wave -position end  sim:/part2/D0/alu_b
add wave -position end  sim:/part2/D0/a
add wave -position end  sim:/part2/D0/b
add wave -position end  sim:/part2/D0/c
add wave -position end  sim:/part2/D0/x
add wave -position end  sim:/part2/D0/alu_select_a
add wave -position end  sim:/part2/D0/alu_select_b

#S_LOAD_A_RST
force Clock 1
force Reset 1
run 10ns

force Clock 0
force Reset 0
run 10ns

force Clock 1
force Go 1
force DataIn 8'b10
run 10ns

force Clock 0
force Reset 0
run 10ns

#S_LOAD_A_WAIT
force Clock 1
force Go 0
run 10ns

force Clock 0
force Reset 0
run 10ns

#S_LOAD_B
force Clock 1
force DataIn 8'b11
force Go 1
run 10ns

force Clock 0
run 10ns

#S_LOAD_B_WAIT
force Clock 1
force Go 0
run 10ns

force Clock 0
run 10ns

#S_LOAD_C
force Clock 1
force Go 1
force DataIn 8'b111
run 10ns

force Clock 0
run 10ns


#S_LOAD_C_WAIT
force Clock 1
force Go 0
run 10ns

force Clock 0
run 10ns

#S_LOAD_X
force Clock 1
force Go 1
force DataIn 8'b001
run 10ns

force Clock 0
run 10ns

#S_LOAD_X_WAIT
force Clock 1
force Go 0
run 10ns

force Clock 0
run 10ns

force Clock 1
force Go 1
run 10ns

force Clock 0
force Go 0
run 10ns

force Clock 1,0 10ns -repeat 20ns
run 100ns





#S_LOAD_A_RST
force Clock 1
force Reset 1
run 10ns

force Clock 0
force Reset 0
run 10ns

force Clock 1
force Go 1
force DataIn 8'b1110
run 10ns

force Clock 0
force Reset 0
run 10ns

#S_LOAD_A_WAIT
force Clock 1
force Go 0
run 10ns

force Clock 0
force Reset 0
run 10ns

#S_LOAD_B
force Clock 1
force DataIn 8'b110
force Go 1
run 10ns

force Clock 0
run 10ns

#S_LOAD_B_WAIT
force Clock 1
force Go 0
run 10ns

force Clock 0
run 10ns

#S_LOAD_C
force Clock 1
force Go 1
force DataIn 8'b101
run 10ns

force Clock 0
run 10ns


#S_LOAD_C_WAIT
force Clock 1
force Go 0
run 10ns

force Clock 0
run 10ns

#S_LOAD_X
force Clock 1
force Go 1
force DataIn 8'b0010
run 10ns

force Clock 0
run 10ns

#S_LOAD_X_WAIT
force Clock 1
force Go 0
run 10ns

force Clock 0
run 10ns

force Clock 1
force Go 1
run 10ns

force Clock 0
force Go 0
run 10ns

force Clock 1,0 10ns -repeat 20ns
run 100ns
