----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 07:02:52 PM
-- Design Name: 
-- Module Name: pc - Behavioral
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
LIBRARY IEEE; 
USE IEEE.std_logic_1164.ALL; 
USE IEEE.numeric_std.ALL; 
USE IEEE.std_logic_unsigned.ALL;
USE IEEE.std_logic_arith.ALL;
-- use package 
USE work.procmem_definitions.ALL; 

ENTITY pc IS 
    PORT ( 
    clk : IN STD_LOGIC; 
    rst_n : IN STD_LOGIC; 
    PC_en : IN STD_LOGIC; 
    pc_out : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0) );
END pc; 

ARCHITECTURE behave OF pc IS 

SIGNAL pc_temp : STD_LOGIC_VECTOR(width-1 DOWNTO 0) := (OTHERS => '0'); 

BEGIN 
    proc_pc : PROCESS(clk, rst_n)  
        BEGIN 
            IF rst_n = '0' THEN 
                pc_temp <= (OTHERS => '0'); 
            ELSIF RISING_EDGE(clk) and PC_en = '1' THEN 
                pc_temp <= pc_temp + 1;
            END IF; 
            pc_out <= pc_temp; 
    END PROCESS; 
END behave; 
