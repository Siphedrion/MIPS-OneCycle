library ieee;
use ieee.std_logic_1164.all;

--This register has the same interface as a register_d, however
--it only emits zero.
entity register_zero is
  port (
    d: in std_logic_vector(31 downto 0);
    q: out std_logic_vector(31 downto 0);
    load: in std_logic;
    clear: in std_logic;                   --clear = '1' reset
    clock: in std_logic
  );
end register_zero;

architecture dataflow of register_zero is
begin
  q <= (others => '0');
end dataflow ; -- dataflow
