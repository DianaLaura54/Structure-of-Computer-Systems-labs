----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 07:03:53 PM
-- Design Name: 
-- Module Name: ProcMem_definitions - Behavioral
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


PACKAGE ProcMem_definitions IS 
-- globals 
CONSTANT width : NATURAL := 32; 
-- definitions for regfile 
CONSTANT regfile_depth : positive := 32; -- register file depth = 2**adrsize 
CONSTANT regfile_adrsize : positive := 5; -- address vector size = log2(depth) 
END ProcMem_definitions;
