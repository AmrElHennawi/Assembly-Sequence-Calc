.intel_syntax noprefix

.section .data
n: .int 0                                                   # Initialize  n to 0
n_double: .double 0.0                                       # Initialize  n_double to 0.0
one: .double 1.0                                            # Initialize  one to 1.0
denominator: .double 1.0                                    # Initialize  denominator to 1.0
temp: .double 1.0                                           # Initialize  temp to 1.0
product: .double 1.0                                        # Initialize  product to 1.0
outputf: .asciz "The value of n is %f\n"                    # Format string for printf
input_format: .asciz "%d"                                   # Format string for scanf  


.section .text
.globl _main

_main:
    push OFFSET n                                 # push to stack the address of the integer variable n to scanf (second parameter)
    push OFFSET input_format                      # push to stack the address of input_format to scanf (first parameter)

    call _scanf                                   # call scanf to read an integer from user input, it will use the two parameters on the top of the stack in the reverse order
    add ESP, 8                                    # remove the above two parameters from the stack

    MOV ECX, n                                    # Move the value of n to ECX register(the number of iterations)
loop_convert_to_double:
    FLD QWORD PTR [n_double]                      # Load the value of n_double onto the floating point stack
    FADD QWORD PTR [one]                          # Add the value of one to the floating point stack
    FSTP QWORD PTR [n_double]                     # Store the result in n_double

    LOOP loop_convert_to_double                   # Loop until ECX becomes zero

#  The program should take the following inputs from the user:
# * An integer n.
# * n floating point numbers (Use the "double" type. Do not use "float" type.)
# The program should output ((n) + 1/1) * ((n-1) + 1/2) * ((n-2) + 1/3) * ((n-3) + 1/4) * ... * (2 + 1/(n-1)) * (1 + 1/(n)).


    MOV ECX, n                                   # Move the value of n to ECX(the number of iterations)
main_calculation_loop:
    FLD QWORD PTR [one]                          # Load the value of one to the floating point stack
    FDIV QWORD PTR [denominator]                 # Divide it by the value of denominator
    FADD QWORD PTR [n_double]                    # Add the value of n_double to the result
    FSTP QWORD PTR [temp]                        # Store the result in temp

    FLD QWORD PTR [product]                     # Load the value of product to the floating point stack
    FMUL QWORD PTR [temp]                       # Multiply it by the value in temp
    FSTP QWORD PTR [product]                    # Store the result in product

    FLD QWORD PTR [denominator]                 # Load the value of denominator to the floating point stack
    FADD QWORD PTR [one]                        # Add the value of one to the floating point stack
    FSTP QWORD PTR [denominator]                # Store the result in denominator
    
    FLD QWORD PTR [n_double]                    # Load the value of n_double to the floating point stack
    FSUB QWORD PTR [one]                        # Subtract the value of one from the result
    FSTP QWORD PTR [n_double]                   # Store the result in n_double

    LOOP main_calculation_loop                  # Loop until ECX becomes zero



    push [product+4]                            # Push to stack the high 32-bits of product 
    push [product]                              # Push to stack the low 32-bits of product 

    push OFFSET outputf                         # Push to stack the first parameter to printf
    call _printf                                # Call printf to print the result
    add ESP, 12                                 # remove the above two parameters from the stack

    ret                                         # Return from the main function
