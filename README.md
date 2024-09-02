## SHA256 System
### Lab 2 -- descirbe and simulate the building blocks for the system
- Implementation of Sig_Maj_Ch block

### Lab 3 
#### Hash Core Logic
- Implementation of Hash Core Logic
- Timing analyses at different clock frequencies
![image](https://github.com/user-attachments/assets/59a49fec-8df8-495a-b913-28af49958bb0)

#### Implementation of 5 order polynomial approximation to sin(x) with/without pipeline
- Pipeline : insert registers at every operation to balance the pathway

### Lab 4 Final Implementation
#### 1. Start Platform Designer
- Navigate to **`Tools` -> `Qsys` -> `System Contents Pane`**.

#### 2. Add Components
- **Processors and Peripherals**:
  - Go to **`Library` -> `Processors and Peripherals` -> `Hard Processor Systems`**.
  - Select **`Arria V/Cyclone V Hard Processor System`** and add it.
- **On Chip Memory**:
  - Go to **`Library` -> `Basic Functions` -> `On Chip Memory`**.
  - Add **`On chip memory (RAM or ROM)`**.
- **PIO (Parallel I/O)**:
  - Go to **`Library` -> `Processors and Peripherals` -> `PIO (Parallel I/O)`**.
  - Add the required **PIO components**.

#### 3. Connect Components
- **Memory Connections**:
  - Connect **`h2f_axi_master`** (HPS to FPGA) to **`s1`** under **`onchip_memory2_0`**.
- **PIO Connections**:
  - Connect **`s1`** under **`pio 0`**, **`pio 1`**, and **`pio 2`** to **`h2f_lw_axi_master`** (Light Weight HPS to FPGA).
- **Clock and Reset Signals**:
  - Connect all components' clock and reset signals to the **`clock` component**.

#### 4. Export the Design
- Ensure all connections are correctly set.
- Export the design for further processing.
![image](https://github.com/user-attachments/assets/7ee65156-6afb-4ea2-b47b-9b4bdd6757fa)
