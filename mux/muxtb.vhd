library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture behavioral of testbench is
  component mux
    generic(
      sel_num: integer
    );
    port (
      data_in: in std_logic_vector(2**sel_num-1 downto 0);
      sel: in std_logic_vector(sel_num-1 downto 0);
      f: out std_logic
    );
  end component mux;
  signal sel_num: integer := 4;
  signal switch_data: std_logic_vector(2**sel_num-1 downto 0);
  signal switch_sel: std_logic_vector(sel_num-1 downto 0);
  signal indicator: std_logic;
begin
  mux16x1: mux
  generic map(sel_num => sel_num)
  port map(
    data_in => switch_data,
    sel => switch_sel,
    f => indicator
  );
  stimuli : process
  begin
    switch_data <= "1111101011111010"; 
    switch_sel <= "0000"; wait for 1 ns;
    switch_sel <= "0001"; wait for 1 ns;
    switch_sel <= "0010"; wait for 1 ns;
    switch_sel <= "0011"; wait for 1 ns;
    switch_sel <= "0100"; wait for 1 ns;
    switch_sel <= "0101"; wait for 1 ns;
    switch_sel <= "0110"; wait for 1 ns;
    switch_sel <= "0111"; wait for 1 ns;
    switch_sel <= "1000"; wait for 1 ns;
    switch_sel <= "1001"; wait for 1 ns;
    switch_sel <= "1010"; wait for 1 ns;
    switch_sel <= "1011"; wait for 1 ns;
    switch_sel <= "1100"; wait for 1 ns;
    switch_sel <= "1101"; wait for 1 ns;
    switch_sel <= "1110"; wait for 1 ns;
    switch_sel <= "1111"; wait for 1 ns;
    wait;
  end process stimuli; -- stimuli
end behavioral ; -- behavioral