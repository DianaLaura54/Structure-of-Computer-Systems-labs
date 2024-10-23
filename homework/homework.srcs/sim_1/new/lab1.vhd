----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 10/17/2023 08:24:52 AM
-- Design Name: 
-- Module Name: labb - Behavioral
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

entity lab1 is 
end lab1;

architecture Behavioral of lab1 is

component xor_gate
port(a: in std_logic;
b:in std_logic;
c: out std_logic);
end component;

component dff
port(
clk: in std_logic;
d: in std_logic;
q: out std_logic);
end component;

component reg8
port (clk: in std_logic;
ce: in std_logic;
d: in std_logic_vector (7 downto 0);
q: out std_logic_vector (7 downto 0));
end component;

component shift_reg8
port (clk: in std_logic;
ce: in std_logic;
si: in std_logic;
so: out std_logic);
end component;

component count3
port(clk: in std_logic;
count: out integer range 0 to 7);
end component;


component mux 
port (a, b, c, d: in std_logic_vector (3 downto 0);
s: in std_logic_vector (1 downto 0);
x: out std_logic_vector (3 downto 0));
end component;


component decoder_1_8
port (a: in std_logic_vector (2 downto 0);
y: out std_logic_vector (7 downto 0));
end component;

component dmux41
   port(
      a,b,c,d: out std_logic_vector(7 downto 0);
      s: in std_logic_vector(1 downto 0);
      x: in std_logic_vector(7 downto 0)
   );
end component;

component bcd7seg
port ( BCD : in STD_LOGIC_VECTOR (3 downto 0);
Seven_Segment : out STD_LOGIC_VECTOR (6 downto 0));
end component;


signal at: std_logic;
signal bt:  std_logic;
signal ct: std_logic;
signal d:std_logic;
signal q:std_logic;
signal clk:std_logic;
signal ce:std_logic;
signal si:std_logic;
signal so:std_logic;
signal d1:  std_logic_vector (7 downto 0);
signal q1:  std_logic_vector (7 downto 0);
signal a, b, c, d2:  std_logic_vector (3 downto 0);
signal s: std_logic_vector (1 downto 0);
signal x:  std_logic_vector (3 downto 0);
signal a1: std_logic_vector(2 downto 0);
signal y:  std_logic_vector (7 downto 0);
signal count:  integer range 0 to 7;
signal a3,b3,c3,d3:  std_logic_vector(7 downto 0):="00000000";
signal s1:  std_logic_vector(1 downto 0);
signal x1:  std_logic_vector(7 downto 0);
signal BCD : STD_LOGIC_VECTOR (3 downto 0);
signal Seven_Segment :  STD_LOGIC_VECTOR (6 downto 0);

begin
--dut:xor_gate port map(a=>at,b=>bt,c=>ct);
--dut2: dff port map(clk=>clk,d=>d,q=>q);
--dut3:reg8 port map(clk=>clk,ce=>ce,d=>d1,q=>q1);
--dut4:shift_reg8 port map(clk=>clk,ce=>ce,si=>si,so=>so);
--dut5:count3 port map(clk=>clk,count=>count);
--dut6:mux port map(a=>a,b=>b,c=>c,d=>d2,s=>s,x=>x);
--dut7:decoder_1_8 port map(a=>a1,y=>y);
--dut8:dmux41 port map(a=>a3,b=>b3,c=>c3,d=>d3,s=>s1,x=>x1);
dut9:bcd7seg port map(BCD=>BCD,Seven_Segment=>Seven_Segment);

 --XOR GATE
  --stim_proc: process 
  --constant period:time :=200ns;   
 --begin   
   -- at <= '0';   
   -- bt <= '0';   
  --wait for period;  
   -- at <= '1';   
   -- bt <= '0';   
  -- wait for period;
   -- at <= '0';   
   -- bt <= '1';   
  --wait for period;
   -- at <= '1';   
    --bt <= '1';   
  --wait;  
 --end process; 
 
 --D FLIP FLOP
 --clock : process
 --begin
 --clk <= '0';
 --wait for 10 ns;
 --clk <= '1';
 --wait for 10 ns;
 --end process;
 
 --stim : process
 --begin
 --d <= '0';
 --wait for 40 ns;
 --d <= '1';
