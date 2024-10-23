----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/03/2023 10:43:54 PM
-- Design Name: 
-- Module Name: tristatebuffer - Behavioral
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
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity tristatebuffer is
Port (
rd : in STD_LOGIC;
         data_in : in STD_LOGIC_vector(7 downto 0);
         data_out : out STD_LOGIC_vector(7 downto 0)
         );
end tristatebuffer;

architecture Behavioral of tristatebuffer is

begin
  process(rd, data_in)
  begin
    if rd = '1' then
      data_out <= data_in;
    else
      data_out <= "ZZZZZZZZ"; -- High-impedance state
    end if;
  end process;

end Behavioral;
