----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 07:02:14 PM
-- Design Name: 
-- Module Name: control - Behavioral
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

entity control is
    Port ( opcode : in STD_LOGIC_VECTOR (5 downto 0);
           func : in STD_LOGIC_VECTOR (5 downto 0);
           state : in STD_LOGIC_VECTOR (2 downto 0);
           memRead : out STD_LOGIC;
           memWrite : out STD_LOGIC;
           regDst : out STD_LOGIC;
           regWrite : out STD_LOGIC;
           aluSrcA : out STD_LOGIC;
           aluSrcB : out STD_LOGIC_vector(1 downto 0);
           memToReg : out STD_LOGIC;
           irWrite : out STD_LOGIC;
           pcWrite : out STD_LOGIC;
           aluOp : out STD_LOGIC_VECTOR (1 downto 0));
end control;
--(00-from B
--01-for PC=PC+4
--10-for signed
--11-for shift left)
architecture Behavioral of control is

begin

control_unit: process(opcode, state)
begin
        MemRead <= '0';
        MemWrite <= '0';
        RegDst <= '0';
        RegWrite <= '0';
        AluSrcA <= '0';
        AluSrcB <= "00";
        MemtoReg <= '0';
        IRWrite <= '0';
        PCWrite <= '0';
       
        
        case state is
            when "000" =>  -- instruction fetch
                memRead <= '1';   
                irWrite <= '1';   
                pcWrite <= '1';
                
            when "001" =>  -- instruction decode
                memRead <= '0';   
                memWrite <= '0';  
                regDst <= '0';    
                regWrite <= '0';   
                aluSrcB <= "00";
                memToReg <= '0';  
                irWrite <= '0';   
                pcWrite <= '0';
                aluSrcA<='0';
                
            when "010" =>  -- execute
            if opcode = "000000"  then
                regDst <= '1'; 
                aluSrcA<= '1';  
                aluSrcB<="00"; 
                  end if;
                 
        if opcode = "100011"  then
                aluSrcA<='1';
                 aluSrcB<="01"; 
                end if;
              if opcode = "101011"  then
                 aluSrcB<="10";
             aluSrcA<='1';  
                 end if;
                
                  when "011" =>  -- memory
            if opcode = "000000" then
                RegWrite <= '1';
                RegDst <= '1';
            end if;
            
            if opcode = "100011" then
                MemRead <= '1';
            end if;
            
            if opcode = "101011" then
                MemWrite <= '1';  
            end if;
            
        when "100" =>  -- write back
            if opcode = "100011" then
                MemtoReg <= '1';
                RegWrite <= '1';
            end if;  
                
            when others =>  -- error
                memRead <= '0';   
                memWrite <= '0';  
                regDst <= '0';    
                regWrite <= '0';   
                aluSrcB <= "00";   
                memToReg <= '0';  
                irWrite <= '0';   
                pcWrite <= '0';
                aluSrcA<='0';
        end case;
end process control_unit;

alu_control_unit: process(opcode, state)
begin
        case state is
            when "010" =>  -- execute
                case func is
                    when "100000" => aluOp <= "00";  -- add
                    when "100010" => aluOp <= "01";  -- sub
                    when "100100" => aluOp <= "10";  -- and
                    when "100101" => aluOp <= "11";  -- or
                    when others => aluOp <= "00";  -- error
                end case;
            when others =>  -- others 
                aluOp <= "00";
        end case;
end process alu_control_unit;

end Behavioral;

