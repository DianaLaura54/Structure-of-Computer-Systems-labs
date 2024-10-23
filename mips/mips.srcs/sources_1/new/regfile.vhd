----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 07:03:21 PM
-- Design Name: 
-- Module Name: regfile - Behavioral
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
-- use package 
USE work.procmem_definitions.ALL; 

ENTITY regfile IS 
    PORT (clk,rst_n : IN std_logic; 
    wen : IN std_logic; -- write control 
    writeport : IN std_logic_vector(width-1 DOWNTO 0); -- register input 
    adrwport : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address write 
    adrport0 : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address port 0 
    adrport1 : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address port 1 
    readport0 : OUT std_logic_vector(width-1 DOWNTO 0); -- output port 0 
    readport1 : OUT std_logic_vector(width-1 DOWNTO 0) -- output port 1 
    ); 
END regfile; 

ARCHITECTURE behave OF regfile IS 

SUBTYPE WordT IS std_logic_vector(width-1 DOWNTO 0); -- reg word TYPE 
TYPE StorageT IS ARRAY(0 TO regfile_depth-1) OF WordT; -- reg array TYPE 
SIGNAL registerfile : StorageT := (
0 => B"00000000000000000000000000000101",
1 => B"00000000000000000000000000000110",
2 => B"00000000000000000000000000000111",
others => (others => '0')
); -- reg file contents 

BEGIN 
-- perform write operation 
    PROCESS(rst_n, clk) 
    BEGIN 
        IF rst_n = '0' THEN 
            FOR i IN 0 TO regfile_depth-1 LOOP 
                registerfile(i) <= (OTHERS => '0'); 
            END LOOP; 
        ELSIF rising_edge(clk) THEN 
            IF wen = '1' THEN 
                registerfile(to_integer(unsigned(adrwport))) <= writeport; 
            END IF; 
        END IF; 
    END PROCESS; 
    
    -- perform reading ports 
    readport0 <= registerfile(to_integer(unsigned(adrport0))); 
    readport1 <= registerfile(to_integer(unsigned(adrport1))); 
END behave; 