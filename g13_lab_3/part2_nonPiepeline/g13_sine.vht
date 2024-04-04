-- Copyright (C) 2017  Intel Corporation. All rights reserved.
-- Your use of Intel Corporation's design tools, logic functions 
-- and other software and tools, and its AMPP partner logic 
-- functions, and any output files from any of the foregoing 
-- (including device programming or simulation files), and any 
-- associated documentation or information are expressly subject 
-- to the terms and conditions of the Intel Program License 
-- Subscription Agreement, the Intel Quartus Prime License Agreement,
-- the Intel FPGA IP License Agreement, or other applicable license
-- agreement, including, without limitation, that your use is for
-- the sole purpose of programming logic devices manufactured by
-- Intel and sold by Intel or its authorized distributors.  Please
-- refer to the applicable agreement for further details.

-- ***************************************************************************
-- This file contains a Vhdl test bench template that is freely editable to   
-- suit user's needs .Comments are provided in each section to help the user  
-- fill out necessary details.                                                
-- ***************************************************************************
-- Generated on "03/28/2024 23:53:13"
                                                            
-- Vhdl Test Bench template for design  :  g13_sine
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g13_sine_vhd_tst IS
END g13_sine_vhd_tst;
ARCHITECTURE g13_sine_arch OF g13_sine_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL clk : STD_LOGIC := '0';
constant clk_period : time := 1 ns;

SIGNAL i : STD_LOGIC_VECTOR(15 DOWNTO 0);
SIGNAL y : STD_LOGIC_VECTOR(15 DOWNTO 0);
COMPONENT g13_sine
	PORT (
	clk : IN STD_LOGIC;
	i : IN STD_LOGIC_VECTOR(15 DOWNTO 0);
	y : OUT STD_LOGIC_VECTOR(15 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g13_sine
	PORT MAP (
-- list connections between master ports and signals
	clk => clk,
	i => i,
	y => y
	);
--init : PROCESS                                               
-- variable declarations                                     
--BEGIN                                                        
        -- code that executes only once                      
--WAIT;                                                       
--END PROCESS init;                                           
clk_process : process
begin
  clk <= '0';
  wait for clk_period/2;
  clk <= '1';
  wait for clk_period/2;
end process;
always : PROCESS
-- optional sensitivity list
-- (        )
-- variable declarations
BEGIN
-- pi/6 => 2731
i<="0000101010101011";
wait for 3 * clk_period;
-- pi/4 => 4096
i<="0001000000000000";
wait for 3* clk_period;
-- pi/3 => 5461
i<="0001010101010101";
wait for 3 * clk_period;
-- pi/2 => 8192
i<="0010000000000000";
wait;
--result /4096 = mathermatical result
                                                     
END PROCESS always;                                          
END g13_sine_arch;
