library ieee;
use ieee.std_logic_1164.all;

entity decoder is
  port (
    a: in std_logic_vector(4 downto 0);
    d: out std_logic_vector(31 downto 0);
    enable: in std_logic
  );
end decoder;

architecture beh of decoder is
begin
  process (a, enable)
  begin
    if enable = '1' then
      case (a) is
        when "00000" => d <= (0  => '1', others => '0');
        when "00001" => d <= (1  => '1', others => '0');
        when "00010" => d <= (2  => '1', others => '0');
        when "00011" => d <= (3  => '1', others => '0');
        when "00100" => d <= (4  => '1', others => '0');
        when "00101" => d <= (5  => '1', others => '0');
        when "00110" => d <= (6  => '1', others => '0');
        when "00111" => d <= (7  => '1', others => '0');
        when "01000" => d <= (8  => '1', others => '0');
        when "01001" => d <= (9  => '1', others => '0');
        when "01010" => d <= (10 => '1', others => '0');
        when "01011" => d <= (11 => '1', others => '0');
        when "01100" => d <= (12 => '1', others => '0');
        when "01101" => d <= (13 => '1', others => '0');
        when "01110" => d <= (14 => '1', others => '0');
        when "01111" => d <= (15 => '1', others => '0');
        when "10000" => d <= (16 => '1', others => '0');
        when "10001" => d <= (17 => '1', others => '0');
        when "10010" => d <= (18 => '1', others => '0');
        when "10011" => d <= (19 => '1', others => '0');
        when "10100" => d <= (20 => '1', others => '0');
        when "10101" => d <= (21 => '1', others => '0');
        when "10110" => d <= (22 => '1', others => '0');
        when "10111" => d <= (23 => '1', others => '0');
        when "11000" => d <= (24 => '1', others => '0');
        when "11001" => d <= (25 => '1', others => '0');
        when "11010" => d <= (26 => '1', others => '0');
        when "11011" => d <= (27 => '1', others => '0');
        when "11100" => d <= (28 => '1', others => '0');
        when "11101" => d <= (29 => '1', others => '0');
        when "11110" => d <= (30 => '1', others => '0');
        when others =>  d <= (31 => '1', others => '0');
      end case;
    else
      d <= (others => '0');
    end if;
  end process;
end beh ; -- beh
