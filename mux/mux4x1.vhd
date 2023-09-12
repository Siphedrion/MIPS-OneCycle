library ieee;
use ieee.std_logic_1164.all;

entity mux4x1 is
  port(
    data_in: in std_logic_vector(3 downto 0);
    sel: in std_logic_vector(1 downto 0);
    f: out std_logic
  );
end mux4x1;

architecture behavioral of mux4x1 is
begin
  process( data_in, sel )
  begin
    if sel = "00" then
      f <= data_in(0);
    elsif sel = "01" then
      f <= data_in(1);
    elsif sel = "10" then
      f <= data_in(2);
    else
      f <= data_in(3);
    end if;
  end process ; 
end behavioral ; -- behavioral