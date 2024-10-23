library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
entity DirectMappedCache is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
          tag_cache: in std_logic(3 downto 0);
          tag_mem: in std_logic_vector(3 downto 0);
          hit: out std_logic;
          miss: out std_logic;
          data_cache: out std_logic_vector(31 downto 0);
          data_main_memory: in std_logic_vector(31 downto 0);
          address:in std_logic_vector(15 downto 0);
          rd: in std_logic;
          wr: in std_logic
    );
end DirectMappedCache;

architecture Behavioral of DirectMappedCache is
  signal tag_data_out : std_logic_vector(3 downto 0);
  signal data_data_out : std_logic_vector(31 downto 0);
  signal hit_internal : std_logic;
  signal miss_internal : std_logic;

--tag ram:TagRAM port_map(clk=>clk,address=>address(11 downto 2),....)
--data ram:DataRAM port_map( data ram 8 bits 4 blocks)
--process 1
--read and write
--read if match=1
--read for signal
--else read for main memory
--write if match=1 

--process 2 read si write
--if tag1==tag2 => match=1
--signals 

  
  component TagRAM is
    Port (
      clk: in std_logic;
      reset: in std_logic;
      address: in std_logic_vector(9 downto 0);
      wr: in std_logic;
      data_in: in std_logic_vector(3 downto 0);
      data_out: out std_logic_vector(3 downto 0)
    );
  end component;

 
  component DataRAM is
    Port (
      clk: in std_logic;
      reset: in std_logic;
      address: in std_logic_vector(9 downto 0);
      wr: in std_logic;
      data_out: out std_logic_vector(31 downto 0);
      data_in: in std_logic_vector(31 downto 0)
    );
  end component;

begin
  
  TagRAM_Instance: TagRAM
    port map (
      clk => clk,
      reset => rst,
      address => address(11 downto 2),
      wr => wr,
      data_in => tag_mem,
      data_out => tag_data_out
    );

  
  DataRAM_Instance: DataRAM
    port map (
      clk => clk,
      reset => rst,
      address => address(9 downto 0),
      wr => wr,
      data_in => data_main_memory,
      data_out => data_data_out
    );

 
  hit <= hit_internal;
  miss <= miss_internal;

  process(clk, rst)
  begin
    if rst = '1' then
      hit_internal <= '0';
      miss_internal <= '0';
    elsif rising_edge(clk) then
   
      if rd = '1' then
      if tag_cache = tag_data_out then
  
  hit_internal <= '1';
  miss_internal <= '0';
    else
  
  hit_internal <= '0';
  miss_internal <= '1';
   end if;
      end if;

     
      if wr = '1' then
        if tag_cache = tag_data_out then
          hit_internal <= '1';
          miss_internal <= '0';
        else
          hit_internal <= '0';
          miss_internal <= '1';
        end if;
      end if;
    end if;
  end process;

  
  data_cache <= data_data_out when hit_internal = '1' else (others => '0');

end Behavioral;
