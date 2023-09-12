library ieee;
use ieee.std_logic_1164.all;

entity register_d is
  port (
    d: in std_logic_vector(31 downto 0);   --data input
    q: out std_logic_vector(31 downto 0);  --data output
    load: in std_logic;                    --load = '1' permits write
    clear: in std_logic;                   --clear = '1' reset
    clock: in std_logic                    --clock signal (pos edge)
  );
end register_d;

architecture beh_description of register_d is
begin
  process (clock)
  begin
    if rising_edge(clock) then
      if clear = '1' then
        q <= (others=>'0');
      elsif load = '1' then
        q <= d;
      end if;
    end if;
  end process;
end beh_description ; -- beh_description
