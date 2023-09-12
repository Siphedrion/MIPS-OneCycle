library ieee;
use ieee.std_logic_1164.all;

entity mux2x1tb is
end mux2x1tb;

architecture mixed of mux2x1tb is

  component mux2x1n
    generic(n: integer);
    port (
      a, b: in std_logic_vector(n-1 downto 0);
      sel: in std_logic;
      f: out std_logic_vector(n-1 downto 0)
    ) ;
  end component mux2x1n;

  signal A, B: std_logic_vector(31 downto 0);
  signal selector: std_logic;
  signal indicator: std_logic_vector(31 downto 0);

begin

  mux2x1_32: mux2x1n
    generic map(n => 32)
    port map(
      a => A,
      b => B,
      sel => selector,
      f => indicator
    );

  process begin
    A <= x"FFFFFFFF"; B <= x"80000000"; selector <= '1'; wait for 1 ns;
    A <= x"FFFFFFFF"; B <= x"80000000"; selector <= '0'; wait for 1 ns;
    wait;
  end process;

end mixed ; -- mixed