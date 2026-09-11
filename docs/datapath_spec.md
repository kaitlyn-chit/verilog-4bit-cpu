# Datapath Spec

The datapath is the set of modules that hold and move data through the CPU
(as opposed to the control unit, which decides *when* things happen).

## Components

### Accumulator (reg4.v)
The CPU's one working register (ACC). Holds the running result of computations.
Synchronous reset, load-enabled. Fed by the ALU's result output; read by the ALU
as an input operand for the next operation.

### Program Counter (pc.v)
Tracks the address of the current instruction. Normally increments by 1 each
cycle; overridden to jump to a specific address when a JMP/JZ instruction executes.

### Instruction Memory (instr_mem.v)
Read-only lookup: given the current PC value, returns the instruction word stored
at that address.

### Data Memory (data_mem.v)
Read/write storage for the CPU's data (separate from instructions). LOAD/STORE
instructions read from and write to this memory.