library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

entity pipeline is
port (clk : in std_logic;
      a, b, c, d, e: in integer;
      op1, op2, op3, op4, op5, final_output : out integer
  );
end pipeline;

architecture behavioral of pipeline is

signal op1_internal,op2_internal,op3_internal,op4_internal,op5_internal,op1_next, op2_next, op3_next, op4_next, op5_next: integer;

begin

-- Synchronous part
process (clk)
begin

	if (clk'event and clk = '1') then
		 op1_internal <= op1_next;
		 op2_internal <= op2_next;
    	op3_internal <= op3_next;
    	op4_internal <= op4_next;
    	op5_internal <= op5_next;
        
	end if;
end process;

-- Asynchronous part 
op1_next <= a + b;
op2_next <= op1_internal * 42 ;
op3_next <= c * d;
op4_next <= a - e;
op5_next <= op4_internal * op3_internal;
final_output <= op2_internal - op5_internal;

op1 <= op1_internal;
op2 <= op2_internal;
op3 <= op3_internal;
op4 <= op4_internal;
op5 <= op5_internal;

end behavioral;
