library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture mixed of testbench is

  component sll2bit
    port (
      imm32: in std_logic_vector(31 downto 0);
      addr: out std_logic_vector(31 downto 0)
    );
  end component sll2bit;

  signal imm:  std_logic_vector(31 downto 0);
  signal addr: std_logic_vector(31 downto 0);

begin

  sll2_u: sll2bit port map(
    imm32 => imm,
    addr => addr
  );

  stimuli : process
  begin
    imm <= x"00000002"; wait for 1 ns;
    imm <= x"00000004"; wait for 1 ns;
    wait;
  end process ; -- stimuli
end mixed ; -- mixed