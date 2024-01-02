# Assembly-Sequence-Calc

This repository contains a 32-bits Intel-syntax assembly program that performs a mathematical computation based on user inputs.

## Program Description

The program takes the following inputs from the user:

1. An integer `n`.
2. `n` floating-point numbers (using the "double" type, not "float").

The program's objective is to output the result of the following mathematical expression:

\[((n) + \frac{1}{1}) \times ((n-1) + \frac{1}{2}) \times ((n-2) + \frac{1}{3}) \times \ldots \times (2 + \frac{1}{(n-1)}) \times (1 + \frac{1}{n})\]

## Example

For instance, if the user inputs `3`, the program should output: `13.333`


## How to Run

To run the assembly program, follow these steps:

1. Download MinGW from [here](https://osdn.dl.osdn.net/mingw/68260/mingw-get-setup.exe).
2. Add the MinGW `bin` directory to the system Path environment variable.
3. Open a terminal in the folder containing the assembly file.
4. Compile the assembly program using the following command:

    ```bash
    gcc -O3 -o assembly-sequence-calc .\assembly-sequence-calc.s
    ```

5. Run the compiled program:

    ```bash
    .\assembly-sequence-calc
    ```

## Authors
- [Amr Khaled El-sayed El-hennawi](https://github.com/AmrElhennawi)
- [Aya Ashraf Shaban Mohamed](https://github.com/AyaAshraf21)
- [Salma Abdelaziz Nabih Soliman](https://github.com/Salmaabdelaziz271)
- [Yehia Mohamed Yehia Mostafa](https://github.com/Yahya-Ehab)
- [Sama Ahmed Saied Khalel](https://github.com/SamaAhmedS)



