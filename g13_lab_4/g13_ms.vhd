library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g13_ms is
port (
	M_i : in std_logic_vector(31 downto 0);
	Wt_o: out std_logic_vector(31 downto 0); 
	
	ld_i, CLK: in std_logic

);
end g13_ms;

architecture arch of g13_ms is 

--signal declaration
signal next_r0, r0, r1, r2, r3, r4, r5, r6, r7, r8, r9, r10, r11, r12, r13, r14, r15: std_logic_vector(31 downto 0); 
signal temp0, temp1: std_logic_vector(31 downto 0);
signal temp2: unsigned(31 downto 0); 

begin 
shift: process(clk)
begin
 if rising_edge(CLK) then
	r0 <= next_r0;
	r1 <= r0;
	r2 <= r1;
	r3 <= r2;
	r4 <= r3;
	r5 <= r4;
	r6 <= r5;
	r7 <= r6;
	r8 <= r7;
	r9 <= r8;
	r10 <= r9; 
	r11 <= r10;
	r12 <= r11;
	r13 <= r12;
	r14 <= r13;
	r15 <= r14;
 end if;

end process; 

next_r0 <= std_logic_vector(temp2) when ld_i <= '0' else M_i;

Wt_o <= next_r0;
temp1 <= (r1(16 downto 0) & r1(31 downto 17)) xor (r1(18 downto 0) & r1(31 downto 19)) xor ("000000000" & r1(31 downto 10));

temp0 <= (r14(6 downto 0) & r14(31 downto 7)) xor (r14(17 downto 0) & r14(31 downto 18)) xor ("000" & r14(31 downto 3));

--sum 
temp2 <= unsigned(r15) + unsigned(r6) + unsigned(temp1) + unsigned(temp0);

end arch;
