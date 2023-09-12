library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity ctrl_unit is
    port ( op : in std_logic_vector(5 downto 0);
           RegDst, ALUSrc, MemToReg, RegWrite : out std_logic; 
           MemRead, MemWrite, Branch, Jump : out std_logic;
           ALUOp : out std_logic_vector(1 downto 0) );
end ctrl_unit;

architecture comportamiento of ctrl_unit is
    signal ctrl_word : std_logic_vector(9 downto 0);
begin
    with op select
        ctrl_word <= "0100100010" when "000000",
                     "0011110000" when "100011",
                     "0010001000" when "101011",
                     "0000000101" when "000100",
                     "1000000000" when "000010",
                     "0010100011" when "001000",
                     "ZZZZZZZZZZ" when others;
    RegDst <= ctrl_word(8); ALUSrc <= ctrl_word(7); MemToReg <= ctrl_word(6);
    RegWrite <= ctrl_word(5); MemRead <= ctrl_word(4); MemWrite <= ctrl_word(3);
    Branch <= ctrl_word(2); ALUOp <= ctrl_word(1 downto 0); Jump <= ctrl_word(9);
end comportamiento;
