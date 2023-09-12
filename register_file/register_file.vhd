library ieee;
use ieee.std_logic_1164.all;

entity register_file is
  port (
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
end register_file;

architecture structural_description of register_file is

  component register_zero
    port (
      d: in std_logic_vector(31 downto 0);
      q: out std_logic_vector(31 downto 0);
      load: in std_logic;
      clear: in std_logic;                   --clear = '1' reset
      clock: in std_logic
    );
  end component register_zero;

  component register_d port (
    d: in std_logic_vector(31 downto 0);
    q: out std_logic_vector(31 downto 0);
    load: in std_logic;
    clear: in std_logic;                   --clear = '1' reset
    clock: in std_logic
  );
  end component register_d;

  component decoder port (
    a: in std_logic_vector(4 downto 0);
    d: out std_logic_vector(31 downto 0);
    enable: in std_logic
  );
  end component decoder;

  component tri_state_buffer_array port (
    data_in: in std_logic_vector(31 downto 0);
    data_out: out std_logic_vector(31 downto 0);
    enable: in std_logic
  );
  end component tri_state_buffer_array;

  signal write_reg, enable_reg_1, enable_reg_2: std_logic_vector(31 downto 0);
  signal q_out: std_logic_vector(1023 downto 0); --register outputs
begin
  dec_d: decoder port map(
    a => write_addr,
    d => write_reg,
    enable => write_data
  );

  dec_1: decoder port map(
    a => read_addr_1,
    d => enable_reg_1,
    enable => '1'
  );

  dec_2: decoder port map(
    a => read_addr_2,
    d => enable_reg_2,
    enable => '1'
  );

  reg_zero: register_zero port map(
    d => data_in,
    q => q_out(1023 downto 992),
    load => write_reg(0),
    clear => clear,
    clock => clk
  );

  gen_registers : for i in 1 to 31 generate
    reg_u: register_d port map (
      d => data_in,
      q => q_out(991-32*(i-1) downto 991-32*i+1),
      load => write_reg(i),
      clear => clear,
      clock => clk
    );
  end generate gen_registers; -- gen_registers

  gen_buf_bus_1 : for i in 0 to 31 generate
    buf_1 : tri_state_buffer_array port map (
      data_in => q_out(1023-32*(i) downto 1023-32*(i+1)+1),
      data_out => reg_1,
      enable => enable_reg_1(i)
    );
  end generate gen_buf_bus_1; -- gen_buf_bus_1

  gen_buf_bus_2 : for i in 0 to 31 generate
    buf_1 : tri_state_buffer_array port map (
      data_in => q_out(1023-32*(i) downto 1023-32*(i+1)+1),
      data_out => reg_2,
      enable => enable_reg_2(i)
    );
  end generate gen_buf_bus_2; -- gen_buf_bus_2
end structural_description ; -- structural_description