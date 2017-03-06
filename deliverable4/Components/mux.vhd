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

signal selected_output : std_logic_vector(31 downto 0);
 
begin

process (clk)
begin
	
	case selectInput is
	
	when '0' =>
	selected_output <= input1;
	
	when '1' =>
	selected_output <= input2;
	
	when others => report "unreachable" severity failure;
	end case;
	
end process;
	
	selectOutput <= selected_output;
	
end mux_arch;
