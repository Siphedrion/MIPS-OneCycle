library ieee;
use ieee.std_logic_1164.all;

entity mux2x1 is
  port (
    a, b, sel: in std_logic;
    f: out std_logic
  );
end mux2x1;

architecture dataflow of mux2x1 is
begin
  f <= (a and not sel) or (b and sel);
end dataflow ; -- dataflow