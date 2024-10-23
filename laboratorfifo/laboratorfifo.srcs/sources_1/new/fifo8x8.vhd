----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/31/2023 08:53:24 AM
-- Design Name: 
-- Module Name: fifo8x8 - Behavioral
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

entity fifo8x8 is
 Port ( 
 data_in: in std_logic_vector(7 downto 0);
 wr: in std_logic;
 rd: in std_logic;
 clk:in std_logic;
 reset:in std_logic;
 data_out:out std_logic_vector(7 downto 0);
 empty,full: out std_logic
 );
end fifo8x8;

architecture Behavioral of fifo8x8 is
type reg_array is array(0 to 7) of std_logic_vector(7 downto 0);
signal reg:reg_array;
signal wrptr: std_logic_vector(2 downto 0);
signal rdptr:std_logic_vector(2 downto 0);
signal a,b,c,d,e,f,g,h: std_logic;
signal a2,b2,c2,d2,e2,f2,g2,h2: std_logic;
signal yes:std_logic_vector(7 downto 0);
signal y:std_logic_vector(7 downto 0);
signal wrinc,rdinc:std_logic;

component mux is
port (a, b, c, d,e,f,g,h: in std_logic_vector (7 downto 0);
s: in std_logic_vector (2 downto 0);
x: out std_logic_vector (7 downto 0));
end component;

component tristatebuffer is
Port (
rd : in STD_LOGIC;
         data_in : in STD_LOGIC_vector(7 downto 0);
         data_out : out STD_LOGIC_vector(7 downto 0) );
end component;

component read_pointer is Port ( 
rdinc: in std_logic;
clk:in std_logic;
reset:in std_logic;
rdptr:out std_logic_vector(2 downto 0)
);
end component;

component write_pointer is Port ( 
wrinc: in std_logic;
clk:in std_logic;
reset:in std_logic;
wrptr:out std_logic_vector(2 downto 0)
);
end component;

component fifo_ctrl is  Port ( 
clk:in std_logic;
rst:in std_logic;
empty: out std_logic;
full: out std_logic;
wrptr: in std_logic_vector(2 downto 0);
rdptr: in std_logic_vector(2 downto 0)
);
end component;

component decoderr is
   port(
      a,b,c,d,e,f,g,h: out std_logic:='0';
      s: in std_logic_vector(2 downto 0)
   );
end component;

begin
dut:fifo_ctrl port map(clk=>clk,rst=>reset,empty=>empty,full=>full,wrptr=>wrptr,rdptr=>rdptr);
dut2: write_pointer port map(wrinc=>wrinc,clk=>clk,reset=>reset,wrptr=>wrptr);
dut3: read_pointer port map(rdinc=>rdinc,clk=>clk,reset=>reset,rdptr=>rdptr);
dut4: decoderr port map(a=>a,b=>b,c=>c,d=>d,e=>e,f=>f,g=>g,h=>h,s=>wrptr);
a2<=a and wr;
b2<=b and wr;
c2<=c and wr;
d2<=d and wr;
e2<=e and wr;
f2<=f and wr;
g2<=g and wr;
h2<=h and wr;
 
pick:process(a2,b2,c2,d2,e2,f2,g2,h2,data_in)
begin
if a2='1' then
reg(7)<=data_in;
end if;
if b2='1' then
reg(6)<=data_in;
end if;
if c2='1' then
reg(5)<=data_in;
end if;
if d2='1' then
reg(4)<=data_in;
end if;
if e2<='1' then 
reg(3)<=data_in;
end if;
if f2<='1' then
reg(2)<=data_in;
end if;
if g2='1' then
reg(1)<=data_in;
end if;
if h2='1' then
reg(0)<=data_in;
end if;
end process;
dut5:mux port map(a=>reg(7),b=>reg(6),c=>reg(5),d=>reg(4),e=>reg(3),f=>reg(2),g=>reg(1),h=>reg(0),s=>rdptr,x=>yes);
dut6:tristatebuffer port map(rd=>rd,data_in=>yes,data_out=>y);
data_out<=y;

end Behavioral;

