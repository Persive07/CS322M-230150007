# 1101 Mealy Sequence Detector

A **Mealy FSM** that detects the serial bit pattern **`1101`** on a **1-bit-per-clock** input (`din`), with **overlap allowed**.  
When the last `1` of `1101` arrives, the module pulses **`y`** high for **exactly one clock**.

---

## Files

- **seq_detect_mealy.v** — DUT (Mealy FSM, synchronous active-high reset).
- **tb_seq_detect_mealy.v** — self-checking testbench, clock gen, reset, bitstream stimulus, waveform dump.

---

## How to Run

### 1. Compile

    iverilog -o sim.out tb_seq_detect_mealy.v


### 2. Run the simulation 
    vvp sim.out


### 3. Open the waveform in GTKWave
    gtkwave dump.vcd


### 4. In GTKWave, add these signals to the waveform viewer:
- **`tb_seq_detect_mealy.clk`** (or just `clk`)
- **`tb_seq_detect_mealy.rst`** (or `rst`)
- **`tb_seq_detect_mealy.din`** (or `din`)
- **`tb_seq_detect_mealy.y`** (or `y`)

---

## Testbench Behaviour & Expected Results

### Input Bitstream:
    bitstream = 11’b11011011101;


### Indexed Bits:
    bits: 1 1 0 1 1 0 1 1 1 0 1
    idx : 1 2 3 4 5 6 7 8 9 10 11


### Pattern Detection:
Matches of **`1101`** occur at these indices:

- **window (1..4) = 1101** → `y` pulses **high** when bit index **4** is sampled  
- **window (4..7) = 1101** → `y` pulses **high** when bit index **7** is sampled  
- **window (8..11) = 1101** → `y` pulses **high** when bit index **11** is sampled  

So you should see y high for exactly one clock at those sampling instants.


