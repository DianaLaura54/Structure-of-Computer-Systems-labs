----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2023 15:18:54
-- Design Name: 
-- Module Name: shift_reg - Behavioral
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
entity shift_reg8 is
port (clk: in std_logic;
ce: in std_logic;
si: in std_logic;
so: out std_logic);
end shift_reg8;
architecture shift_reg of shift_reg8 is
signal tmp: std_logic_vector (7 downto 0):="00000000";
begin
process (clk)
begin
if (clk'event and clk = '1') then
if (ce = '1') then
for i in 0 to 6 loop
tmp(i+1) <= tmp(i);
end loop;
tmp(0) <= si;
end if;
end if;
end process;
so <= tmp(7);
end shift_reg;
