library IEEE;
use IEEE.STD_LOGIC_1164.ALL;
use IEEE.STD_LOGIC_ARITH.ALL;
use IEEE.STD_LOGIC_UNSIGNED.ALL;

entity control_unit is
    Port (
        clk : in STD_LOGIC;
        reset : in STD_LOGIC;
        phase: out  STD_LOGIC_VECTOR(2 downto 0);
        opcode : in STD_LOGIC_VECTOR(5 downto 0);
        funct : in STD_LOGIC_VECTOR(5 downto 0);
        MemRead, MemWrite, RegDst, RegWrite, AluSrcA, AluSrcB, MemtoReg, IRWrite, PCWrite : out STD_LOGIC;
        aluOp: out std_logic_vector(1 downto 0)
    );
end control_unit;

architecture Behavioral of control_unit is
    signal phase_output : STD_LOGIC_VECTOR(2 downto 0);
    signal alu_out_signal : STD_LOGIC_VECTOR(1 downto 0):="00";
    type StateType is (FETCH, DECODE, EXECUTE, MEMORY, WRITEBACK);
    signal currentState, nextState : StateType;

    signal fetchState : STD_LOGIC_VECTOR(2 downto 0) := "000";
    signal decodeState : STD_LOGIC_VECTOR(2 downto 0) := "001";
    signal executeState : STD_LOGIC_VECTOR(2 downto 0) := "010";
    signal memoryState : STD_LOGIC_VECTOR(2 downto 0) := "011";
    signal writebackState : STD_LOGIC_VECTOR(2 downto 0) := "100";

begin
    process(clk, reset)
    begin
        if reset = '1' then
            currentState <= FETCH;
        elsif rising_edge(clk) then
            currentState <= nextState;
        end if;
    end process;

    process(currentState)
    begin
        case currentState is
            when FETCH =>
                phase_output <= fetchState;
                nextState <= DECODE;
            when DECODE =>
                phase_output <= decodeState;
                nextState <= EXECUTE;
            when EXECUTE =>
                phase_output <= executeState;
                nextState <= MEMORY;
            when MEMORY =>
                phase_output <= memoryState;
                nextState <= WRITEBACK;
            when WRITEBACK =>
                phase_output <= writebackState;
                nextState <= FETCH;
            when others =>
                phase_output <= fetchState;
                nextState <= FETCH;
        end case;
    end process;
    phase<= phase_output;
    
    
    process(opcode, phase_output)
    begin
        MemRead <= '0';
        MemWrite <= '0';
        RegDst <= '0';
        RegWrite <= '0';
        AluSrcA <= '0';
        AluSrcB <= '0';
        MemtoReg <= '0';
        IRWrite <= '0';
        PCWrite <= '0';

        case phase_output is
            when "000" => -- FETCH
                PCWrite <= '1';
                IRWrite <= '1'; 
                MemRead <= '1';
                AluSrcA <= '0';
                AluSrcB <= '0';

            when "001" => -- DECODE
                 -- R-Type
                        RegDst <= '0';
                        RegWrite <= '0';
                        AluSrcA <= '0';
                        AluSrcB <= '0';
                        MemtoReg <= '0';        
                        MemRead <= '0';
                        PCWrite <= '0'; 
                        IRWrite<='0';
                        MemWrite<='0';
             

            when "010" => -- EXECUTE
                case opcode is
                    when "000000" => -- R-Type
                         RegWrite <= '1';
                        AluSrcA <= '1';
                        AluSrcB <= '1';
                    when "100011" | "101011" => -- Load, Store
                         RegWrite <= '1';
                        AluSrcA <= '1';
                    when others => null;
                end case;

            when "011" => -- MEMORY
                case opcode is
                    when "000000" => --r type
                        RegDst<='1';
                        MemWrite <= '1';
                        MemtoReg <= '0';
                        RegWrite <= '1';
                    when "100011" => -- (Load)
                        MemRead <= '1';
                        MemWrite <= '0';
                        
                    when "101011" => -- (Store)
                        MemRead <= '0';
                        MemWrite <= '1';
                    when others => null;
                end case;

            when "100" => -- WRITEBACK
                case opcode is
                    when "100011" => -- (Load)
                        RegWrite <= '1';
                        MemtoReg <= '1';
                        RegDst <= '0';
                    when others => 
                        RegWrite <= '1';
                        MemtoReg <= '0';
                end case;

            when others =>   -- error
              MemRead <= '0';
        MemWrite <= '0';
        RegDst <= '0';
        RegWrite <= '0';
        AluSrcA <= '0';
        AluSrcB <= '0';
        MemtoReg <= '0';
        IRWrite <= '0';
        PCWrite <= '0';
        end case;
    end process;
    
    
    
    process(phase_output,funct, opcode )
    begin
    case phase_output is
    when "010" => --execute
      case opcode is 
      when "100011" => aluOp <="00";
      when "101011" => aluOp <="00";
      when "000000" =>
        case funct is 
            when "100000"=> aluOp <="00";
            when "100010" =>aluOp <="01";
            when "100100" => aluOp <="10";
            when "100101" => aluOp <="11";
            when others => aluOp<="00";
        end case;
      when others =>   aluOp <= "00";
      end case;
    when others =>   aluOp <= "00";
    end case;
    end process;

end Behavioral;