-- wait for 40 ns;
 
 --end process;
 
 --REGISTER
 --clk_process :process
 -- begin
 --clk <= '1';
 --wait for 100ns;
 --clk <= '0';
 --wait for 100ns;
  --end process;
  
  --stim_proc: process
  --begin
 --ce <= '1';
--d1 <= "10000011";
 --wait for 200ns;
 --ce <='0';
 --wait for 200 ns;
 --d1 <= "10001011";
 --wait for 200ns;
-- ce<='1';
 --d1 <= "11111111";
  --wait;
  --end process;

 
 --SHIFT REGISTER
 --clock_process :process
--begin
--clk <= '1';
--wait for 20ns;
--clk <= '0';
--wait for 20ns;
--end process;
 
 --stim_proc: process
 --begin
-- ce<='1';

 --si<='1';
 --wait for 10ns;
-- si<='0';
 --wait for 10ns;
-- si<='1';
 -- wait for 10ns;
 -- si<='0';
 --wait for 10ns;
 --si<='1';

 --wait;
 --end process;
 
 
 --COUNTER
 --clock_process :process
-- begin
    --  clk <= '0';
    --  wait for 10 ns;
    --  clk <= '1';
   --   wait for 10 ns;
-- end process;

 --MUX
 --stim_proc: process
   -- begin
  -- a <= "1111";
   -- b <= "1000";
   -- c <= "0000";
   -- d2 <= "1010";       
 --   s(0) <= '0'; s(1) <= '0';
   --   wait for 50 ns; 
  --  s(0)<= '1'; s(1) <= '0';
   -- wait for 50 ns; 
   -- s(0) <= '0'; s(1) <= '1';
   --      wait for 50 ns;   
   -- s(0) <= '1'; s(1) <= '1'; 
  --       wait for 50 ns;   
  -- end process;
 
 --DECODER
  --stim_proc: process
 --begin
 --a1 <= "000";
 --wait for 100 ns;
 --a1 <= "001";
-- wait for 100 ns;
-- a1 <= "010";
-- wait for 100 ns;
 --a1 <= "011";
 --wait for 100ns;
 --a1 <= "100";
 -- wait for 100 ns;
 -- a1 <= "101"; 
  -- wait for 100 ns;
 --  a1 <= "110"; 
  -- wait for 100 ns;
   -- a1 <= "111";
 --wait;
 --end process;
 
 --DMUX
  -- stim_proc: process
   -- begin      
   -- x1<="11111111";
   --s1(0) <= '0'; s1(1) <= '0';
     -- wait for 50 ns; 
 --  s1(0)<= '1'; s1(1) <= '0';
    -- wait for 50 ns; 
  -- s1(0) <= '0'; s1(1) <= '1';
   --  wait for 50 ns;   
  -- s1(0) <= '1'; s1(1) <= '1'; 
   --  wait for 50 ns;   
   -- end process;
   
   --BCD TO 7 SEG
   stim_proc: process
   begin
    
   BCD <= "0000";
   wait for 100 ns;
   BCD <= "0001";
   wait for 100 ns;
   BCD <= "0010";
   wait for 100 ns;
   BCD <= "0011";
   wait for 100 ns;
   BCD <= "0100";
   wait for 100 ns;
   BCD <= "0101";
   wait for 100 ns;
   BCD <= "0110";
   wait for 100 ns;
   BCD <= "0111";
   wait for 100 ns;
   BCD <= "1000";
   wait for 100 ns;
   BCD <= "1001";
   wait for 100 ns;
   end process;

 
end Behavioral;