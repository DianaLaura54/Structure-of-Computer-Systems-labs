----------------------------------------------------------------------------------
-- Company: 
-- Engineer: 
-- 
-- Create Date: 12/02/2023 07:02:40 PM
-- Design Name: 
-- Module Name: mips - Behavioral
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
-- use package 
USE work.procmem_definitions.ALL; 

-- Uncomment the following library declaration if using
-- arithmetic functions with Signed or Unsigned values
--use IEEE.NUMERIC_STD.ALL;

-- Uncomment the following library declaration if instantiating
-- any Xilinx leaf cells in this code.
--library UNISIM;
--use UNISIM.VComponents.all;

entity mips is
    Port ( clk : in STD_LOGIC;
           rst : in STD_LOGIC;
           alu_result : out STD_LOGIC_VECTOR (width-1 downto 0));
end mips;

architecture Behavioral of mips is

component pc IS 
    PORT ( 
    clk : IN STD_LOGIC; 
    rst_n : IN STD_LOGIC; 
    PC_en : IN STD_LOGIC; 
    pc_out : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0) );
END component; 

component memory is
    Port ( address : in STD_LOGIC_VECTOR (width-1 downto 0);
           data : in STD_LOGIC_VECTOR (width-1 downto 0);
           memRead : in STD_LOGIC;
           memWrite : in STD_LOGIC;
           value : out STD_LOGIC_VECTOR (width-1 downto 0));
end component;

component instreg IS 
    PORT ( 
    clk : IN STD_LOGIC; 
    rst_n : IN STD_LOGIC; 
    memdata : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0); 
    IRWrite : IN STD_LOGIC; 
    instr_31_26 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0); 
    instr_25_21 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); 
    instr_20_16 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0); 
    instr_15_0 : OUT STD_LOGIC_VECTOR(15 DOWNTO 0);
    instr_15_11 : OUT STD_LOGIC_VECTOR(4 DOWNTO 0);
    instr_5_0 : OUT STD_LOGIC_VECTOR(5 DOWNTO 0) ); 
END component; 

component phasegener is
    Port ( clk : in STD_LOGIC;
           reset : in STD_LOGIC;
           state : out STD_LOGIC_VECTOR (2 downto 0));
end component;

component control is
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
end component;

component regfile IS 
    PORT (clk,rst_n : IN std_logic; 
    wen : IN std_logic; -- write control 
    writeport : IN std_logic_vector(width-1 DOWNTO 0); -- register input 
    adrwport : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address write 
    adrport0 : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address port 0 
    adrport1 : IN std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address port 1 
    readport0 : OUT std_logic_vector(width-1 DOWNTO 0); -- output port 0 
    readport1 : OUT std_logic_vector(width-1 DOWNTO 0) -- output port 1 
    ); 
END component; 

component alu IS 
    PORT ( 
    a, b : IN STD_LOGIC_VECTOR(width-1 DOWNTO 0); 
    opcode : IN STD_LOGIC_VECTOR(1 DOWNTO 0); 
    result : OUT STD_LOGIC_VECTOR(width-1 DOWNTO 0); 
    zero : OUT STD_LOGIC); 
END component; 

