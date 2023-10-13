library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity processor_testbench is
end processor_testbench;

architecture structural of processor_testbench is

  signal MemRead, MemWrite: std_logic;
  signal initial_data, data, initial_addr, address: std_logic_vector(31 downto 0);
  signal clock: std_logic := '0';
  signal reset: std_logic := '1';
  signal finish_flag: boolean := false;
  signal initial_complete: boolean := false;

  signal instr_addr, instruction_addr, instruction: std_logic_vector(31 downto 0);
  signal mem_data_out, mem_data_in, mem_data_addr: std_logic_vector(31 downto 0);
  --RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, PCSrc, ALUOp1 y ALUOp0
  signal ctrlword: std_logic_vector(9 downto 0);
  signal alu_opcode: std_logic_vector(3 downto 0);

  component datapath is
    port (
      data_in: in std_logic_vector(31 downto 0);
      instruction: in std_logic_vector(25 downto 0);
      pc : in std_logic_vector(31 downto 0);
      --Jump RegDst, ALUSrc, MemToReg, RegWrite, PCSrc
      ctrlword: in std_logic_vector(5 downto 0); 
      alu_opcode: in std_logic_vector(3 downto 0);
      data_out, mem_addr: out std_logic_vector(31 downto 0);
      instr_addr: out std_logic_vector(31 downto 0);
      clock, reset, bit26: in std_logic
    );
  end component datapath;

--  component instruction_memory
--    port (
--      addr: in std_logic_vector(31 downto 0);
--      instruction: out std_logic_vector(31 downto 0)
--    ) ;
--  end component instruction_memory;
component instr_mem is
  generic ( programa : string );
  port ( cs      : in  std_logic;
         address : in  std_logic_vector(31 downto 0);
         dataout : out std_logic_vector(31 downto 0) 
);
end component instr_mem;

  component data_memory
    port(
      clk, MemRead, MemWrite : in std_logic;
      address : in  std_logic_vector(31 downto 0);
      datain  : in  std_logic_vector(31 downto 0);
      dataout : out std_logic_vector(31 downto 0)
  );
  end component data_memory;

  component ctrl_unit
  port ( 
    op : in std_logic_vector(5 downto 0);
    RegDst, ALUSrc, MemToReg, RegWrite : out std_logic; 
    MemRead, MemWrite, Branch, Jump : out std_logic;
    ALUOp : out std_logic_vector(1 downto 0)
  );
  end component ctrl_unit;

  component ALUControl
    port (
      ALUOp : in std_logic_vector(1 downto 0);
      FuncCode : in std_logic_vector(5 downto 0);
      op : in std_logic_vector(5 downto 0);
      ALUCtl : out std_logic_vector(3 downto 0)
    );
  end component ALUControl;

  component program_counter
    port (
      d: in std_logic_vector(31 downto 0);
      q: out std_logic_vector(31 downto 0);
      clr: in std_logic;
      clock: in std_logic
    );
  end component program_counter;

begin

  MemWrite <= '1' when initial_complete = false else ctrlword(3);
  MemRead  <= '0' when initial_complete = false else ctrlword(4);
  data <= initial_data when initial_complete = false else mem_data_in;
  address <= initial_addr when initial_complete = false else mem_data_addr;


  datapath_unit: datapath port map(
    data_in => mem_data_out,
    instruction => instruction (25 downto 0),
    pc => instruction_addr,
    ctrlword(5) => ctrlword(9), --Jump
    ctrlword(4) => ctrlword(8), --RegDest
    ctrlword(3) => ctrlword(7), --ALUSrc
    ctrlword(2) => ctrlword(6), --MemToReg
    ctrlword(1) => ctrlword(5), --RegWrite
    ctrlword(0) => ctrlword(2), --Branch
    alu_opcode => alu_opcode,
    data_out => mem_data_in,
    mem_addr => mem_data_addr,
    instr_addr => instr_addr,
    clock => clock,
    reset => reset,
    bit26 => instruction(26)
  );

  alu_control_unit: ALUControl port map(
    ALUOp => ctrlword(1 downto 0),
    FuncCode => instruction(5 downto 0),
    op => instruction(31 downto 26),
    ALUCtl => alu_opcode
  );

  control_unit: ctrl_unit port map(
    op => instruction(31 downto 26),
    Jump => ctrlword(9),
    RegDst => ctrlword(8),
    ALUSrc => ctrlword(7),
    MemToReg => ctrlword(6),
    RegWrite => ctrlword(5),
    MemRead => ctrlword(4),
    MemWrite => ctrlword(3),
    Branch => ctrlword(2),
    ALUOp => ctrlword(1 downto 0)
  );

--  instruction_memory_unit: instruction_memory port map(
--    addr => instruction_addr,
--    instruction => instruction
--  );
instruction_memory_unit: instr_mem generic map ("loop-sll.bin") port map(
  address => instruction_addr,
  dataout => instruction,
  cs => '1'
);

  data_memory_unit: data_memory port map(
    clk => clock,
    MemRead => MemRead,
    MemWrite => MemWrite,
    address => address,
    datain => data,
    dataout => mem_data_out
  );

  pc_unit: program_counter port map(
    d => instr_addr,
    q => instruction_addr,
    clr => reset,
    clock => clock
  );

  clk_gen : process
  begin
    wait for 1 ns;
    clock <= not clock;
    if finish_flag = true then
      wait;
    end if;
  end process clk_gen; -- clk_gen

  reset_p : process
  begin
    wait for 8 ns;
    reset <= '0';
    wait;
  end process reset_p; -- reset_p

  write_mem : process
  begin
    initial_addr <= x"00000000";
    initial_data <= x"0000000a"; -- n
    wait for 2 ns;
    initial_addr <= x"00000004";
    initial_data <= x"000051B4"; -- v[0]
    wait for 2 ns;
    initial_addr <= x"00000008";
    initial_data <= x"FFFFFFFF"; -- v[0]
    wait for 2 ns;    initial_complete <= true;
    wait;
  end process ; -- write_mem

  stimuli : process
  begin
    while initial_complete = false loop
      wait for 1 ns;
    end loop ;
    processing : while instruction /= x"00000000" loop
      wait for 1 ns;
    end loop ; -- processing
    finish_flag <= true;
    wait;
  end process stimuli; -- stimuli

end structural ; -- structural