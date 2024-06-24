.data

# Timer Related
timeNow: .word 0xFFFF0018 # current time
cmp:	 .word 0xFFFF0020 # time for new interrupt

.global _start
.text
_start:
main: 
	# Set time to trigger interrupt to be 5000 milliseconds (5 seconds)
	lw s0, cmp 
	li s1, 5000 #5000 milliseconds
	sw s1, 0(s0) #set timer value for interupt
	
	# Set handler address and enable interrupts
	la t0, time_handler
	csrrw zero, utvec, t0 #set utvec to the handler code address
	csrrsi zero, ustatus, 0x1 #set interupt enable bit 0001
	csrrsi zero, uie, 0x10 #set  bit 4 in uie to enable timer interrupt 1000
	
	addi s9, zero, 0
	
LOOP: 
	addi s10, s10, 1
	j LOOP
	
time_handler:
	addi s9, s9, 1
	
	# Push registers to the stack
	addi sp, sp, -20 #store on stack
	sw t0, 0(sp)
	sw t1, 4(sp)
	sw t2, 8(sp)
	sw s0, 12(sp)
	sw s1, 16(sp)
	
	
	# Set new interrupt time 
	li t0, 5000 #create new interupt time (5000 more seconds)
	lw t1, timeNow
	lw s0, cmp
	lw t2, 0(t1)
	add s1, t2, t0
 	sw s1, 0(s0) #set timecmp
 	
 	addi s9, s9, 1
	
RETURN:	# Pop registers from the stack
	lw t0, 0(sp)
	lw t1, 4(sp)
	lw t2, 8(sp)
	lw s0, 12(sp)
	lw s1, 16(sp)
	addi sp, sp, 20
	uret #return to uepc to pc when interrupt occured
