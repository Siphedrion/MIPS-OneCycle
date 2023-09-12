library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture mixed of testbench is

  component instruction_memory
    port (
      addr: in std_logic_vector(31 downto 0);
      instruction: out std_logic_vector(31 downto 0)
    ) ;
  end component instruction_memory;

  signal switch: std_logic_vector(31 downto 0);
  signal indicator: std_logic_vector(31 downto 0);

begin

  rom: instruction_memory port map(
    addr => switch,
    instruction => indicator
  );

  stimuli : process
  begin
    for i in 0 to 7 loop
      switch <= std_logic_vector(to_unsigned(4*i, switch'length));
      wait for 1 ns;
    end loop;
    wait;
  end process stimuli; -- stimuli

end mixed ; -- mixed
