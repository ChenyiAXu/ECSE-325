-- entity name: g13_SHA256
--
-- Version 1.0
-- Authors: Chenyi Xu, Yongru Pan
-- Date: April 10th, 2021 (enter the date of the latest edit to the file)
library ieee; -- allows use of the std_logic_vector type
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity g13_SHA256 is
    port (clock, resetn: in std_logic;
			read, write, chipselect: in std_logic;
			address: in std_logic_vector(7 downto 0);
			in_data: in std_logic_vector(31 downto 0);
			out_data: out std_logic_vector(31 downto 0)
    );
end g13_SHA256;

architecture arch of g13_SHA256 is

type message_array is array(0 to 15) of std_logic_vector(31 downto 0);
signal M : message_array;

type constant_array is array(0 to 63) of std_logic_vector(31 downto 0);
constant Kt : constant_array := ( x"428a2f98", x"71374491", x"b5c0fbcf", x"e9b5dba5",
x"3956c25b", x"59f111f1", x"923f82a4", x"ab1c5ed5", x"d807aa98", x"12835b01",
x"243185be", x"550c7dc3", x"72be5d74", x"80deb1fe", x"9bdc06a7", x"c19bf174",
x"e49b69c1", x"efbe4786", x"0fc19dc6", x"240ca1cc", x"2de92c6f", x"4a7484aa",
x"5cb0a9dc", x"76f988da", x"983e5152", x"a831c66d", x"b00327c8", x"bf597fc7",
x"c6e00bf3", x"d5a79147", x"06ca6351", x"14292967", x"27b70a85", x"2e1b2138",
x"4d2c6dfc", x"53380d13", x"650a7354", x"766a0abb", x"81c2c92e", x"92722c85",
x"a2bfe8a1", x"a81a664b", x"c24b8b70", x"c76c51a3", x"d192e819", x"d6990624",
x"f40e3585", x"106aa070", x"19a4c116", x"1e376c08", x"2748774c", x"34b0bcb5",
x"391c0cb3", x"4ed8aa4a", x"5b9cca4f", x"682e6ff3", x"748f82ee", x"78a5636f",
x"84c87814", x"8cc70208", x"90befffa", x"a4506ceb", x"bef9a3f7", x"c67178f2"
);
signal Kt_i : std_logic_vector(31 downto 0);

signal Wt : std_logic_vector(31 downto 0) := x"00000000";
-- initial hash values
signal h0 : std_logic_vector(31 downto 0) := x"6a09e667";
signal h1 : std_logic_vector(31 downto 0) := x"bb67ae85";
signal h2 : std_logic_vector(31 downto 0) := x"3c6ef372";
signal h3 : std_logic_vector(31 downto 0) := x"a54ff53a";
signal h4 : std_logic_vector(31 downto 0) := x"510e527f";
signal h5 : std_logic_vector(31 downto 0) := x"9b05688c";
signal h6 : std_logic_vector(31 downto 0) := x"1f83d9ab";
signal h7 : std_logic_vector(31 downto 0) := x"5be0cd19";

--more signal desclaration 
signal M_i: std_logic_vector (31 downto 0); 
signal LD, ld_i: std_logic;
signal A_o, B_o, C_o, D_o, E_o, F_o, G_o, H_o : std_logic_vector(31 downto 0);

--state for the process block 
type SHA_256_STATE is (INIT, READM, RUN, UPDATE, OUTPUT);
signal state : SHA_256_STATE;
signal round_count : integer range 0 to 63; --counter for 64 rounds of hashing 
signal m_count: integer range 0 to 15; --message array counter
signal out_count : integer range 0 to 7; 

-- web link https://medium.com/biffures/part-5-hashing-with-sha-256-4c2afc191c40
-- step 1 message schedule --> to get Wt_i
-- step 2 big shuffle 
-- step 3 new hash 

--declare message schedule component 
component g13_ms
port(
	M_i : in std_logic_vector(31 downto 0);
	Wt_o: out std_logic_vector(31 downto 0); 
	ld_i, CLK: in std_logic
);
end component; 

component g13_Hash_Core
port(	 A_o, B_o, C_o, D_o, E_o, F_o, G_o, H_o : inout std_logic_vector(31 downto 0);
		 A_i, B_i, C_i, D_i, E_i, F_i, G_i, H_i : in std_logic_vector(31 downto 0);
		 Kt_i, Wt_i : in std_logic_vector(31 downto 0);
		 LD, CLK: in std_logic
);
end component;
--begin of architecture 
begin
		--port map for the declared components 
		message: g13_ms port map(
				M_i => M_i, Wt_o => Wt, ld_i=> ld_i, CLK => clock
		);
		hash_core: g13_Hash_Core port map(
				A_o => A_o, B_o => B_o, C_o => C_o, D_o => D_o, E_o => E_o, F_o => F_o, G_o => G_o, H_o => H_o,
				A_i => h0, B_i => h1, C_i => h2, D_i => h3, E_i => h4, F_i => h5, G_i => h6, H_i => h7,
				Kt_i => Kt_i, Wt_i => Wt, LD => LD, CLK => clock
		
		);
		--concat to form output 
		process(clock, resetn)
		begin 
			if resetn = '1' then
					state <= INIT;
			elsif rising_edge(clock) then
					case state is 
					when INIT =>
							LD <= '0';
							round_count <= 0;
							m_count <= 0;
							state <= READM; 
							
					when READM =>
							if write = '1' then
									M(m_count) <= in_data;
									if m_count = 15 then
									state <= RUN;
									else 
									m_count <= m_count + 1;
									end if;
							end if; 
					when RUN =>
							if round_count < 16 then 
								M_i <= M(round_count); 
								ld_i <= '1'; 
							end if;
						
							if round_count < 64 then 
								if round_count > 16 then
									ld_i <= '0';
									Kt_i <= Kt(round_count);
								end if;
								
								if round_count = 63 then
									LD <= '1';
									state <= UPDATE; 
								end if;
							end if; 
							
							round_count <= round_count + 1;
							
					when UPDATE =>
							h0 <= std_logic_vector(unsigned(h0) + unsigned(A_o));
							h1 <= std_logic_vector(unsigned(h1) + unsigned(B_o));
							h2 <= std_logic_vector(unsigned(h2) + unsigned(C_o));
							h3 <= std_logic_vector(unsigned(h3) + unsigned(D_o));
							h4 <= std_logic_vector(unsigned(h4) + unsigned(E_o));
							h5 <= std_logic_vector(unsigned(h5) + unsigned(F_o));
							h6 <= std_logic_vector(unsigned(h6) + unsigned(G_o));
							h7 <= std_logic_vector(unsigned(h7) + unsigned(H_o));
							state <= OUTPUT;				
					--out_data
					when output =>
							if read = '1' then
								case out_count is

									when 0 => out_data <= h0;
									when 1 => out_data <= h1;
									when 2 => out_data <= h2;
									when 3 => out_data <= h3;
									when 4 => out_data <= h4;
									when 5 => out_data <= h5;
									when 6 => out_data <= h6;
									when 7 => out_data <= h7;
				
								end case;			
								if out_count = 7 then
									state <= INIT;
									out_count <= 0; -- Reset out_count for next cycle
								else
									out_count <= out_count + 1;
								end if;
							end if;

					end case; 
			
			end if; --end of if statement for rising edge
		end process; 

end arch;
