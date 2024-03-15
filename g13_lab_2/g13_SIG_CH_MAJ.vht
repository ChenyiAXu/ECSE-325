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
-- Generated on "02/28/2024 20:33:01"
                                                            
-- Vhdl Test Bench template for design  :  g13_SIG_CH_MAJ
-- 
-- Simulation tool : ModelSim-Altera (VHDL)
-- 

LIBRARY ieee;                                               
USE ieee.std_logic_1164.all;                                

ENTITY g13_SIG_CH_MAJ_vhd_tst IS
END g13_SIG_CH_MAJ_vhd_tst;
ARCHITECTURE g13_SIG_CH_MAJ_arch OF g13_SIG_CH_MAJ_vhd_tst IS
-- constants                                                 
-- signals                                                   
SIGNAL A_o : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL B_o : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL C_o : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL CH : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL E_o : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL F_o : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL G_o : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL MAJ : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL SIG0 : STD_LOGIC_VECTOR(31 DOWNTO 0);
SIGNAL SIG1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
COMPONENT g13_SIG_CH_MAJ
	PORT (
	A_o : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	B_o : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	C_o : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	CH : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	E_o : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	F_o : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	G_o : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
	MAJ : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIG0 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0);
	SIG1 : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
	);
END COMPONENT;
BEGIN
	i1 : g13_SIG_CH_MAJ
	PORT MAP (
-- list connections between master ports and signals
	A_o => A_o,
	B_o => B_o,
	C_o => C_o,
	CH => CH,
	E_o => E_o,
	F_o => F_o,
	G_o => G_o,
	MAJ => MAJ,
	SIG0 => SIG0,
	SIG1 => SIG1
	);
init : PROCESS                                               
-- variable declarations                                     
BEGIN                                                        
        -- code that executes only once                      
WAIT;                                                       
END PROCESS init;                                           
always : PROCESS                                              
-- optional sensitivity list                                  
-- (        )                                                 
-- variable declarations                                      
BEGIN                                                         
        -- code executes for every event on sensitivity list  
		A_o <= x"FF000000";
		B_o <= x"00FF0000";
		C_o <= x"0000FF00";
		E_o <= x"000000FF";
		F_o <= x"AA000000";
		G_o <= x"00000099";
		WAIT FOR 10 ns;
		A_o <= x"37000000"; 
		B_o <= x"00432100"; 
		C_o <= x"00007780"; 
		E_o <= x"00000321"; 
		F_o <= x"AA000000"; 
		G_o <= x"0500D032"; 

		WAIT FOR 5 ns; 
		A_o <= x"006c0000"; 
		B_o <= x"09912100"; 
		C_o <= x"00000000"; 
		E_o <= x"00000642"; 
		F_o <= x"AA000000"; 
		G_o <= x"80000001"; 
		WAIT FOR 5 ns; 
		
	 FOR i IN 1 TO 25 LOOP
    A_o <= SIG0;
    C_o <= SIG1;
    E_o <= MAJ;
    G_o <= CH;

    -- Wait for 5 ns after updating the signals to simulate time delay
    WAIT FOR 5 ns;
	 END LOOP;

 
WAIT;                                                        
END PROCESS always;                                          
END g13_SIG_CH_MAJ_arch;
