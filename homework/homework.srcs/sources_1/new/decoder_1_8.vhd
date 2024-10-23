----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2023 15:30:25
-- Design Name: 
-- Module Name: decoder_1_8 - Behavioral
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
entity decoder_1_8 is
port (a: in std_logic_vector (2 downto 0);
y: out std_logic_vector (7 downto 0));
end decoder_1_8;
architecture decod of decoder_1_8 is
begin
y <= "00000001" when a = "000" else
"00000010" when a = "001" else
"00000100" when a = "010" else
"00001000" when a = "011" else
"00010000" when a = "100" else
"00100000" when a = "101" else
"01000000" when a = "110" else
"10000000";
end decod;
