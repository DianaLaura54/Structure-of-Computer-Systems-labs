----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2023 14:26:44
-- Design Name: 
-- Module Name: dff - Behavioral
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
entity dff is
port (clk: in std_logic;
d: in std_logic;
q: out std_logic);
end dff;
architecture example of dff is
begin
process (clk)
begin
if (clk'event and clk = '1') then
q <= d;
end if;
end process;
end example;