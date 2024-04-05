-- Version 1.0
-- Authors: Chenyi Xu; Yongru Pan
-- Date: February 28, 2024 (enter the date of the latest edit to the file)

library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; -- needed if you are using unsigned rotate operations
entity g13_SIG_CH_MAJ is
port ( A_o, B_o, C_o, E_o, F_o, G_o : in std_logic_vector(31 downto 0);
		 SIG0, SIG1, CH, MAJ : out std_logic_vector(31 downto 0)
);
end g13_SIG_CH_MAJ;

architecture arch of g13_SIG_CH_MAJ is
begin
  -- MAJ
  maj3_1: process(A_o, B_o, C_o)
  begin
    MAJ <= (A_o and B_o) xor (B_o and C_o) xor (A_o and C_o);
  end process maj3_1;

  -- CH 
  ch3_1: process(E_o, F_o, G_o)
  begin
    CH <= (E_o and F_o) xor (not E_o and G_o);
  end process ch3_1;

  -- SIG0
  sig0_Process: process(A_o)
  begin
    SIG0 <= std_logic_vector(rotate_right(unsigned(A_o), 2)) xor
            std_logic_vector(rotate_right(unsigned(A_o), 13)) xor
            std_logic_vector(rotate_right(unsigned(A_o), 22));
  end process sig0_Process;

  -- SIG1
  sig1_Process: process(E_o)
  begin
    SIG1 <= std_logic_vector(rotate_right(unsigned(E_o), 6)) xor
            std_logic_vector(rotate_right(unsigned(E_o), 11)) xor
            std_logic_vector(rotate_right(unsigned(E_o), 25));
  end process sig1_Process;
end arch;
