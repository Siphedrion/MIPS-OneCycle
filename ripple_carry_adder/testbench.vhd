library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture mixed of testbench is
  component ripple_carry_adder is
    generic (n: integer);
    port (
      a, b: in std_logic_vector(n-1 downto 0);
      cin: in std_logic;
      sum: out std_logic_vector(n-1 downto 0);
      cout: out std_logic
    ) ;
  end component ripple_carry_adder;
  signal switch_a: std_logic_vector(3 downto 0);
  signal switch_b: std_logic_vector(3 downto 0);
  signal indicator: std_logic_vector(3 downto 0);
  signal carry: std_logic;
begin
  carry_ripple_adder_u: ripple_carry_adder generic map(
    n => 4
  ) port map(
    a => switch_a,
    b => switch_b,
    cin => '0',
    cout => carry,
    sum => indicator
  );
  process begin
    switch_a <= "0010"; switch_b <= "0011"; wait for 1 ns;
    switch_a <= "0110"; switch_b <= "1011"; wait for 1 ns;
    switch_a <= "0010"; switch_b <= "1111"; wait for 1 ns;
    wait;
  end process;
end mixed ; -- mixed