library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity testbench is
  generic(width: integer := 32);
end testbench;

architecture behavioral of testbench is
  component alu
    generic (width: integer);
    port (
      a, b: in std_logic_vector(width-1 downto 0);
      opcode: in std_logic_vector(3 downto 0);
      result: out std_logic_vector(width-1 downto 0);
      status: out std_logic_vector(3 downto 0) --cvnz
    );
  end component alu;
  signal oper_a, oper_b, result: std_logic_vector(width-1 downto 0);
  signal opcode, status: std_logic_vector(3 downto 0);
begin
  alu32: alu
  generic map(width => width)
  port map(
    a => oper_a,
    b => oper_b,
    opcode => opcode,
    result => result,
    status => status
  );
  stimuli : process
  begin
    oper_a <= x"000000FF";
    oper_b <= x"0000FF00";
    opcode <= "0000"; wait for 1 ns;  --a and b
    opcode <= "0001"; wait for 1 ns;  --a or b
    opcode <= "1100"; wait for 1 ns;  --a nor b
    opcode <= "0010"; wait for 1 ns;  --a + b
    opcode <= "0110"; wait for 1 ns;  --a - b
    opcode <= "0111"; wait for 1 ns;  --a < b
    wait;
  end process stimuli; -- stimuli
end behavioral ; -- behavioral