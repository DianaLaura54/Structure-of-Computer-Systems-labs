----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2023 08:31:17 AM
-- Design Name: 
-- Module Name: carrylookahead - Behavioral
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

entity carrylookahead is port( 
x:in std_logic_vector(3 downto 0);
y:in std_logic_vector(3 downto 0);
s:out std_logic_vector(3 downto 0)
);
end carrylookahead;

architecture Behavioral of carrylookahead is
signal g,p:std_logic_vector(3 downto 0);
signal c:std_logic_vector(0 to 4);
component partialfulladder
port(
x:in std_logic;
y:in std_logic;
cin:in std_logic;
g,p:out std_logic;
s:out std_logic;
);
end component;
begin

dut:partialfulladder port map(x=>x(0),y=>y(0),cin=>c(0),g=>g(0),p=>p(0),s=>s(0));
c(1)<=g(0) or (p(0) and c(0));
dut2:partialfulladder port map(x=>x(1),y=>y(1),cin=>c(1),g=>g(1),p=>p(1),s=>s(1));
c(2)<=g(1) or (p(1) and c(1));
dut3:partialfulladder port map(x=>x(2),y=>y(2),cin=>c(2),g=>g(2),p=>p(2),s=>s(2));
c(3)<=g(2) or (p(2) and c(2));
dut4:partialfulladder port map(x=>x(3),y=>y(3),cin=>c(3),g=>g(3),p=>p(3),s=>s(3));
c(4)<=g(3) or (p(3) and c(3));


end Behavioral;
