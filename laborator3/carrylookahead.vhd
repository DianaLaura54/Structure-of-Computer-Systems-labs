
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

entity carrylookahead is Port( 
input_port_1 : in  std_logic
);
end carrylookahead;

architecture Behavioral of carrylookahead is
signal c:std_logic_vector(2 downto 0);
signal g,p:std_logic_vector(3 downto 0);

component partialfulladder
port(
x:in std_logic;
y:in std_logic;
cin:in std_logic;
g,p:out std_logic;
s:out std_logic
);
end component;

signal x: std_logic_vector(3 downto 0);
signal y: std_logic_vector(3 downto 0);
signal s: std_logic_vector(3 downto 0);
signal cin: std_logic;
signal cout:  std_logic;
begin
dut:partialfulladder port map(x=>x(0),y=>y(0),cin=>cin,g=>g(0),p=>p(0),s=>s(0));
dut2:partialfulladder port map(x=>x(1),y=>y(1),cin=>c(0),g=>g(1),p=>p(1),s=>s(1));
dut3:partialfulladder port map(x=>x(2),y=>y(2),cin=>c(1),g=>g(2),p=>p(2),s=>s(2));
dut4:partialfulladder port map(x=>x(3),y=>y(3),cin=>c(2),g=>g(3),p=>p(3),s=>s(3));
c(0) <= g(0) OR (p(0) AND cin);
c(1) <= g(1) OR (p(1) AND g(0)) OR (p(1) AND p(0) AND cin);
c(2) <= g(2) OR (p(2) AND g(1)) OR (p(2) AND p(1) AND g(0)) OR (p(2) AND p(1) AND p(0) AND cin);
cout <= g(3) OR (p(3) AND g(2)) OR (p(3) AND p(2) AND g(1)) OR (p(3) AND p(2) AND p(1) AND g(0)) OR (p(3) AND p(2) AND p(1) AND p(0) AND cin);

adder:process
begin
 x<="1000";
 y<="0001";
 cin<='1';
wait for 100ns;
x<="0100";
y<="0010";
cin<='0';
wait for 100ns;
x<="0011";
y<="0011";
cin<='1';
wait for 100ns;
x<="1001";
y<="1000";
cin<='1';
wait;
end process;

end Behavioral;