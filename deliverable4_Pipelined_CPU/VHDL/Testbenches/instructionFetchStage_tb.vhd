LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

ENTITY instructionFetchStage_tb IS
END instructionFetchStage_tb;

architecture instructionFetchStage_tb_arch of instructionFetchStage_tb is

component instructionFetchStage IS
	port(
		clk : in std_logic;
		muxInput0 : in std_logic_vector(31 downto 0);
		selectInputs : in std_logic;
		four : in INTEGER;
		
		selectOutput : out std_logic_vector(31 downto 0);
		instructionMemoryOutput : out std_logic_vector(31 downto 0)
		);
end component;

	constant clk_period : time := 1 ns;
    
	signal clk : std_logic := '0';
	signal muxValue : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal selection : STD_LOGIC;
	
	signal intFour : INTEGER := 4;
	
	signal muxOutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal memoryOutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
	
begin

fetchStage : instructionFetchStage 
	port map(
		clk => clk,
		muxInput0 => muxValue,
		selectInputs => selection,
		four => intFour,
		
		selectOutput => muxOutput,
		instructionMemoryOutput => memoryOutput
		
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
        
		muxValue <= "00000000000000000000000000000000";
		selection <= '0';
		wait for clk_period;
        report "STARTING SIMULATION \n";
		selection <= '1';
		wait for clk_period;
        wait for clk_period;
        wait for clk_period;
        wait for clk_period;
        
		wait;
		
end process;

end instructionFetchStage_tb_arch;