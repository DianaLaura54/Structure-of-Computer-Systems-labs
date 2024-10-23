----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2023 15:29:07
-- Design Name: 
-- Module Name: mux - Behavioral
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
entity mux is
port (a, b, c, d: in std_logic_vector (3 downto 0);
s: in std_logic_vector (1 downto 0);
x: out std_logic_vector (3 downto 0));
end mux;
architecture arch_mux of mux is
begin
with s select
x <= a when "00",
b when "01",
c when "10",
d when others;
end arch_mux;
