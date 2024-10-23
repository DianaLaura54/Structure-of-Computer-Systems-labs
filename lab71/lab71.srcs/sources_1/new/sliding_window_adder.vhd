----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/14/2023 09:11:05 AM
-- Design Name: 
-- Module Name: sliding_window_adder - Behavioral
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
use ieee.numeric_std.all;
use IEEE.std_logic_signed.all;


-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity sliding_window_adder is

    Generic (
        WINDOW_SIZE : integer := 5
    );
    
    Port (
        aclk : IN STD_LOGIC;
        s_axis_a_tvalid : IN STD_LOGIC;
        s_axis_a_tready : OUT STD_LOGIC;
        s_axis_a_tdata : IN STD_LOGIC_VECTOR(31 DOWNTO 0);
        m_axis_sum_tvalid : OUT STD_LOGIC;
        m_axis_sum_tready : IN STD_LOGIC;
        m_axis_sum_tdata : OUT STD_LOGIC_VECTOR(31 DOWNTO 0)
    );
    
end sliding_window_adder;

architecture Behavioral of sliding_window_adder is

type state_type is (READ_OPERANDS, WRITE_RESULT);
signal state : state_type := READ_OPERANDS;

signal res_valid : STD_LOGIC := '0';
signal result : STD_LOGIC_VECTOR (31 downto 0) := (others => '0');

signal a_ready : STD_LOGIC := '0';
signal internal_ready, external_ready, inputs_valid : STD_LOGIC := '0';


type std is array (0 to WINDOW_SIZE - 1) of std_logic_vector(31 downto 0);


begin



s_axis_a_tready <= external_ready;

internal_ready <= '1' when state = READ_OPERANDS else '0';
inputs_valid <= s_axis_a_tvalid;

external_ready <= internal_ready and inputs_valid;

m_axis_sum_tvalid <= '1' when state = WRITE_RESULT else '0';
m_axis_sum_tdata <= result;


process(aclk)
variable index : integer range 0 to WINDOW_SIZE - 1 := 0; 
variable window:  std;
variable sum : std_logic_vector (31 downto 0) := (others => '0');



begin

if rising_edge(aclk) then

    case state is
        when READ_OPERANDS =>
            if external_ready = '1' and inputs_valid = '1' then
               
                 window(index) := s_axis_a_tdata;
                sum :=  s_axis_a_tdata;
                
                if index < WINDOW_SIZE - 1 then
                    index := index + 1;
                else index := 0;
                end if;
               
                suma : for i in 0 to WINDOW_SIZE-1 loop
                if i /= index then
                  sum := sum + window(i);
                      end if;
                end loop suma;
        
                
                
                result <= sum;
                state <= WRITE_RESULT;
            end if;
            
        when WRITE_RESULT =>
            if m_axis_sum_tready = '1' then
                state <= READ_OPERANDS;
            end if;
    end case;
    
end if;

end process;



end Behavioral;

