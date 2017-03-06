library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity adder is
port(clk : in std_logic;
	 plusFour : in integer;
	 counterOutput : in std_logic_vector(31 downto 0);
	 adderOutput : out std_logic_vector(31 downto 0)
	 );
end adder;

architecture adder_arch of adder is

--signal internal_output : std_logic_vector(31 downto 0);
signal internal_output : std_logic_vector(31 downto 0);
signal add : integer;

begin

process (clk)
begin
	add <= plusFour +  to_integer(unsigned(counterOutput)); 
	
end process;


adderOutput <= std_logic_vector(to_unsigned(add, adderOutput'length));
	
end adder_arch;