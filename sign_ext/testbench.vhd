library ieee;
use ieee.std_logic_1164.all;

entity testbench is
  generic(imm_width: integer := 16);
end testbench;

architecture behavioral of testbench is
  component sign_ext
    generic (imm_width: integer);
    port (
      a: in std_logic_vector(imm_width-1 downto 0);
      a_extend: out std_logic_vector(2*imm_width-1 downto 0)
    );
  end component sign_ext;
  signal x: std_logic_vector(imm_width-1 downto 0);
  signal xtend: std_logic_vector(2*imm_width-1 downto 0);
begin
  sign_extend_u: sign_ext
    generic map(imm_width => imm_width)
    port map(
      a => x,
      a_extend => xtend
    );
  stimuli : process
  begin
    x <= x"0FFF"; wait for 1 ns;
    x <= x"FFFF"; wait for 1 ns;
    wait;
  end process stimuli; -- stimuli
end behavioral ; -- behavioral