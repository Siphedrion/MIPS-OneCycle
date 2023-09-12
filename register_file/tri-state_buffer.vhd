library ieee;
use ieee.std_logic_1164.all;

entity tri_state_buffer_array is
  port (
    data_in: in std_logic_vector(31 downto 0);
    data_out: out std_logic_vector(31 downto 0);
    enable: in std_logic
  );
end tri_state_buffer_array;

architecture beh of tri_state_buffer_array is
begin
  gen_buffer_array : for i in 0 to 31 generate
    data_out(i) <= data_in(i) when (enable = '1') else 'Z';
  end generate ; -- gen_buffer_array
end beh ; -- beh