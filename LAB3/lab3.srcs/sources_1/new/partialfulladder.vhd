----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2023 08:41:03 AM
-- Design Name: 
-- Module Name: partialfulladder - Behavioral
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

entity partialfulladder is Port 
(x:in std_logic;
y:in std_logic;
cin:in std_logic;
g,p:out std_logic;
s:out std_logic;
 );
end partialfulladder;

architecture Behavioral of partialfulladder is

begin
s<=x xor y xor cin;
g<=x and y;
p<=x or y;
end Behavioral;
