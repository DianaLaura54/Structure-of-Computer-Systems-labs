library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_unit_tb is
end control_unit_tb;

architecture Behavioral of control_unit_tb is
    signal clk : STD_LOGIC := '0';
    signal reset : STD_LOGIC := '0';
    signal opcode : STD_LOGIC_VECTOR(5 downto 0) := "000000";
    signal funct : STD_LOGIC_VECTOR(5 downto 0) := "000000";
    signal phase : STD_LOGIC_VECTOR(2 downto 0);
    signal MemRead, MemWrite, RegDst, RegWrite, AluSrcA, AluSrcB, MemtoReg, IRWrite, PCWrite : STD_LOGIC;
    signal aluOp : STD_LOGIC_VECTOR(1 downto 0);

    constant clock_period : time := 10 ns; 

    
    component control_unit
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
    
    uut: control_unit
        port map (
            clk => clk,
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
            aluOp => aluOp
        );

  
    process
    begin
        while now < 1000 ns loop 
            clk <= not clk;
            wait for clock_period / 2;
        end loop;
        wait;
    end process;

    
    process
    begin
        reset <= '1';
        wait for 20 ns;
        reset <= '0';

        wait for 10 ns; 
        for i in 0 to 4 loop
            wait until rising_edge(clk);
            opcode <= "000000";
            funct <= "000000";
            wait until rising_edge(clk);
            case i is
                when 0 =>
                    opcode <= "000000";
                    funct <= "100000"; -- R-Type
                when 1 =>
                    opcode <= "100011"; -- Load
                    funct <= "000000";
                when 2 =>
                    opcode <= "101011"; -- Store
                    funct <= "000000";
                when 3 =>
                    opcode <= "000000";
                    funct <= "100010"; -- R-Type
                when 4 =>
                    opcode <= "100011"; -- Load
                    funct <= "000000";
            end case;

            wait until rising_edge(clk);

          
        end loop;

        wait;
    end process;

end Behavioral;

