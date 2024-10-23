----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/11/2023 10:25:18 PM
-- Design Name: 
-- Module Name: tlb_phase - Behavioral
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

entity tlb_phase is
end tlb_phase;

architecture Behavioral of tlb_phase is

    signal clk_tb     : STD_LOGIC := '0';
    signal reset_tb   : STD_LOGIC := '0';
    signal state_tb   : STD_LOGIC_VECTOR(2 downto 0);

    component phasegener
        Port ( clk : in STD_LOGIC;
               reset : in STD_LOGIC;
               state : out STD_LOGIC_VECTOR(2 downto 0));
    end component;

begin

    uut : phasegener
        port map (clk => clk_tb, reset => reset_tb, state => state_tb);

    clk_process: process
    begin
        while now < 100 ns loop
            clk_tb <= not clk_tb;
            wait for 5 ns;
        end loop;
        wait;
    end process;

    stimulus_process: process
    begin
        reset_tb <= '0';
        wait for 10 ns;
        reset_tb <= '1';

        wait for 200 ns;


        wait;

    end process;

end Behavioral;