signal PC_en : STD_LOGIC; 
signal pc_out : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
signal address : STD_LOGIC_VECTOR(width-1 DOWNTO 0);
signal data : STD_LOGIC_VECTOR (width-1 downto 0);
signal memRead : STD_LOGIC;
signal memWrite : STD_LOGIC;
signal value : STD_LOGIC_VECTOR (width-1 downto 0);
signal memdata : STD_LOGIC_VECTOR (width-1 downto 0);
signal IRWrite : STD_LOGIC; 
signal instr_31_26 : STD_LOGIC_VECTOR(5 DOWNTO 0); 
signal instr_25_21 : STD_LOGIC_VECTOR(4 DOWNTO 0); 
signal instr_20_16 : STD_LOGIC_VECTOR(4 DOWNTO 0); 
signal instr_15_0 : STD_LOGIC_VECTOR(15 DOWNTO 0); 
signal instr_15_11 : STD_LOGIC_VECTOR(4 DOWNTO 0); 
signal instr_5_0 : STD_LOGIC_VECTOR(5 DOWNTO 0); 
signal state : STD_LOGIC_VECTOR (2 downto 0);
signal regDst : STD_LOGIC;
signal regWrite : STD_LOGIC;
signal aluSrcB : STD_LOGIC_VECTOR(1 downto 0);
signal memToReg : STD_LOGIC;
signal aluOp : STD_LOGIC_VECTOR (1 downto 0);
signal writeport : std_logic_vector(width-1 DOWNTO 0); -- register input 
signal adrwport : std_logic_vector(regfile_adrsize-1 DOWNTO 0);-- address write 
signal readport0 : std_logic_vector(width-1 DOWNTO 0); -- output port 0 
signal readport1 : std_logic_vector(width-1 DOWNTO 0); -- output port 1 
signal instr_15_0_sign_ext : STD_LOGIC_VECTOR(width-1 DOWNTO 0); 
signal b : STD_LOGIC_VECTOR(width-1 DOWNTO 0); 
signal result : STD_LOGIC_VECTOR(width-1 DOWNTO 0); 
signal zero : STD_LOGIC; 

begin

program_counter: pc PORT MAP (clk => clk,
                              rst_n => rst,
                              PC_en => PC_en,
                              pc_out => pc_out);
                              
mem_address: process(pc_out, result, state)
begin
    if state = "011" then
--    if memRead = '1' or memWrite = '1' then
        address <= result;
    else
        address <= pc_out;
    end if;
end process mem_address;
                              
mem: memory PORT MAP (address => address,
                      data => readport1,
                      memRead => memRead,
                      memWrite => memWrite,
                      value => value);
                      
instruction_register: instreg PORT MAP (clk => clk,
                                        rst_n => rst,
                                        memdata => value,
                                        IRWrite => IRWrite,
                                        instr_31_26 => instr_31_26,
                                        instr_25_21 => instr_25_21,
                                        instr_20_16 => instr_20_16,
                                        instr_15_0 => instr_15_0,
                                        instr_15_11 => instr_15_11,
                                        instr_5_0 => instr_5_0);
                                        
phase_generator: phasegener PORT MAP (clk => clk,
                                      reset => rst,
                                      state => state);
                                      
control_unit: control port map(opcode => instr_31_26,
                               func => instr_5_0,
                               state => state,
                               memRead => memRead,
                               memWrite => memWrite,
                               aluSrcB => aluSrcB,
                               regDst => regDst,
                               regWrite => regWrite,
                               memToReg => memToReg,
                               irWrite => IRWrite,
                               pcWrite => PC_en,
                               aluOp => aluOp);
                               
writeportRes: process (memToReg, value, result)
begin
    if memToReg = '0' then
        writeport <= result;
    else
        writeport <= value;
    end if;
end process writeportRes;
                               
adrwportRes: process (regDst, instr_20_16, instr_15_11)
begin
    if regDst = '0' then
        adrwport <= instr_20_16;
    else
        adrwport <= instr_15_11;
    end if;
end process adrwportRes;
                               
register_file: regfile PORT MAP (clk => clk,
                                 rst_n => rst,
                                 wen => regWrite,
                                 writeport => writeport,
                                 adrwport => adrwport,
                                 adrport0 => instr_25_21,
                                 adrport1 => instr_20_16,
                                 readport0 => readport0,
                                 readport1 => readport1);
                                 
instr_15_0_sign_extension: process(instr_15_0)
begin
    instr_15_0_sign_ext(31 downto 16) <= (others => instr_15_0(15));
    instr_15_0_sign_ext(15 downto 0) <= instr_15_0;
end process instr_15_0_sign_extension;
                                 
aluSrcBRes: process (aluSrcB, readport1, instr_15_0_sign_ext)
begin
    if aluSrcB = "00" then
        b <= readport1;
    else
        b <= instr_15_0_sign_ext;
    end if;
end process aluSrcBRes;

                                   
arithm_logic_unit: alu PORT MAP (a => readport0,
                                 b => b,
                                 opcode => aluOp,
                                 result => result,
                                 zero => zero);
                                 
alu_result <= result;

end Behavioral;
