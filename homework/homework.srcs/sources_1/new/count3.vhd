----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2023 15:27:07
-- Design Name: 
-- Module Name: count3 - Behavioral
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
entity count3 is
port (clk: in std_logic;
count: out integer range 0 to 7);
end count3;
architecture count3_integer of count3 is
signal tmp: integer range 0 to 7;
begin
cnt: process (clk)
begin
if (clk'event and clk = '1') then
tmp <= tmp + 1;
end if;
end process cnt;
count <= tmp;
end count3_integer;
