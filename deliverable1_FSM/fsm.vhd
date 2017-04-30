
library ieee;
use IEEE.std_logic_1164.all;
use ieee.numeric_std.all;

-- Do not modify the port map of this structure
entity comments_fsm is
port (clk : in std_logic;
      reset : in std_logic;
      input : in std_logic_vector(7 downto 0);
      output : out std_logic
  );
end comments_fsm;

architecture behavioral of comments_fsm is

-- The ASCII value for the '/', '*' and end-of-line characters
constant SLASH_CHARACTER : std_logic_vector(7 downto 0) := "00101111";
constant STAR_CHARACTER : std_logic_vector(7 downto 0) := "00101010";
constant NEW_LINE_CHARACTER : std_logic_vector(7 downto 0) := "00001010";

TYPE State_type is (s0,s1,s2,s3,s4,s5,s6,s7);
signal state : State_type;

begin

-- Insert your processes here
process (clk, reset)
begin
  if (reset = '1') then
    state <= s0;
    
  elsif rising_edge(clk) then 
    
    case state is
    
      when s0 =>
        if input = SLASH_CHARACTER then
          state <= s1;
        else
          state <= s0;
        end if;
    
      when s1 =>
        if input = SLASH_CHARACTER then
          state <= s2;
        elsif input = STAR_CHARACTER then
          state <= s3;
        else
          state <= s0;
        end if;
        
      when s2 => 
        if input = NEW_LINE_CHARACTER then
          state <= s7;
        else 
          state <= s4;
        end if;
          
      when s3 =>
        if input = STAR_CHARACTER then
          state <= s6;
        else 
          state <= s5;
        end if;
        
      when s4 =>
        if input = NEW_LINE_CHARACTER then
          state <= s7;
        else 
          state <= s4;
        end if;
        
      when s5 =>
        if input = STAR_CHARACTER then 
          state <= s6;
        else 
          state <= s5;
        end if;
          
      when s6 =>
        if input = SLASH_CHARACTER then
          state <= s7;
        else
          state <= s5;
        end if;
        
      when s7 =>
        state <= s0; 
      
      end case;
  end if;
end process;

process(state)
  begin
    case state is 
      when s0 =>
        output <= '0';
      when s1 =>
        output <= '0';
      when s2 =>
        output <= '0';
      when s3 =>
        output <= '0';
      when s4 =>
        output <= '1';
      when s5 =>
        output <= '1';
      when s6 =>
        output <= '1';
      when s7 =>
        output <= '1'; 
    end case;
  end process;
  
end behavioral;
