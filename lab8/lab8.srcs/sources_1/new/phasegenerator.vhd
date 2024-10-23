----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/21/2023 08:30:11 AM
-- Design Name: 
-- Module Name: phasegenerator - Behavioral
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
use IEEE.std_logic_unsigned.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity phasegener is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           state : out STD_LOGIC_VECTOR (2 downto 0));
end phasegener;

architecture Behavioral of phasegener is

signal curr_state : STD_LOGIC_VECTOR (2 downto 0) := "000";

begin

    process(clk, reset)
    begin
        if reset = '0' then
            curr_state <= "000";
        else
            if rising_edge(clk) then
                if curr_state = "100" then
                    curr_state <= "000";
                else
                    curr_state <= curr_state + 1;
                end if;
            end if;
        end if;
    end process;
    
    state <= curr_state;

end Behavioral;
