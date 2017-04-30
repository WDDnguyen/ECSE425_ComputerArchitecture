LIBRARY ieee;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY signextender_tb IS
END signextender_tb;

ARCHITECTURE Behavioral OF signextender_tb IS

    COMPONENT signextender IS
        PORT (
            clock: IN STD_LOGIC;
            immediate_in: IN STD_LOGIC_VECTOR (15 DOWNTO 0);
            immediate_out: OUT STD_LOGIC_VECTOR (31 DOWNTO 0)
        );
    END COMPONENT;

    SIGNAL clock: STD_LOGIC := '0';
    CONSTANT clock_period : time := 1 ns;
    SIGNAL immediate_in: STD_LOGIC_VECTOR (15 DOWNTO 0);
    SIGNAL immediate_out: STD_LOGIC_VECTOR (31 DOWNTO 0);

BEGIN
    -- map component to/=> signals
    sx: signextender
    PORT MAP(
        clock => clock,
        immediate_in => immediate_in,
        immediate_out => immediate_out
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

        -- test 1
        immediate_in <= "0000000000000000";

        wait for clock_period;

        -- test 2
        immediate_in <= "1111111111111111";

        wait for clock_period;

        -- test 3
        immediate_in <= "1111111111111001";

        wait for clock_period;

        -- test 4
        immediate_in <= "0000111111111111";

        wait for clock_period;

        -- test 5
        immediate_in <= "1010101010101010";

        WAIT;
    END PROCESS;
END Behavioral;
