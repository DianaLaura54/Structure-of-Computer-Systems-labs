----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/04/2023 07:34:36 PM
-- Design Name: 
-- Module Name: decoder - Behavioral
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
entity decoderr is
   port(
      a,b,c,d,e,f,g,h: out std_logic:='0';
      s: in std_logic_vector(2 downto 0)
   );
end decoderr;

architecture Behavioral of decoder is
begin
  process(s)
  begin
      case s is
        when "000" =>
           a<='1';
         when "001" =>
             b<='1';
         when "010" =>
             c<='1';
         when "011" =>
           d<='1';
           when "100"=>
           e<='1';
           when "101"=>
           f<='1';
           when "110"=>
           g<='1';
           when others=>
           h<='1';
      end case;
   end process;
end Behavioral;
