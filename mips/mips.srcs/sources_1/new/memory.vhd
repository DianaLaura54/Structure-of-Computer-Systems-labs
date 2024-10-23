----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 07:02:25 PM
-- Design Name: 
-- Module Name: memory - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;
-- use package 
USE work.procmem_definitions.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity memory is
    Port ( address : in STD_LOGIC_VECTOR (width-1 downto 0);
           data : in STD_LOGIC_VECTOR (width-1 downto 0);
           memRead : in STD_LOGIC;
           memWrite : in STD_LOGIC;
           value : out STD_LOGIC_VECTOR (width-1 downto 0));
end memory;

architecture Behavioral of memory is

type ROM_type is array (0 to 255) of STD_LOGIC_VECTOR (31 downto 0);
signal data_memory : ROM_type := (
-- checking load and store
0 => B"100011_00000_00011_0000000000000000",      -- LOAD $0 $3     save in register 3 what's at the memory location from register 0
1 => B"100011_00001_00100_0000000000000000",      -- LOAD $1 $4     save in register 1 what's at the memory location from register 1
2 => B"000000_00011_00100_00101_00000_100000",    -- ADD  $3 $4 $5  add the results from registers 3 and 4 and save them in register 5
3 => B"101011_00010_00101_0000000000000000",      -- STOR $2 $5     save the value from register 5 into the memory location from register address

5 => B"00000000000000000000000000001010",         -- memory location from register 0
6 => B"00000000000000000000000000001011",         -- memory location from register 1
7 => B"00000000000000000000000000000000",         -- memory location from register 2
others => x"ffffffff"
);

begin

process(address, memRead, memWrite)
begin
    if memRead = '1' then
        value <= data_memory(conv_integer(address) mod 256);
    elsif memWrite = '1' then
        data_memory(conv_integer(address) mod 256) <= data;
    end if;
end process;

end Behavioral;
