----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/02/2023 09:12:49 PM
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
port (a, b, c, d,e,f,g,h: in std_logic_vector (7 downto 0);
s: in std_logic_vector (2 downto 0);
x: out std_logic_vector (7 downto 0));
end mux;
architecture arch_mux of mux is
begin
with s select
x <= a when "000",
b when "001",
c when "010",
d when "011",
e when "100",
f when "101",
g when "110",
h when others;
end arch_mux;