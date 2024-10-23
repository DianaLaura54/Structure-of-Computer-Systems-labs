----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2023 10:44:18 PM
-- Design Name: 
-- Module Name: read_pointer - Behavioral
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
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity read_pointer is
Port ( 
rdinc: in std_logic;
clk:in std_logic;
reset:in std_logic;
rdptr:out std_logic_vector(2 downto 0)
);
end read_pointer;
architecture Behavioral of read_pointer is
signal counter : STD_LOGIC_VECTOR(3 downto 0) := "000";  -- Initialize the counter to 0
    
begin
    process(clk, reset)
    begin
        if reset = '1' then
            counter <= "000";  -- Reset the counter to 0
        elsif rising_edge(clk) then
        if(rdinc='1') then
                counter<= counter+1;
            end if;
        end if;
    end process;

    rdptr <= counter;

end Behavioral;
