# Vending Machine Mealy FSM (with Change)

A **Mealy finite state machine** implementing a vending machine for coins where the **goal price is 20**.  
Accepts coins of **5** or **10** (coin input: `01=5`, `10=10`, `00=idle`).  
When the running total reaches **20 or more**, the module pulses **`dispense`** high for **exactly one clock**.  
If the total is **25**, the module also pulses **`chg5`** high for one clock.  
After vending, the total resets to zero.  
**Reset is synchronous and active-high.**

---

## Files

- **vending_mealy.v** — DUT (Mealy FSM, synchronous active-high reset).
- **tb_vending_mealy.v** — self-checking testbench, clock gen, reset, coin stimulus, waveform dump.

---

## How to Run

### 1. Compile

iverilog -o sim.out tb_vending_mealy.v

### 2. Run the Simulation

vvp sim.out

### 3. Open the Waveform in GTKWave

gtkwave dump.vcd


### 4. In GTKWave, add these signals to the waveform viewer:

- **`tb_vending_mealy.clk`** (or just `clk`)
- **`tb_vending_mealy.rst`** (or `rst`)
- **`tb_vending_mealy.coin`** (or `coin`)
- **`tb_vending_mealy.dispense`** (or `dispense`)
- **`tb_vending_mealy.chg5`** (or `chg5`)

---

## Testbench Behaviour & Expected Results

#### Test Sequences:

1. **Insert 5, 5, 10**  
    Total: 5 + 5 + 10 = 20  
    - **Dispense = 1** pulse (when total hits 20)

2. **Insert 10, 10**  
    Total: 10 + 10 = 20  
    - **Dispense = 1** pulse (when total hits 20)

3. **Insert 10, 5, 10**  
    Total: 10 + 5 + 10 = 25  
    - **Dispense = 1** pulse (when total hits/exceeds 20)
    - **chg5 = 1** pulse (when returning 5 as change)

Each pulse is **high for one clock** at the instant vending or change occurs, as required and shown in the waveform.

---

## State Diagram Justification

- **States encode running totals:**  
    - `init`: total = 0  
    - `s5`: total = 5  
    - `s10`: total = 10  
    - `s15`: total = 15

- **Mealy FSM chosen:**  
    *Outputs (`dispense`, `chg5`) depend on both state and coin input, reducing state count versus Moore.*

---

## Waveform Highlights

- Look for **`dispense`** and **`chg5`** pulses in test scenarios above.
- Pulses are **single-cycle and overlap with corresponding coin input transitions** indicating successful vending and change events.

✅ This FSM efficiently implements the required vending logic with minimal states and uses Mealy output logic for optimal design.

