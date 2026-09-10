# ALU Spec

## Ports
- a[3:0]        : operand A
- b[3:0]        : operand B
- op_sel[2:0]   : operation select
- result[3:0]   : output result
- zero          : 1 if result == 0
- carry         : overflow (ADD) / borrow (SUB) / 0 for all other ops

## Operations
| op_sel | Operation | Notes                               |
|--------|-----------|-------------------------------------|
| 000    | ADD       | result = a + b, carry = overflow    |
| 001    | SUB       | result = a - b, carry = borrow      |
| 010    | AND       | bitwise                             |
| 011    | OR        | bitwise                             |
| 100    | XOR       | bitwise                             |
| 101    | NOT A     | bitwise complement of a (b ignored) |
| 110    | SHL       | a shifted left 1, LSB = 0           |
| 111    | SHR       | a shifted right 1, MSB = 0          |