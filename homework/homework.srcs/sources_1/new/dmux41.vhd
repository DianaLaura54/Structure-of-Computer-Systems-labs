----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 18.10.2023 15:33:44
-- Design Name: 
-- Module Name: mux41 - Behavioral
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

entity dmux41 is
   port(
      a,b,c,d: out std_logic_vector(7 downto 0);
      s: in std_logic_vector(1 downto 0);
      x: in std_logic_vector(7 downto 0)
   );
end dmux41;


architecture arch_dmux of dmux41 is
begin
  process(s,x)
  begin
      case s is
        when "00" =>
           a<=x;
         when "01" =>
             b<=x;
         when "10" =>
             c<=x;
         when others =>
           d<=x;
      end case;
   end process;
end arch_dmux;
