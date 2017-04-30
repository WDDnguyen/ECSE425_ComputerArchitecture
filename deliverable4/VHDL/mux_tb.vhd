LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

ENTITY mux_tb IS
END mux_tb;

architecture mux_tb_arch of mux_tb is

component mux is 
port(clk : in std_logic;
	 input0 : in std_logic_vector(31 downto 0);
	 input1 : in std_logic_vector(31 downto 0);
	 selectInput : in std_logic;
	 selectOutput : out std_logic_vector(31 downto 0)
	 );
end component;


	constant clk_period : time := 1 ns;
    
	signal clk : std_logic := '0';
	signal muxValue1 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal muxValue2 : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal selection : STD_LOGIC;
	
	signal muxOutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
begin

muxFetch : mux 
	port map(
	 clk => clk,
	 input2 => muxValue2,
	 input1 => muxValue1,
	 selectInput => selection,
	 selectOutput => muxOutput
	 
);

    clk_process : process
    BEGIN
        clk <= '0';
        wait for clk_period/2;
        clk <= '1';
        wait for clk_period/2;
    end process;

test_process : process
    BEGIN
        wait for clk_period;
        report "STARTING SIMULATION \n";
		muxValue1 <= "11111111111111111111111111111111";
		muxValue2 <= "00000000000000000000000000000000";
		
		selection <= '1';
        
		wait for clk_period;
        
		selection <= '0';
        
		wait;
		
end process;

end mux_tb_arch;