#Keyboard: 
#	Reciever Data Register Oxffff0004 (Lowest 8 bit)
#	Reciever Control Register 0xffff0000 (Lowest 1 bit)

#Display:
#	Trasmit Control Register: 0xffff0008 (Lowest 1 bit)
#	Transmit Data regiester: 0xffff000c (Lowest 8 bit)

.global _start
.text
_start:
# Loop and set the ready bit of display to ready bit of keyboard
# Loop and set the Data of display to data of keyboard
SETUP:	li s1, 0xffff0000 # Keyboard Control Register
	li s2, 0xffff0004 # Keyboard Data Register
	
	li s3, 0xffff0008 # Display Control Register
	li s4, 0xffff000c # Display Data Register
	
	addi t6, zero, 1
	
LOOP: 	lw t1, 0(s1) #Load keyboard control register
	beq t1, t6, KB_ON
	j LOOP
KB_ON:	#Data is now in control register
	lw t2, 0(s3)
	beq t2, t6, DIS_ON
	j LOOP
DIS_ON: #Display can now recieve data
	lw t3, 0(s2)
	sw t3, 0(s4) #display data on display
	j LOOP
END:
	ebreak
# Ask about if its supposed to stop at all?
