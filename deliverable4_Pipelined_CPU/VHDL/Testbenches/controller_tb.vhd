library ieee;
use IEEE.std_logic_1164.all;
use IEEE.numeric_std.all;

entity controller_tb is
end controller_tb;

architecture controller_tb_arch of controller_tb is

component controller is
port(clk : in std_logic;
	 opcode : in std_logic_vector(5 downto 0);
	 funct : in std_logic_vector(5 downto 0);
	 ALU1src : out STD_LOGIC;
	 ALU2src : out STD_LOGIC;
	 MemRead : out STD_LOGIC;
	 MemWrite : out STD_LOGIC;
	 RegWrite : out STD_LOGIC;
	 MemToReg : out STD_LOGIC;
	 ALUOp : out STD_LOGIC_VECTOR(4 downto 0)
	 );
end component;

constant clk_period : time := 1 ns;
signal clk : std_logic := '0';

signal opcodeInput,functInput : std_logic_vector(5 downto 0);
signal ALU1srcO,ALU2srcO,MemReadO,MemWriteO,RegWriteO,MemToRegO : std_logic;
signal output : std_logic_vector(4 downto 0);

begin

controllerTest : controller 
port map(
	clk => clk,
	opcode => opcodeInput, 
	funct => functInput,
	ALU1src => ALU1srcO,
	ALU2src => ALU2srcO,
	MemRead => MemReadO,
	MemWrite => MemWriteO,
	RegWrite => RegWriteO,
	MemToReg => MemToRegO,
	ALUOp => output 
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
		opcodeInput <= "100000";
		functInput <= "000000";
		wait for clk_period;
		opcodeInput <= "100010";
		wait for clk_period;
        opcodeInput <= "001000";
		wait for clk_period;
        opcodeInput <= "101010";
		wait for clk_period;
        opcodeInput <= "001010";
		wait for clk_period;
        opcodeInput <= "100100";
		wait for clk_period;
        opcodeInput <= "100101";
		wait for clk_period;
        opcodeInput <= "100111";
		wait for clk_period;
        opcodeInput <= "100110";
		wait for clk_period;
        opcodeInput <= "001100";
		wait for clk_period;
        opcodeInput <= "001101";
		wait for clk_period;
        opcodeInput <= "001110";
		wait for clk_period;
        opcodeInput <= "001111";
		wait for clk_period;
		opcodeInput <= "000010";
		wait for clk_period;
		opcodeInput <= "100011";
		wait for clk_period;
		opcodeInput <= "101011";
		wait for clk_period;
		opcodeInput <= "000100";
		wait for clk_period;
		opcodeInput <= "000101";
		wait for clk_period;
		opcodeInput <= "000011";
		wait for clk_period;
		
		--OPCODE WITH FUNCT 
		opcodeInput <= "000000";
		wait for clk_period;
		functInput <= "011010";
		wait for clk_period;
		functInput <= "011000";
		wait for clk_period;
		functInput <= "000011";
		wait for clk_period;
		functInput <= "001010";
		wait for clk_period;
		functInput <= "001100";
		
		wait;
		
end process;


end controller_tb_arch;