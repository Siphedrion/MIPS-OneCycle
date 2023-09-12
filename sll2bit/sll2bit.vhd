library ieee;
use ieee.std_logic_1164.all;

entity sll2bit is
  port (
    imm32: in std_logic_vector(31 downto 0);
    addr: out std_logic_vector(31 downto 0)
  );
end sll2bit;

architecture dataflow of sll2bit is
begin
  shift : for i in 2 to 31 generate
    addr(i) <=  imm32(i-2);
  end generate shift; -- shift
  addr(0) <= '0';
  addr(1) <= '0';
end dataflow ; -- dataflow