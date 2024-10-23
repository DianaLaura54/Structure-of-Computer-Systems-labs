----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/24/2023 01:12:28 PM
-- Design Name: 
-- Module Name: wallacetree - Behavioral
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

entity wallacetree is 
Port ( 
input_port_1 : in  std_logic
);
end wallacetree;

architecture Behavioral of wallacetree is


component full_adder is
Port (
a: in std_logic;   
b:in std_logic;    
cin: in std_logic; 
s: out std_logic;  
cout: out std_logic
 );
end component;
signal x: std_logic_vector(3 downto 0 );
signal y:std_logic_vector(3 downto 0);
signal s0,s1,s2,s3,s4,s5,s6,s7,s8:std_logic;
signal c:std_logic_vector(0 to 10);

signal p:std_logic_vector(7 downto 0);
begin
p(0)<=x(0) and y(0);
dut: full_adder port map(x(1)and y(0),x(0) and y(1),'0',p(1),c(0));
dut1: full_adder port map(x(1) and y(1),x(2) and y(0),'0',s0,c(1));
dut2: full_adder port map(x(0) and y(2),s0,c(0),p(2),c(2));
dut3: full_adder port map(x(2) and y(1),x(3) and y(0),'0',s1,c(3));
dut4: full_adder port map(x(0) and y(3),s1,x(1) and y(2),s2,c(4));
dut5: full_adder port map(s2,c(1),c(2),p(3),c(5));
dut6: full_adder port map(x(2) and y(2),x(3) and y(1),'0',s3,c(6));
dut7: full_adder port map(s3,x(1) and y(3),c(3),s4,c(7));
dut9: full_adder port map(s4,c(4),c(5),p(4),c(8));
dut10: full_adder port map(x(3) and y(2),x(2) and y(3),c(6),s5,c(9));
dut11: full_adder port map(s5,c(7),c(8),p(5),c(10));
dut12: full_adder port map(c(9),x(3) and y(3),c(10),p(6),p(7));


multi:process
begin
 x<="1000";
 y<="0001";
 
wait for 100ns;
x<="0100";
y<="0010";

wait for 100ns;
x<="0011";
y<="0011";


wait;
end process;



end Behavioral;
