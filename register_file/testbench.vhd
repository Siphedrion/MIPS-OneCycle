library ieee;
use ieee.std_logic_1164.all;
use ieee.math_real.all;
use ieee.numeric_std.all;

entity testbench is
end testbench;

architecture beh of testbench is
  component register_file port (
    data_in: in std_logic_vector(31 downto 0);
    read_addr_1: in std_logic_vector(4 downto 0);
    read_addr_2: in std_logic_vector(4 downto 0);
    write_addr: in std_logic_vector(4 downto 0);
    reg_1: out std_logic_vector(31 downto 0);
    reg_2: out std_logic_vector(31 downto 0);
    clear: in std_logic;
    clk: in std_logic;
    write_data: in std_logic
  );
  end component;
  signal bus_d, bus_1, bus_2: std_logic_vector(31 downto 0);
  signal w_addr, r1_addr, r2_addr: std_logic_vector(4 downto 0);
  signal clk: std_logic := '0';
  signal clr: std_logic := '1';
  signal wr: std_logic := '1';
  signal flag_finish: boolean := false;
begin
  reg_file_u: register_file port map (
    data_in => bus_d,
    read_addr_1 => r1_addr,
    read_addr_2 => r2_addr,
    write_addr => w_addr,
    reg_1 => bus_1,
    reg_2 => bus_2,
    clear => clr,
    clk => clk,
    write_data => wr
  );

  stimuli : process 
  begin
    clr <= '1';
    bus_d <= x"00000000";
    r1_addr <= "00000"; r2_addr <= "00000";
    wait for 2 ns;
    clr <= '0';
    -- writes all registers
    write : for i in 0 to 31 loop
      bus_d <= std_logic_vector(to_unsigned(2*i, bus_d'length));
      w_addr <= std_logic_vector(to_unsigned(i, w_addr'length));
      wait for 2 ns;
    end loop ; -- write
    read : for i in 0 to 31 loop
      r1_addr <= std_logic_vector(to_unsigned(i, r1_addr'length));
      wait for 2 ns;
    end loop ; -- read
    flag_finish <= true;
    wait; --finishes simulation
  end process ; -- stimuli
  
  clock_gen: process begin
    wait for 1 ns; clk  <= not clk;
    if flag_finish = true then
      wait;
    end if;
  end process clock_gen;
end beh ; -- beh