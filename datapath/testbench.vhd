library ieee;
use ieee.std_logic_1164.all;

entity testbench is
end testbench;

architecture mixed of testbench is

  signal finish_flag: boolean := false;

  signal data_in, data_out, mem_addr, instr_addr, instruction_addr : std_logic_vector(31 downto 0) ;
  signal instruction: std_logic_vector(25 downto 0);
  signal ctrlword: std_logic_vector(5 downto 0);
  signal alu_opcode: std_logic_vector(3 downto 0);
  signal clock: std_logic := '0';
  signal reset: std_logic := '1';

  component datapath
    port (
      data_in: in std_logic_vector(31 downto 0);
      instruction: in std_logic_vector(25 downto 0);
      pc : in std_logic_vector(31 downto 0);
      --RegDst, ALUSrc, MemToReg, RegWrite, PCSrc
      ctrlword: in std_logic_vector(5 downto 0); 
      alu_opcode: in std_logic_vector(3 downto 0);
      data_out, mem_addr: out std_logic_vector(31 downto 0);
      instr_addr: out std_logic_vector(31 downto 0);
      clock, reset: in std_logic
    );
  end component datapath;

begin

  datapath_unit: datapath port map(
    data_in => data_in,
    instruction => instruction,
    pc => instruction_addr,
    ctrlword => ctrlword, --RegDest
    alu_opcode => alu_opcode,
    data_out => data_out,
    mem_addr => mem_addr,
    instr_addr => instr_addr,
    clock => clock,
    reset => reset
  );

  clock_gen : process
  begin
    wait for 1 ns;
    clock <= not clock;
    if finish_flag then
      wait;
    end if;
  end process clock_gen; -- clock_gen

  reset_p : process
  begin
    wait for 2 ns;
    reset <= '0';
    wait;
  end process reset_p; -- reset_p

  stimuli : process
  begin
    wait for 1 ns;
    data_in <= x"00000001";
    instruction <= "00000100010000000000000000";
    instruction_addr <= x"00000000";
    ctrlword <= "001110";
    alu_opcode <= "0010";
    wait for 2 ns;
    data_in <= x"00000002";
    instruction <= "00000100100000000000000100";
    instruction_addr <= x"00000004";
    ctrlword <= "001110";
    alu_opcode <= "0010";
    wait for 2 ns;
    data_in <= x"00000001";
    instruction <= "00000010000000000000000000";
    instruction_addr <= x"00000008";
    ctrlword <= "001110";
    alu_opcode <= "0010";
    wait for 2 ns;
    data_in <= x"00000000";
    instruction <= "00000000000000000000001001";
    instruction_addr <= x"0000000C";
    ctrlword <= "000001";
    alu_opcode <= "0110";
    wait for 2 ns;
    data_in <= x"00000000";
    instruction <= "10010010000000100000101010";
    instruction_addr <= x"00000010";
    ctrlword <= "010010";
    alu_opcode <= "0111";
    wait for 2 ns;
    data_in <= x"00000000";
    instruction <= "00001000001111111111110101";
    instruction_addr <= x"00000014";
    ctrlword <= "000001";
    alu_opcode <= "0110";
    wait for 2 ns;
    data_in <= x"00000001";
    instruction <= "00000010010000000000000000";
    instruction_addr <= x"00000018";
    ctrlword <= "001110";
    alu_opcode <= "0010";
    wait for 2 ns;
    finish_flag <= true;
    wait;
  end process stimuli; -- stimuli

end mixed ; -- mixed
