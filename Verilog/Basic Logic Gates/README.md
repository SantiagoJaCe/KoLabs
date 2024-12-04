# Logic Gates Library

This folder contains a collection of logic gates implemented in Verilog, starting from the **NAND gate** and building up to more complex gates.

## Why?

This project is an implementation of the logic gate hierarchy described in **"The Elements of Computing Systems"**, the project aims to construct all necessary logic gates to eventually design a functioning computer, step by step. Each gate is built using the **NAND gate** as the fundamental building block, adhering to the principle that any logic circuit can be constructed using NAND gates alone.

The library is structured to promote clarity and reusability, making it easier to extend the collection with new gates or integrate them into larger circuits.

## File Naming Convention

To maintain clarity and organization, files follow this naming convention:

- `<GateName>_module.v` - The Verilog module for the gate (e.g., `sAND_module.v`).
- `<GateName>_TB.v` - The testbench for verifying the gate's functionality (e.g., `sAND_TB.v`).
