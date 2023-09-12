library ieee;
use ieee.std_logic_1164.all;

entity full_adder is
  port (
    x, y, cin: in std_logic;
    cout, sum: out std_logic
  );
end full_adder;

architecture dataflow of full_adder is
  signal sum_0: std_logic;
begin
  sum_0 <= x xor y;
  sum <= sum_0 xor cin;
  cout <= (x and y) or (cin and sum_0);
end dataflow ; -- dataflow