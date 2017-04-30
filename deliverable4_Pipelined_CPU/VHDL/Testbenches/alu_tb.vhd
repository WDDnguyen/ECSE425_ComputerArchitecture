library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.NUMERIC_STD.ALL;

ENTITY alu_tb IS
END alu_tb;

ARCHITECTURE behav of alu_tb IS
	COMPONENT alu IS
		PORT(
			input_a : in STD_LOGIC_VECTOR (31 downto 0);
			input_b : in STD_LOGIC_VECTOR (31 downto 0);
			SEL : in STD_LOGIC_VECTOR (4 downto 0);
			out_alu : out STD_LOGIC_VECTOR(31 downto 0)
		);
	END COMPONENT;

	SIGNAL clock: STD_LOGIC := '0';
	CONSTANT clock_period : time := 1 ns;
	SIGNAL input_a : STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL input_b : STD_LOGIC_VECTOR(31 downto 0);
	SIGNAL sel : STD_LOGIC_VECTOR(4 downto 0);
	SIGNAL out_alu : STD_LOGIC_VECTOR (31 downto 0);

BEGIN
	alutest : alu
	PORT MAP(
		input_a => input_a,
		input_b => input_b,
		SEL => sel,
		out_alu => out_alu
	);

	clock_process : PROCESS
	BEGIN
		clock <= '1';
		wait for clock_period/2;
		clock <= '0';
		wait for clock_period/2;
	END PROCESS;

	test_process : PROCESS
	BEGIN
		wait for clock_period;

		-- ADD
		input_a <= "00000000000000000000000000000000";
		input_b <= "00000000000000000000000000000001";
		sel <= "00000";
		wait for clock_period;

		--SUBTRACT
		input_a <= "00000000000000000000000000000001";
		input_b <= "00000000000000000000000000000001";
		sel <= "00001";
		wait for clock_period;

		--SLL
		input_a <= "00000000000000000000000000000010";
		input_b <= "00000000000000000000000100000000";
		sel <= "10001";
		wait for clock_period;

		--MUL1
		input_a <= "00000000000000000000000000000100";
		input_b <= "00000000000000000000001000000000";
		sel <= "00011";
		wait for clock_period;

		--MFHI
		sel <= "01110";
		wait for clock_period;

		--MFLO
		sel <= "01111";
		wait for clock_period;

		--MUL2
		input_a <= "10000000000000000000000000000000";
		input_b <= "00000000010000000000000000000000";
		sel <= "00011";
		wait for clock_period;

		--MFHI
		sel <= "01110";
		wait for clock_period;

		--MFLO
		sel <= "01111";
		wait for clock_period;

		--DIV1
		input_a <= "00000000000000000000000000001000";
		input_b <= "00000000000000000000000000000010";
		sel <= "00100";
		wait for clock_period;

		--MFHI
		sel <= "01110";
		wait for clock_period;

		--MFLO
		sel <= "01111";
		wait for clock_period;

		--DIV2
		input_a <= "00000000000000000000000000001000";
		input_a <= "00000000000000000000000000000011";
		sel <= "00100";
		wait for clock_period;

		--MFHI
		sel <= "01110";
		wait for clock_period;

		--MFLO
		sel <= "01111";
		wait for clock_period;

		WAIT;
	END PROCESS;
END behav;
