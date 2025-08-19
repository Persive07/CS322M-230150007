# Traffic Light Controller Mealy FSM

A **Mealy finite state machine** controlling a traffic light system with North-South (NS) and East-West (EW) directions.  
The FSM cycles through the states **NS Green**, **NS Yellow**, **EW Green**, and **EW Yellow**, with timed phase lengths controlled by an external **tick** pulse.

- **Reset:** Synchronous, active-high.
- **Tick:** 1-cycle pulse input controlling FSM timing.
- **Outputs:** Green (`_g`), Yellow (`_y`), and Red (`_r`) signals for both NS and EW directions.  
  Exactly one color is active per direction at any time.

---

## Files

- **traffic_light.v** — DUT (Mealy FSM, synchronous active-high reset).
- **tb_traffic_light.v** — self-checking testbench with clock generation, reset logic, tick pulse generation, waveform dump, and console logging.

---

## How to Run

### 1. Compile

iverilog -o sim.out tb_traffic_light.v traffic_light.v


### 2. Run the Simulation

vvp sim.out


### 3. Open the Waveform in GTKWave

gtkwave dump.vcd


### 4. In GTKWave, add these signals to the waveform viewer:

- `clk`
- `rst`
- `tick`
- `ns_g`, `ns_y`, `ns_r`
- `ew_g`, `ew_y`, `ew_r`

---

## Testbench Behaviour & Observed Results

- **Clock frequency:** 100 MHz (10 ns period).
- **Tick frequency:** 1 tick every 20 clock cycles (200 ns tick period), simulating slower phase changes.
- **Phase durations (in ticks):**  
  - Green phases last 5 ticks  
  - Yellow phases last 2 ticks  
- **FSM cycles through states:**  
  - NS Green → NS Yellow → EW Green → EW Yellow → NS Green → ...

- Console logs print at each tick showing the active light color signals for NS and EW.

- Waveform displays transitions of the light signals synchronized with the tick pulses, demonstrating the state sequence accurately.

---


