LIBRARY IEEE;
USE ieee.std_logic_1164.all;
USE ieee.numeric_std.all;

ENTITY register_file_tb IS
END register_file_tb;

ARCHITECTURE behav OF register_file_tb IS

    COMPONENT register_file IS
    	GENERIC(
    		register_size: INTEGER := 32 --MIPS register size is 32 bit
    	);

    	PORT(
    		-- ************** Do we need a standard enable input ? *****************
    		clock: IN STD_LOGIC;
    		rs: IN STD_LOGIC_VECTOR (4 downto 0); -- first source register
    		rt: IN STD_LOGIC_VECTOR (4 downto 0); -- second source register
    		write_enable: IN STD_LOGIC; -- signals that rd_data may be written into rd 					**********Unsure if neccessary*************
    		rd: IN STD_LOGIC_VECTOR (4 downto 0); -- destination register
    		rd_data: IN STD_LOGIC_VECTOR (31 downto 0); -- destination register data

    		ra_data: OUT STD_LOGIC_VECTOR (31 downto 0); -- data of register a
    		rb_data: OUT STD_LOGIC_VECTOR (31 downto 0) -- data of register b
    	);
    END COMPONENT;

    SIGNAL clock: STD_LOGIC := '0';
    CONSTANT clock_period : time := 1 ns;
    SIGNAL rs: STD_LOGIC_VECTOR (4 downto 0);
    SIGNAL rt: STD_LOGIC_VECTOR (4 downto 0);
    SIGNAL write_enable: STD_LOGIC := '0';
    SIGNAL rd: STD_LOGIC_VECTOR (4 downto 0);
    SIGNAL rd_data: STD_LOGIC_VECTOR (31 downto 0);

    SIGNAL ra_data: STD_LOGIC_VECTOR (31 downto 0);
    SIGNAL rb_data: STD_LOGIC_VECTOR (31 downto 0);


BEGIN
    -- map component to signals
    rfile: register_file
    PORT MAP(
        clock => clock,
        rs => rs,
        rt => rt,
        write_enable => write_enable,
        rd => rd,
        rd_data => rd_data,

        ra_data => ra_data,
        rb_data => rb_data
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
        rs <= "00000";
        rt <= "00000";
        write_enable <='0';
        rd <= "00001";
        rd_data <= "00000000000000000000000000000000";

        wait for clock_period;

        -- test 2
        rs <= "00000";
        rt <= "00000";
        write_enable <='1';
        rd <= "00001";
        rd_data <= "10000000000000000000000000000001";

        wait for clock_period;

        -- test 3: write to R0. The write should not happen. 
        rs <= "11111";
        rt <= "11110";
        write_enable <='1';
        rd <= "00000";
        rd_data <= "10000000000000000000000000000001";

        wait for clock_period;

        -- test 4
        rs <= "11111";
        rt <= "11110";
        write_enable <='0';
        rd <= "00011";
        rd_data <= "10000000000000000000000000000001";

        WAIT;
    END PROCESS;

END behav;
