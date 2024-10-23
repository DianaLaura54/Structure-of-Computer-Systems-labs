----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/12/2023 09:39:08 AM
-- Design Name: 
-- Module Name: data_RAM - Behavioral
-- Project Name: 
-- Target Devices: 
-- Tool Versions: 
-- Description: 
-- 
-- Dependencies: 
-- 
-- Revision:
-- Revision 0.01 - File Created
-- Additional Comments:
-- 
----------------------------------------------------------------------------------


library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;
entity DataRAM is
  Port ( 
    clk: in std_logic;
    reset: in std_logic;
    address: in std_logic_vector(9 downto 0);
    wr: in std_logic;
    data_out: out std_logic_vector(31 downto 0);
    data_in: in std_logic_vector(31 downto 0)
  );
end DataRAM;

architecture Behavioral of DataRAM is
  type data_ram is array(0 to 127) of std_logic_vector (31 downto 0);
  signal ram : data_ram;
begin
  process(clk, reset)
  begin
    if reset = '1' then
 
      ram <= (others => (others => '0'));
    elsif rising_edge(clk) then
      if wr = '1' then 
        ram(conv_integer(address)) <= data_in; 
      else
        data_out <= ram(conv_integer(address));
      end if;
    end if;
  end process;
end Behavioral;
