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

  signal instruction_addr, instruction: std_logic_vector(31 downto 0);
  signal mem_data_out, mem_data_in, mem_data_addr: std_logic_vector(31 downto 0);
  --RegDst, ALUSrc, MemToReg, RegWrite, MemRead, MemWrite, PCSrc, ALUOp1 y ALUOp0
  signal ctrlword: std_logic_vector(8 downto 0);
  signal alu_opcode: std_logic_vector(3 downto 0);

  component datapath is
    port (
      data_in: in std_logic_vector(31 downto 0);
      instruction: in std_logic_vector(25 downto 0);
      --RegDst, ALUSrc, MemToReg, RegWrite, PCSrc
      ctrlword: in std_logic_vector(4 downto 0); 
      alu_opcode: in std_logic_vector(3 downto 0);
      data_out, mem_addr: out std_logic_vector(31 downto 0);
      instr_addr: out std_logic_vector(31 downto 0);
      clock, reset: in std_logic
    );
  end component datapath;

  component instruction_memory
    port (
      addr: in std_logic_vector(31 downto 0);
      instruction: out std_logic_vector(31 downto 0)
    ) ;
  end component instruction_memory;

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
    MemRead, MemWrite, Branch : out std_logic;
    ALUOp : out std_logic_vector(1 downto 0)
  );
  end component ctrl_unit;

  component ALUControl
    port (
      ALUOp : in std_logic_vector(1 downto 0);
      FuncCode : in std_logic_vector(5 downto 0);
      ALUCtl : out std_logic_vector(3 downto 0)
    );
  end component ALUControl;

begin

  MemWrite <= '1' when initial_complete = false else ctrlword(3);
  MemRead  <= '0' when initial_complete = false else ctrlword(4);
  data <= initial_data when initial_complete = false else mem_data_in;
  address <= initial_addr when initial_complete = false else mem_data_addr;


  datapath_unit: datapath port map(
    data_in => mem_data_out,
    instruction => instruction (25 downto 0),
    ctrlword(4) => ctrlword(8), --RegDest
    ctrlword(3) => ctrlword(7), --ALUSrc
    ctrlword(2) => ctrlword(6), --MemToReg
    ctrlword(1) => ctrlword(5), --RegWrite
    ctrlword(0) => ctrlword(2), --PCSrc
    alu_opcode => alu_opcode,
    data_out => mem_data_in,
    mem_addr => mem_data_addr,
    instr_addr => instruction_addr,
    clock => clock,
    reset => reset
  );

  alu_control_unit: ALUControl port map(
    ALUOp => ctrlword(1 downto 0),
    FuncCode => instruction(5 downto 0),
    ALUCtl => alu_opcode
  );

  control_unit: ctrl_unit port map(
    op => instruction(31 downto 26),
    RegDst => ctrlword(8),
    ALUSrc => ctrlword(7),
    MemToReg => ctrlword(6),
    RegWrite => ctrlword(5),
    MemRead => ctrlword(4),
    MemWrite => ctrlword(3),
    Branch => ctrlword(2),
    ALUOp => ctrlword(1 downto 0)
  );

  instruction_memory_unit: instruction_memory port map(
    addr => instruction_addr,
    instruction => instruction
  );

  data_memory_unit: data_memory port map(
    clk => clock,
    MemRead => MemRead,
    MemWrite => MemWrite,
    address => address,
    datain => data,
    dataout => mem_data_out
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
    wait for 4 ns;
    reset <= '0';
    wait;
  end process reset_p; -- reset_p

  write_mem : process
  begin
    initial_addr <= x"00000000";
    initial_data <= x"00000001"; -- 1
    wait for 2 ns;
    initial_addr <= x"00000004";
    initial_data <= x"00000005"; -- 1
    wait for 2 ns;
    initial_complete <= true;
    wait;
  end process ; -- write_mem

  -- print : process
  -- variable my_line : line;
  -- begin
  --   write(my_line, address);
  --   writeline(output, my_line);
  --   wait for 1 ns;
  --   if finish_flag = true then
  --     wait;
  --   end if;
  -- end process print; -- print

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

--ghdl -a .\alu_ctrl\ALUControl.vhdl .\alu_structural\*.vhd .\ctrl_unit\ctrl_unit.vhdl .\data_memory_async\data_memory.vhd .\datapath\*.vhd .\instr_mem-structural\*.vhd .\mux\*.vhd .\pc\pc.vhd .\register_file\*.vhd .\ripple_carry_adder\*.vhd .\sign_ext\sign_ext.vhd .\sll2bit\sll2bit.vhd .\processor_testbench.vhd
