library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity cache is
generic(
	ram_size : INTEGER := 32768;
);
port(
	clock : in std_logic;
	reset : in std_logic;
	
	-- Avalon interface --
	s_addr : in std_logic_vector (31 downto 0);
	s_read : in std_logic;
	s_readdata : out std_logic_vector (31 downto 0);
	s_write : in std_logic;
	s_writedata : in std_logic_vector (31 downto 0);
	s_waitrequest : out std_logic; 
    
	m_addr : out integer range 0 to ram_size-1;
	m_read : out std_logic;
	m_readdata : in std_logic_vector (7 downto 0);
	m_write : out std_logic;
	m_writedata : out std_logic_vector (7 downto 0);
	m_waitrequest : in std_logic
);
end cache;

architecture arch of cache is
type state_type is (start, r, w, r_memread, r_memwrite, r_memwait, w_memwrite);
signal state : state_type;
signal next_state : state_type;

--Address struct
--25 bits of tag
--5 bis of index
--2 bits of offset


-- Cache struct [32] 
type cache_def is array (0 to 31) of std_logic_vector (154 to 0);
signal cache : cache_def;
--1 bit valid
--1 bit dirty
--25 bit tag
--128 bit data


begin
process (clk, reset)
begin
	if reset = '1' then
		state <= start;
	elsif (clk'event and clk = '1') then
		state <= next_state;
	end if;
end process;

process (s_read, s_write, state)
begin
	variable index : std_logic_vector (4 downto 0) := s_addr(6 downto 2);
	variable valid : std_logic := (cache(index))(154);
	variable dirty : std_logic := (cache(index))(153);
	variable tag : std_logic_vector(24 downto 0) := (cache(index))(152 down to 128);
	variable data : std_logic_vector(127 downto 0) := (cache(index))(127 down to 0);

	-- int Offset =  (int) s_addr(1 downto 0) + 1 	
	-- int end = Offset - 1
	
	--Read Miss
	
	--int word = 32
	--int byte = 8
	-- int count = 0
	-- int endCount = 3 
	
	-- when reading the value from mem  loop it 4 times to get full 32 bits for m_readdata
	--reset value of count after 

	case state is
		when start =>
			s_waitrequest <= '0';
			if s_read = '1' then
				next_state <= r;
			elsif s_write = '1' then
				next_state <= w;
			else
				next_state <= start;
			end if;
		when r =>
			s_waitrequest <= '1';
			-- if valid and tags match
			if valid = '1' and tag = s_addr (31 downto 7) then --HIT
				s_readdata <= data (0); --NEED OFFSET
				next_state <= start;
			else if dirty = '1' then --MISS DIRTY
				next_state <= r_memwrite;
			else if dirty = '0' then --MISS CLEAN
				next_state <= r_memread;
			else
				next_state <= r;
			end if;
		when r_memwrite =>
			if m_waitrequest = '0' then -- NEED TO DO THIS 4 TIMES TO WRITE ALL 32 BITS
				m_addr <= tag ( 7 downto 0) & s_addr(6 downto 0) ; -- tag in cache concat with input address				
				m_write <= '1';
				m_read <= '0'
				m_writedata <= data (0); --NEED OFFSET
				next_state <= r_memread;
			else
				next_state <= r_memwrite;
			end if;
		when r_memread => -- NEED TO DO THIS 4 TIMES TO READ ALL 32 BITS
			if m_waitrequest = '0' then
				m_addr <= s_addr (14 downto 0);
				m_read <= '1';
				m_write <= '0';
				next_state <= r_memwait;
			else
				next_state <= r_memread;
			end if;
		when r_memwait =>
			if m_waitrequest = '0' then
				s_readdata(7 downto 0) <= m_readdata; -- Need to get 32 bits not just 8
				--possible state 
				-- do you load MS bits first or LS bits first ? 
				--Assume MS first 
				--s_readdata((32 - count * byte) - 1 downto endCount * byte)
				-- probably need a state until count is over loading  
				m_read <= '0'
				m_write <= '0'
				-- count = 0
				-- endCount = 3
				next_state <= start;
			else
				next_state <= r_memwait;
		when w =>
			s_waitrequest <= '1';
			if dirty = '1' then --(AND MISS)
				next_state <= w_memwrite;
			else
				data(0) <= s_writedata; --NEED OFFSET
				dirty <= '1';
				next_state <= start;
			end if;
		when w_memwrite => -- NEED TO DO THIS 4 TIMES TO READ ALL 32 BITS
			if m_waitrequest = '0' then
				m_addr <= tag ( 7 downto 0) & s_addr(6 downto 0) ;				
				m_write <= '1';
				m_read <= '0'
				m_writedata <= data (0); --NEED OFFSET -- DOES THIS CAUSE CONCURRENCY ISSUES?
				data(0) <= s_writedata (7 downto 0) --NEED OFFSET
				dirty <= '1'
				next_state <= start;
			else
				next_state <= w_memwrite;
			end if;
	end case;
end process;


if read
	go to index in cache
	if tags match and valid
		return data at offset
	else
		if dirty
			write cache to memory
			return data at offset
			mark block as clean
		else clean
			get data from memory
			return data at offset
			mark block as clean

if write
	go to index in cache
	if tags match and valid
		write to cache
		mark block as dirty
	else
		if dirty
			write dirty block to memory
			write to cache
			mark block as dirty

		else
			write to cache
			mark block as dirty
	
-- make circuits here

end arch;