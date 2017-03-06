library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity mux is
port(clk : in std_logic;
	 input2 : in std_logic_vector(31 downto 0);
	 input1 : in std_logic_vector(31 downto 0);
	 selectInput : in std_logic;
	 selectOutput : out std_logic_vector(31 downto 0)
	 );
	 
end mux;

architecture mux_arch of mux is

begin

-- SOMEHOW DOESNT WORK WITH THE SELECT INPUT ALWAYS GIVE  WHEN OTHERS.
process (clk)
begin
	
	case selectInput is
	
	when '0' =>
	selectOutput <= input1;
	
	when '1' =>
	selectOutput <= input2;
	
	when others =>
	selectOutput <= "10101010000000000000000000101010";
	end case;
	
end process;
	
	
end mux_arch;
