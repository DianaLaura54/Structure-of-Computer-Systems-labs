----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2023 08:48:28 AM
-- Design Name: 
-- Module Name: FIFO - Behavioral
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

entity FIFO is
 Port ( 
 data_in: in std_logic_vector(7 downto 0);
 btn_wr: in std_logic;
 btn_rd: in std_logic;
 clk:in std_logic;
 reset:in std_logic;
 empty:out std_logic;
 full:out std_logic;
 sreg: out std_logic_vector(6 downto 0);
 an:out std_logic_vector(3 downto 0)
 );
end FIFO;

architecture Behavioral of FIFO is
component filter is  Port 
( btn: in std_logic;
clk:in std_logic;
reset: in std_logic;
btn2: out std_logic
);
end component;

component display is Port (
clk:in std_logic;
reset:in std_logic;
data:in std_logic_vector(15 downto 0);
an: out std_logic_vector(3 downto 0);
sreg:out std_logic_vector(6 downto 0)
 );
end component;

component fifo8x8 is Port ( 
rdinc: in std_logic;
wrinc: in std_logic;
clk:in std_logic;
reset:in std_logic;
data_in: in std_logic_vector(7 downto 0);
rd: in std_logic;
wr:in std_logic;
data_out: out std_logic_vector(7 downto 0)
);
end component;

component fifo_ctrl is  Port ( 
rd:in std_logic;
wr: in std_logic;
clk:in std_logic;
rst:in std_logic;
empty: out std_logic;
full: out std_logic;
wrinc: out std_logic;
rdinc: out std_logic
);
end component;
begin
c1: fifo8x8 port map(

end Behavioral;
