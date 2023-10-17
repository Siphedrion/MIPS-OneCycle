library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use work.datapath_bib.all;

entity datapath is
  port (
    data_in: in std_logic_vector(31 downto 0);
    instruction: in std_logic_vector(25 downto 0);
    pc : in std_logic_vector(31 downto 0);
    --Jump, RegDst, ALUSrc, MemToReg, RegWrite, Branch
    ctrlword: in std_logic_vector(5 downto 0); 
    alu_opcode: in std_logic_vector(3 downto 0); -- ALUctrl
    data_out, mem_addr: out std_logic_vector(31 downto 0); -- goes to data_mem
    instr_addr: out std_logic_vector(31 downto 0); -- goes to PC
    clock, reset: in std_logic
  );
end datapath;

architecture structural of datapath is

  signal data_mux, imm32, rs, rt, alu_out, op_mux: std_logic_vector(31 downto 0);
  signal jump_mux_a, jump_mux_b, branch_instr_addr: std_logic_vector(31 downto 0);
  signal pc_plus_4, sll2: std_logic_vector(31 downto 0);
  signal rs_addr, rt_addr, rd_addr, wr_addr, shamt: std_logic_vector(4 downto 0);
  signal imm16: std_logic_vector(15 downto 0);
  signal func: std_logic_vector(5 downto 0);
  signal zero_flag, instr_mux_sel: std_logic;

  constant four: std_logic_vector(31 downto 0):= x"00000004";

begin

  data_out <= rt;
  mem_addr <= alu_out;
  instr_mux_sel <= zero_flag and ctrlword(0); --Branch
  rs_addr <= instruction(25 downto 21);
  rt_addr <= instruction(20 downto 16);
  rd_addr <= instruction(15 downto 11);
  shamt <= instruction(10 downto 6);
  imm16 <= instruction(15 downto 0);

  pc_adder_unit: ripple_carry_adder port map(
    a => pc,
    b => four,
    cin => '0',
    sum => pc_plus_4,
    cout => open
  );

  sign_extensor_unit: sign_ext generic map(
    imm_width => 16
  ) port map(
    a => imm16,
    a_extend => imm32
  );

  two_bit_shifter: sll2bit port map(
    imm32 => imm32,
    addr => sll2
  );

  instr_adder_unit: ripple_carry_adder port map(
    a => pc_plus_4,
    b => sll2,
    cin => '0',
    sum => branch_instr_addr,
    cout => open
  );

  instruction_mux_unit: mux2x1n generic map(
    n => 32
  ) port map(
    a => pc_plus_4,
    b => branch_instr_addr,
    sel => instr_mux_sel,
    f => jump_mux_a
  );

  jump_mux_unit: mux2x1n generic map(
    n => 32
  ) port map (
    a => jump_mux_a,
    b => jump_mux_b,
    sel => ctrlword(5), --Jump
    f => instr_addr
  );

  jump_mux_b <= pc_plus_4(31 downto 28) & instruction & "00";

  reg_mux_unit: mux2x1n generic map(
    n => 5
  ) port map(
    a => rt_addr,
    b => rd_addr,
    sel => ctrlword(4), --RegDest
    f => wr_addr
  );

  register_file_unit: register_file port map(
    data_in => data_mux,
    read_addr_1 => rs_addr,
    read_addr_2 => rt_addr,
    write_addr => wr_addr,
    reg_1 => rs,
    reg_2 => rt,
    clear => reset,
    clk => clock,
    write_data => ctrlword(1)  --RegWrite
  );

  operand_mux_unit: mux2x1n generic map(
    n => 32
  ) port map(
    a => rt,
    b => imm32,
    sel => ctrlword(3), --ALUSrc
    f => op_mux
  );
  
  alu_unit: alu port map ( rs, op_mux, alu_opcode, shamt, alu_out, zero_flag );

  data_mux_unit: mux2x1n generic map(
    n => 32
  ) port map(
    a => alu_out,
    b => data_in,
    sel => ctrlword(2), --MemToReg
    f => data_mux
  );

end structural ; -- structural
