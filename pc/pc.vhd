library ieee;
use ieee.std_logic_1164.all;

entity program_counter is
  port (
    d: in std_logic_vector(31 downto 0);   --data input
    q: out std_logic_vector(31 downto 0);  --data output
    clr: in std_logic;                     --reset input
    clock: in std_logic                    --clock signal (pos edge)
  );
end program_counter;

architecture beh_description of program_counter is
begin
  process (clock)
  begin
    if rising_edge(clock) then
      if clr = '1' then --synchronous reset
        q <= (others => '0');
      else
        q <= d;
      end if;
    end if;
  end process;
end beh_description ; -- beh_description
