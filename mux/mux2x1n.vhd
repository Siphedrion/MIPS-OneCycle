library ieee;
use ieee.std_logic_1164.all;

entity mux2x1n is
  generic(n: integer);
  port (
    a, b: in std_logic_vector(n-1 downto 0);
    sel: in std_logic;
    f: out std_logic_vector(n-1 downto 0)
  ) ;
end mux2x1n;

architecture behavioral of mux2x1n is
begin
  mux : process( a, b, sel )
  begin
    if sel = '0' then
      f <= a;
    else
      f <= b;
    end if;
  end process mux; -- mux
end behavioral ; -- behavioral