# AND Gate – SystemVerilog

## Overview

This project implements a **2-input AND gate** using SystemVerilog.

An AND gate produces a HIGH (`1`) output only when **both inputs are HIGH**.

## Logic

The Boolean expression for an AND gate is:

Y = A · B

## Truth Table

| A | B | Y |
|---|---|---|
| 0 | 0 | 0 |
| 0 | 1 | 0 |
| 1 | 0 | 0 |
| 1 | 1 | 1 |

## Files

- `and_gate.sv` – AND gate design
- `and_gate_tb.sv` – Testbench for verifying the design
- `simulation_output.png` – Simulation console output
- `waveform_output.png` – Simulation waveform

## Verification

The testbench checks all possible input combinations.

Since the circuit has 2 inputs:

**2² = 4 combinations**

The design was simulated and verified using:

- Console output
- Waveform

## Tools Used

- SystemVerilog
- EDA Playground

## Learning Outcome

This project helped me understand:

- Basic SystemVerilog module structure
- `logic` data type
- AND operator (`&`)
- Testbench creation
- `for` loop for exhaustive input testing
- Simulation and waveform verification
