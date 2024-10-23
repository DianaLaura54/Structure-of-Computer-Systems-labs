----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/15/2023 06:41:17 PM
-- Design Name: 
-- Module Name: module - Behavioral
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

entity module is  Port (

signal x:in std_logic
);
end module;

architecture Behavioral of module is
component range_adjuster is
Port (
aclk : IN STD_LOGIC;
s_axis_a_tvalid : IN STD_LOGIC;
s_axis_a_tready : OUT STD_LOGIC;
s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
s_axis_max_tvalid : IN STD_LOGIC;
s_axis_max_tready : OUT STD_LOGIC;
s_axis_max_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
s_axis_min_tvalid : IN STD_LOGIC;
s_axis_min_tready : OUT STD_LOGIC;
s_axis_min_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
m_axis_result_tvalid : OUT STD_LOGIC;
m_axis_result_tready : IN STD_LOGIC;
m_axis_result_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
end component;
component sliding_window_adder is

Port (
aclk : IN STD_LOGIC;
s_axis_a_tvalid : IN STD_LOGIC;
s_axis_a_tready : OUT STD_LOGIC;
s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
m_axis_sum_tvalid : OUT STD_LOGIC;
m_axis_sum_tready : IN STD_LOGIC;
m_axis_sum_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
);
end component;
signal min:  std_logic_vector(31 downto 0);
signal  max:  std_logic_vector(31 downto 0);
signal  a: std_logic_vector(31 downto 0);
signal sum:  std_logic_vector(31 downto 0);
signal aclk :  STD_LOGIC;
signal result :  STD_LOGIC_VECTOR(31 DOWNTO 0);
signal s_axis_a_tvalid :  STD_LOGIC;
signal s_axis_a_tready :  STD_LOGIC;
signal s_axis_max_tvalid : STD_LOGIC;
signal s_axis_max_tready :  STD_LOGIC;
signal s_axis_min_tvalid :  STD_LOGIC;
signal s_axis_min_tready :  STD_LOGIC;
signal m_axis_result_tvalid :  STD_LOGIC;
signal m_axis_result_tready :  STD_LOGIC;
signal m_axis_sum_tvalid: std_logic;
signal m_axis_sum_tready: std_logic;


begin
dut: range_adjuster port map(aclk=>aclk,s_axis_a_tvalid=>s_axis_a_tvalid ,s_axis_a_tready=>s_axis_a_tready,s_axis_a_tdata=>a,s_axis_max_tvalid =>s_axis_max_tvalid ,s_axis_max_tready=>s_axis_max_tready,s_axis_max_tdata =>max,s_axis_min_tvalid=>s_axis_min_tvalid,s_axis_min_tready=>s_axis_min_tready,s_axis_min_tdata =>min,m_axis_result_tvalid =>m_axis_result_tvalid,m_axis_result_tready =>m_axis_result_tready,m_axis_result_tdata =>result);
dut2:  sliding_window_adder port map(aclk=>aclk,s_axis_a_tvalid =>m_axis_result_tvalid,s_axis_a_tready =>m_axis_result_tready,s_axis_a_tdata =>result,m_axis_sum_tvalid =>m_axis_sum_tvalid,m_axis_sum_tready =>m_axis_sum_tready,m_axis_sum_tdata =>sum);





end Behavioral;
