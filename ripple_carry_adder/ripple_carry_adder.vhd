library ieee;
use ieee.std_logic_1164.all;

entity ripple_carry_adder is
  --generic (n: integer := 32);
  port (
    a, b: in std_logic_vector(31 downto 0);
    cin: in std_logic;
    sum: out std_logic_vector(31 downto 0);
    cout: out std_logic
  ) ;
end ripple_carry_adder;

architecture structural of ripple_carry_adder is
  component full_adder
    port (
      x, y, cin: in std_logic;
      cout, sum: out std_logic
    );
  end component full_adder;
  signal carry_internal: std_logic_vector(31 downto 0);
begin
  fa_gen : for i in 0 to 31 generate
    lsb: if i = 0 generate
      fa_0 : full_adder port map(
        x => a(i),
        y => b(i),
        cin => cin,
        cout => carry_internal(i),
        sum => sum(i)
      );
    end generate lsb;
    upper: if i > 0 generate --There's not else generate
      fa_i : full_adder port map(
        x => a(i),
        y => b(i),
        cin => carry_internal(i-1),
        cout => carry_internal(i),
        sum => sum(i)
      );
    end generate upper;
  end generate ; -- fa_gen
  cout <= carry_internal(31);
end structural ; -- structural