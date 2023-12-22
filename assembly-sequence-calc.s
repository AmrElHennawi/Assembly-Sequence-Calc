.intel_syntax noprefix

.section .data
n: .int 0
n_double: .double 0.0
one: .double 1.0
denominator: .double 1.0
temp: .double 1.0
product: .double 1.0
outputf: .asciz "The value of n is %f\n"
input_format: .asciz "%d"  

.section .text
.globl _main

_main:
    push OFFSET n
    push OFFSET input_format

    call _scanf
    add ESP, 8 

    MOV ECX, n     
loop_convert_to_double:
    FLD QWORD PTR [n_double]  
    FADD QWORD PTR [one]      
    FSTP QWORD PTR [n_double] 

    LOOP loop_convert_to_double

#  The program should take the following inputs from the user:
# * An integer n.
# * n floating point numbers (Use the "double" type. Do not use "float" type.)
# The program should output ((n) + 1/1) * ((n-1) + 1/2) * ((n-2) + 1/3) * ((n-3) + 1/4) * ... * (2 + 1/(n-1)) * (1 + 1/(n)).


    MOV ECX, n
main_calculation_loop:
    FLD QWORD PTR [one]
    FDIV QWORD PTR [denominator]
    FADD QWORD PTR [n_double]
    FSTP QWORD PTR [temp]
    FLD QWORD PTR [product]
    FMUL QWORD PTR [temp]
    FSTP QWORD PTR [product]

    FLD QWORD PTR [denominator]
    FADD QWORD PTR [one]
    FSTP QWORD PTR [denominator]
    
    FLD QWORD PTR [n_double]
    FSUB QWORD PTR [one]
    FSTP QWORD PTR [n_double]

    LOOP main_calculation_loop
    


    push [product+4]
    push [product]

    push OFFSET outputf
    call _printf
    add ESP, 12

    ret
