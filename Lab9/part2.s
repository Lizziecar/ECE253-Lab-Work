0# Timer
# Up counter that counts up from 0 to TIMECMP
# Fires interrupt once the value is reached

# Interrupts
# Done using CSRs
# 1. address of interupt handler in utvec CSR (address of the actual code)
# 2. BIT 4 of uie csr must be set to 1 to enable timer interrupt
# 3. Bit 0 of ustatus csr must be set to 1 to enable user level interupts
# Writing to CSRs: 

# csrrw <dst register> , <CSR>, <SRC register>



.data

# Messages
msg_1: .asciz "Please"
msg_2: .asciz "water "
msg_3: .asciz "rest  "

# Timer Related
timeNow: .word 0xFFFF0018 # current time
cmp:	 .word 0xFFFF0020 # time for new interrupt

# Display related
OUT_CTRL: .word 0xffff0008
OUT: .word 0xffff000C

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
	
	#load messages
	la s3, msg_1 #message 1
	la s4, msg_2 #message 2
	la s5 msg_3 #message 3
	
	#load display
	lw s6, OUT_CTRL #display control
	lw s7, OUT #display value
	
	addi t4, zero, 0 # pick which message
	#Beq comparisons
	addi t1, zero, 1
	addi t2, zero, 2
	addi t3, zero, 3
	addi a0, zero, 6 #capactiy of message
	
	# Loop over messages
LOOP: 	lw t5, (s6) #control value
	beq t5, t1 DISP_ON #display is on
	j LOOP
DISP_ON:beq t4, t1, MSG1
	beq t4, t2, MSG2
	beq t4, t3, MSG3
	j LOOP
MSG1: 	lb t6, 0(s3)
	sw t6, 0(s7) #display data on display
	beqz a0, FINISH
	addi a0, a0, -1
	addi s3, s3, 1
	j LOOP
MSG2:	lb t6, 0(s4)
	sw t6, 0(s7) #display data on display
	beqz a0, FINISH
	addi a0, a0, -1
	addi s4, s4, 1
	j LOOP
MSG3: 	lb t6, 0(s5)
	sw t6, 0(s7) #display data on display
	beqz a0, FINISH
	addi a0, a0, -1
	addi s5, s5, 1
	j LOOP
FINISH: j LOOP

time_handler:
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
	
	# Indicate that 5 seconds have passed
	#reset values
	addi a0, zero, 32
	la s3, msg_1 #message 1
	la s4, msg_2 #message 2
	la s5 msg_3 #message 3
	
	#change message
	beq t4, t3 toONE
	addi t4, t4, 1
	j RETURN
toONE:	addi t4, zero, 1
	j RETURN
	
RETURN:	# Pop registers from the stack
	lw t0, 0(sp)
	lw t1, 4(sp)
	lw t2, 8(sp)
	lw s0, 12(sp)
	lw s1, 16(sp)
	addi sp, sp, 20
	uret #return to uepc to pc when interrupt occured
