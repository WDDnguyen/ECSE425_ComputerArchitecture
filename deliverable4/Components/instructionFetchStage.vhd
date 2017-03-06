LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;
use std.textio.all;
use ieee.std_logic_textio.all;

ENTITY instructionFetchStage IS

--MIGHT NEED TO MODIFY IF STAGE TO THE WHOLE CPU PIPELINE

port(
	clk : in std_logic;
	muxInput0 : in std_logic_vector(31 downto 0);
	selectInputs : in std_logic;
	four : in INTEGER;
	 
	selectOutput : out std_logic_vector(31 downto 0);
	instructionMemoryOutput : out std_logic_vector(31 downto 0)
	);

END instructionFetchStage;

architecture instructionFetchStage_arch of instructionFetchStage is

--INSTRUCTION MEMORY 
component instructionMemory IS
	GENERIC(
	-- might need to change it 
		ram_size : INTEGER := 1024;
		mem_delay : time := 1 ns;
		clock_period : time := 1 ns
	);
	PORT (
		clock: IN STD_LOGIC;
		writedata: IN STD_LOGIC_VECTOR (31 DOWNTO 0);
		address: IN INTEGER RANGE 0 TO ram_size-1;
		memwrite: IN STD_LOGIC;
		memread: IN STD_LOGIC;
		readdata: OUT STD_LOGIC_VECTOR (31 DOWNTO 0);
		waitrequest: OUT STD_LOGIC
	);
END component;

--PC 

component pc is
port(clk : in std_logic;
	 reset : in std_logic;
	 counterOutput : out std_logic_vector(31 downto 0);
	 counterInput : in std_logic_vector(31 downto 0)
	 );
end component;

--MUX 

component mux is
port(clk : in std_logic;
	 input2 : in std_logic_vector(31 downto 0);
	 input1 : in std_logic_vector(31 downto 0);
	 selectInput : in std_logic;
	 selectOutput : out std_logic_vector(31 downto 0)
	 );
	 
end component;

--ADDER 

component adder is
port(clk : in std_logic;
	 plusFour : in integer;
	 counterOutput : in std_logic_vector(31 downto 0);
	 adderOutput : out std_logic_vector(31 downto 0)
	 );
end component;




-- SET SIGNALS 
	signal rst : std_logic := '0';
    constant clk_period : time := 1 ns;
    signal writedata: std_logic_vector(31 downto 0);
    signal address: INTEGER RANGE 0 TO 1024-1;
    
	signal memwrite: STD_LOGIC := '0';
    signal memread: STD_LOGIC := '1';
    signal readdata: STD_LOGIC_VECTOR (31 DOWNTO 0);
    signal waitrequest: STD_LOGIC;
	
	
	signal pcOutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal internal_selectOutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
	signal addOutput : STD_LOGIC_VECTOR(31 DOWNTO 0);
		
	--FAKE SIGNALS 
	signal muxInput1 : STD_LOGIC_VECTOR(31 DOWNTO 0):="00000000000000000000000000000000";
	
begin

pcCounter : pc 
port map(
	clk => clk,
	reset => rst,
	counterOutput => pcOutput,
	counterInput => internal_selectOutput
);

add : adder
port map(
	clk => clk,
	 plusFour => four,
	 counterOutput => pcOutput,
	 adderOutput => addOutput
);

fetchMux : mux 
port map(
	 clk => clk,
	 input2 => muxInput0,
	 -- CHANGE INPUT1
	 input1 => internal_selectOutput,
	 selectInput => selectInputs,
	 selectOutput => internal_selectOutput
	 );
	 
iMem : instructionMemory
	GENERIC MAP(
            ram_size => 1024
                )
                PORT MAP(
                    clk,
                    writedata,
                    address,
                    memwrite,
                    memread,
                    instructionMemoryOutput,
                    waitrequest
                );
				
	selectOutput <= internal_selectOutput;

				
end instructionFetchStage_arch;