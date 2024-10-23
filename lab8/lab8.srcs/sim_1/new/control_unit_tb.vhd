----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 11/30/2023 03:53:10 PM
-- Design Name: 
-- Module Name: tb_mips_ctrl_unit - Behavioral
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

entity control_unit_tb is
end control_unit_tb;

architecture tb_architecture of control_unit_tb is
    signal clk, reset: std_logic;
    signal funct,opcode : std_logic_vector(5 downto 0);
    signal phase: std_logic_vector(2 downto 0);
    signal MemRead, MemWrite, RegDst, RegWrite, AluSrcA, AluSrcB, MemtoReg, IRWrite, PCWrite: std_logic;
    signal aluOp : std_logic_vector(1 downto 0);
    
   component control_unit is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        phase: out  STD_LOGIC_VECTOR(2 downto 0);
        opcode : in STD_LOGIC_VECTOR(5 downto 0);
        funct : in STD_LOGIC_VECTOR(5 downto 0);
        MemRead, MemWrite, RegDst, RegWrite, AluSrcA, AluSrcB, MemtoReg, IRWrite, PCWrite : out STD_LOGIC;
        aluOp: out std_logic_vector(1 downto 0)
    );
end component;
begin
dut: control_unit port map( clk => clk,
            reset => reset,
            phase => phase,
            opcode => opcode,
            funct => funct,
            MemRead => MemRead,
            MemWrite => MemWrite,
            RegDst => RegDst,
            RegWrite => RegWrite,
            AluSrcA => AluSrcA,
            AluSrcB => AluSrcB,
            MemtoReg => MemtoReg,
            IRWrite => IRWrite,
            PCWrite => PCWrite,
            aluOp => aluOp);
         
pro:process
begin
opcode<="000000";
func<="100000";
clk<='1';

wait;
end process;          
            
            
            
end tb_architecture;