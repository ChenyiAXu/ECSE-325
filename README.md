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
- Tools -> Qsys -> System Contents Pane appear
- Under `Library` -> Processors and Peripherals -> Hard Process Systems -> Arria V/Cyclone V Hard Processor System
- Under `Library` -> Basic Functions -> On Chip Memory -> On chip memory (RAM or ROM)
- Under `Library` -> Processors and Peripherals -> PIO (Parallel I/O)
- Connect `h2f_axi_master` (HPS to FPGA) to s1 uner onchip_memory2_0
- connect s1 uner pio 0 & 1 & 2 to `h2f_lw_axi_master` (light weight HPS to FPGA)
- connect all the components clock and reset signals to the clock componeny
- export the design
![image](https://github.com/user-attachments/assets/7ee65156-6afb-4ea2-b47b-9b4bdd6757fa)
