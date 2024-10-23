----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2023 15:17:01
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

library ieee;
use ieee.std_logic_1164.all;
entity reg8 is
port (clk: in std_logic;
ce: in std_logic;
d: in std_logic_vector (7 downto 0);
q: out std_logic_vector (7 downto 0));
end reg8;
architecture ex_reg of reg8 is
begin
process (clk)
begin
if (clk'event and clk = '1') then
if (ce = '1') then
q <= d;
end if;
end if;
end process;
end ex_reg;
