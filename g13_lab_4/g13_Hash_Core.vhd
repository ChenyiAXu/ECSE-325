--
-- entity name: g13_Hash_Core
-- Version 1.0
-- Authors: Chenyi Xu, Yongru Pan
-- Date: March 20 2024 (enter the date of the latest edit to the file)
library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- needed if you are using unsigned rotate operations

entity g13_Hash_Core is
port ( A_o, B_o, C_o, D_o, E_o, F_o, G_o, H_o : inout std_logic_vector(31 downto 0);
		 A_i, B_i, C_i, D_i, E_i, F_i, G_i, H_i : in std_logic_vector(31 downto 0);
		 Kt_i, Wt_i : in std_logic_vector(31 downto 0);
		 LD, CLK: in std_logic
);
end g13_Hash_Core;

architecture arch_core of g13_Hash_Core is 
    component g13_SIG_CH_MAJ 
        port(
            A_o, B_o, C_o, E_o, F_o, G_o : in std_logic_vector(31 downto 0);
            SIG0, SIG1, CH, MAJ : out std_logic_vector(31 downto 0)
        );
    end component;

    signal SIG0, SIG1, CH, MAJ: std_logic_vector(31 downto 0);
    signal reg_a, reg_b, reg_c, reg_d, reg_e, reg_f, reg_g, reg_h : unsigned (31 downto 0);
    signal next_a, next_b, next_c, next_d, next_e, next_f, next_g, next_h: unsigned (31 downto 0);
    signal temp1_S0,temp2_S0, temp1_CH, temp2_CH, temp1_S1, temp : unsigned (31 downto 0); 

begin 
    CD: g13_SIG_CH_MAJ port map(
        A_o => A_o, B_o => B_o, C_o => C_o, E_o => E_o, F_o => F_o, G_o => G_o,
        SIG0 => SIG0, SIG1 => SIG1, CH => CH, MAJ => MAJ
    );

    reg_process: process(CLK)
    begin
        if rising_edge(CLK) then
            reg_a <= next_a;
            reg_b <= next_b;
            reg_c <= next_c;
            reg_d <= next_d;
            reg_e <= next_e; 
            reg_f <= next_f;
            reg_g <= next_g;
            reg_h <= next_h; 
        end if; 
    end process;

    temp1_S0 <= unsigned(SIG0) + unsigned(MAJ); 
    temp1_CH <= unsigned(CH) + unsigned(reg_h);
    temp2_CH <= temp1_CH + unsigned(Kt_i) + unsigned(Wt_i); 
    temp1_S1 <= temp2_CH + unsigned(SIG1); 
    temp2_S0 <= temp1_S1 + temp1_S0; 
    temp <= temp1_S1 + unsigned(reg_d); 

    next_a <= unsigned(A_i) when LD = '1' else temp2_S0;
    next_b <= unsigned(B_i) when LD = '1' else reg_a;
    next_c <= unsigned(C_i) when LD = '1' else reg_b;
    next_d <= unsigned(D_i) when LD = '1' else reg_c;
    next_e <= unsigned(E_i) when LD = '1' else temp;
    next_f <= unsigned(F_i) when LD = '1' else reg_e;
    next_g <= unsigned(G_i) when LD = '1' else reg_f;
    next_h <= unsigned(H_i) when LD = '1' else reg_g; 

    A_o <= std_logic_vector(reg_a); 
    B_o <= std_logic_vector(reg_b);
    C_o <= std_logic_vector(reg_c);
    D_o <= std_logic_vector(reg_d); 
    E_o <= std_logic_vector(reg_e);
    F_o <= std_logic_vector(reg_f); 
    G_o <= std_logic_vector(reg_g);
    H_o <= std_logic_vector(reg_h);  
end arch_core;
