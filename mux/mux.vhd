library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity mux is
  generic(
    sel_num: integer
  );
  port (
    data_in: in std_logic_vector(2**sel_num-1 downto 0);
    sel: in std_logic_vector(sel_num-1 downto 0);
    f: out std_logic
  ) ;
end mux;

architecture structural of mux is
  component mux2x1
    port (
      a, b, sel: in std_logic;
      f: out std_logic
    );
  end component mux2x1;
  signal internal_wire: std_logic_vector(2**(sel_num + 1) - 2 downto 0);
begin

  muxgen : for i in 0 to sel_num-1 generate
    mux2x1gen : for j in 0 to natural(2**i-1) generate
      mux: mux2x1 port map(
        a => internal_wire(2**(i+1)+2*j-1),
        b => internal_wire(2**(i+1)+2*j),
        sel => sel(sel_num-1-i),
        f => internal_wire(2**i+j-1)
      );
    end generate mux2x1gen; -- mux2x1gen
  end generate muxgen; -- mux2x1gen

  data_gen : for i in natural(2**(sel_num) - 1) to natural(2**(sel_num + 1) - 2) generate
    internal_wire(i) <= data_in(i-(2**(sel_num)-1));
  end generate data_gen; -- data_gen

  f <= internal_wire(0);

end structural ; -- structural