.data
.global string1
string1:
	.ascii	"The Fibonacci number of %d is %d!\n\0"
string2:
	.ascii	"Entering fib() with n=%d\n\0"

.text
.extern printf
.global main
main:
### SET UP FRAME RECORD ###
# Save FP and LR with pre-indexing, allocated another 16 bytes for temp.
stp	x29, x30, [sp, -16]!
# Set FP
add	x29, sp, 0

### MAIN() LOGIC ###
# Call fib
mov	x0, 13
bl	fib
# Respond with prompt
add	x2, x0, 0
mov	x1, 13
ldr	x0, =string1
bl	printf

### TAKE DOWN FRAME RECORD ###
ldp	x29, x30, [sp], 16
mov	w0, 0
ret

.global fib
fib:
### SET UP FRAME RECORD ###
# Save FP and LR with pre-indexing, allocated another 16 bytes for temp.
stp	x29, x30, [sp, -32]!
# Set FP
add	x29, sp, 0
# Shadow input argument
str	x0, [sp, 16]

### SOME PROMPTS ###
ldr	x0, =string2
ldr	x1, [sp, 16]
bl printf

### LOGIC FOR FIB() ###
ldr	x0, [sp, 16]
cmp	x0, 1
ble 	return

 
#calculate fib(n-2)
sub	x0, x0, 2
bl	fib
str	x0, [sp, 24] 


# calculate fib(n -1)
ldr x0, [sp, 16]
sub x0,x0, 1
bl fib

# fib(n-1)+fib(n-2)
ldr x1, [sp, 24]	
add x0, x0, x1



return:
ldp	x29, x30, [sp], 32
ret
