----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2023 10:42:37 PM
-- Design Name: 
-- Module Name: reg8 - Behavioral
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

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

library ieee;
use ieee.std_logic_1164.all;
entity reg8 is
port (clk: in std_logic;
en: in std_logic;
d: in std_logic_vector (7 downto 0);
q: out std_logic_vector (7 downto 0));
end reg8;
architecture ex_reg of reg8 is
begin
process (clk)
begin
if (clk'event and clk = '1') then
if (en = '1') then
q <= d;
end if;
end if;
end process;
end ex_reg;