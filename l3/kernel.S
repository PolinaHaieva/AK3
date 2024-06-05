.syntax unified
.cpu cortex-m4
.thumb

#define A #4
#define B #6
#define C #2

.global vtable_kernel
.global __kernel_reset__
.type vtable_kernel, %object
.type __kernel_reset__, %function
.section .interrupt_vector
vtable_kernel:
    .word __stack_start
    .word __kernel_reset__+1
    .size vtable_kernel, .-vtable_kernel
.section .rodata
data: .asciz "Kernel started!\n"
final: .asciz "Value in register #2: "
.section .text
__kernel_reset__:
   ldr r0, =data
   bl dbgput_line
   
	mov r0, A
	mov r1, B
	sub r2, r0, r1
	cmp r2, #0
	it ge
	addge r2, r1, r0
	mov r3, C
	sdiv r2, r3
	
    ldr r0, =final
    bl dbgput
    mov r0, r2
    bl dbgput_num
end:
    b end
