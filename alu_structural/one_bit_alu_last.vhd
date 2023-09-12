library ieee;
use ieee.std_logic_1164.all;

entity one_bit_alu_last is
  port (
    a, b, set, cin: in std_logic;
    opcode: in std_logic_vector(3 downto 0);
    result, cout, sign_bit: out std_logic
  ) ;
end one_bit_alu_last;

architecture structural of one_bit_alu_last is
  component mux2x1
    port (
      a, b, sel: in std_logic;
      f: out std_logic
    );
  end component mux2x1;
  component full_adder
    port (
      x, y, cin: in std_logic;
      cout, sum: out std_logic
    );
  end component full_adder;
  component mux4x1 is
    port(
      data_in: in std_logic_vector(3 downto 0);
      sel: in std_logic_vector(1 downto 0);
      f: out std_logic
    );
  end component mux4x1;
  signal not_a, not_b, mux_a, mux_b, or_out, and_out, adder_out, inner_cout: std_logic;
  signal data_in: std_logic_vector(3 downto 0);
  signal mux4x1_sel: std_logic_vector(1 downto 0);
begin
  mux2x1_a: mux2x1 port map(
    a => a,
    b => not_a,
    sel => opcode(3),
    f => mux_a
  );
  mux2x1_b: mux2x1 port map(
    a => b,
    b => not_b,
    sel => opcode(2),
    f => mux_b
  );
  full_adder_unit: full_adder port map(
    x => mux_a,
    y => mux_b,
    cin => cin,
    cout => inner_cout,
    sum => adder_out
  );
  mux4x1_u: mux4x1
   port map(
     data_in => data_in,
     sel => mux4x1_sel,
     f => result
   );
   mux4x1_sel <= (opcode(1), opcode(0));
   not_a <= not a;
   not_b <= not b;
   or_out  <= mux_a or  mux_b;
   and_out <= mux_a and mux_b;
   data_in <= (set, adder_out, or_out, and_out);
   cout <= inner_cout;
   sign_bit <= adder_out;
end structural ; -- structural