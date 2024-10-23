----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2023 08:49:37 AM
-- Design Name: 
-- Module Name: fifo_ctrl - Behavioral
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


Library IEEE;
USE IEEE.Std_logic_1164.all;
USE ieee.std_logic_arith.all;  
USE ieee.std_logic_unsigned.all;  

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity fifo_ctrl is  Port ( 
clk:in std_logic;
rst:in std_logic;
empty: out std_logic;
full: out std_logic;
wrinc: in std_logic_vector(2 downto 0);
rdinc: in std_logic_vector(2 downto 0)
);
end fifo_ctrl;

architecture Behavioral of fifo_ctrl is
signal fbit_comp,pointer_equal: std_logic;
signal pointer_result: std_logic_vector(2 downto 0);
begin
fbit_comp <= wrinc(2) xor rdinc(2);
pointer_equal <= '1' 
  when (wrinc(1 downto 0) = rdinc(1 downto 0)) else '0';
  pointer_result <= wrinc - rdinc;
  full <= fbit_comp and  pointer_equal;
  empty <= (not fbit_comp) and  pointer_equal;
end Behavioral;
