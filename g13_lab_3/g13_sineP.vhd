library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g13_sineP is
    port (
        clk : in std_logic;
        i   : in std_logic_vector(15 downto 0);
        y   : out std_logic_vector(15 downto 0)
    );
end g13_sineP;

architecture arch of g13_sineP is
   -- Signal declaration
    
    signal A1, B1, C1, i_32    : std_logic_vector(31 downto 0);
	 signal i_32_2, i_32_3, i_32_4, i_32_5, i_32_6: std_logic_vector(31 downto 0); --registers for i pipeline
    signal temp1, temp2, temp3, temp4, temp6 : std_logic_vector(63 downto 0); --temp registers for multiplication
    signal y1, y2, y3, y4, y5, y6, y7,temp7, temp7_2  : std_logic_vector(31 downto 0);
	 signal r1, r2, r3, r4, r5, r6, r7: std_logic_vector(31 downto 0); --registers to store updated y for pipeline

begin

    store_update: process(clk)
    begin
        if rising_edge(clk) then
			 
			-- update all i 
				i_32_2 <= i_32;
				i_32_3 <= i_32_2;
				i_32_4 <= i_32_3;
				i_32_5 <= i_32_4;
				i_32_6 <= i_32_5;
          -- multplication registers  
				r1 <= y1;
				r2 <= y2;
				r3 <= y3;
				r4 <= y4;
				r5 <= y5;
				r6 <= y6;
				r7 <= y7;
        end if; 
    end process;
        
        -- Formula implementation
        -- 32 bits for A1, B1, C1
        A1 <= "11001000111011001000101001001011"; 
        B1 <= "10100011101100100010100100101100";
        C1 <= "00000000000001000111011001000101";
        -- 32 bits i
        i_32 <= "0000000000000000" & i; 
        
        -- Temp 1 = C1 * unsigned(i_32)
        temp1 <= std_logic_vector(unsigned(C1) * unsigned(i_32));
        -- Y1 = Temp1 right shift 13
		  y1 <= std_logic_vector(unsigned("0000000000000" & temp1(31 downto 13)));

        -- Temp 2 = i_32 * Y1
        -- Y2 = B1 - Temp 2 right shift by 3
        temp2 <= std_logic_vector(unsigned(i_32_2) * unsigned(r1));
        y2 <= std_logic_vector(unsigned(B1) - unsigned("000" & temp2(31 downto 3)));
        
        -- Y3 = i_32 * Y2 right shift by 13
        temp3 <= std_logic_vector(unsigned(i_32_3) * unsigned("0000000000000" & r2(31 downto 13)));
        y3 <= temp3(31 downto 0);
		  
        -- Y4 = i_32 * Y3 right shift by 13
        temp4 <= std_logic_vector(unsigned(i_32_4) * unsigned("0000000000000" & r3(31 downto 13)));
        y4 <= temp4(31 downto 0);
		  
        -- Y5 = A1 - (Y4 right shift 1)
        y5 <= std_logic_vector(unsigned(A1) - unsigned('0' & r4(31 downto 1)));
        
        -- Y6 = i_32 * (Y5 right shift by 13)
        temp6 <= std_logic_vector(unsigned(i_32_6) * unsigned("0000000000000" & r5(31 downto 13)));
        y6 <= temp6(31 downto 0);
		  
        -- Y7 = (Y6 + (1 left shift 18)) right shift 19
        temp7 <= std_logic_vector(to_unsigned(1, 32));
        temp7_2 <= std_logic_vector(unsigned(r6) + unsigned(temp7(13 downto 0) & "000000000000000000"));
        y7 <= "0000000000000000000" & temp7_2(31 downto 19);
		  
		  y <= r7(15 downto 0);
end arch;
