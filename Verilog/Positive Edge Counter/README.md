### PositiveEdgeCounter

**Description**  
This folder contains my **first analyzed Verilog project**, a **4-bit synchronous up counter** with a complete **testbench** for simulation.
---

**Details**  
- **Objective**: To design and test a **positive edge-triggered counter** that:
  - Resets to `0` when `reset` is active.
  - Increments its value on every rising clock edge when `enable` is active.
- **Features**:
  - A testbench that includes:
    - A **clock generator**.
    - Control signals for `reset` and `enable`.
    - **Waveform dumping** for visualizing signal behavior in a simulation viewer like GTKWave.
  - Design includes **reset logic**, **enable logic**, and non-blocking assignments for sequential updates.

---

### 🔍 **Key Features**

#### **Counter Design (`PositiveEdgeCounter.v`)**
- **Clock-Driven Updates**: The counter updates on the rising edge of the clock (`posedge clock`).
- **Reset Logic**: Clears the counter to `0` when `reset` is active.
- **Enable Logic**: Increments the counter only when `enable` is active.

#### **Testbench (`PositiveEdgeCounter_TB.v`)**
- **Clock Generator**: A clock signal toggling every 5 time units.
- **Reset and Enable Control**: Stimulus to simulate different scenarios (reset, increment, etc.).
- **Monitoring**: Prints signal values to the terminal for verification.
- **Waveform Generation**: Dumps signals into a `.vcd` file for visualization.
