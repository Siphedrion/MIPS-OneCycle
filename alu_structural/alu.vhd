library ieee;
use ieee.std_logic_1164.all;

entity alu is
  generic (n: integer);
  port (
    a, b: in std_logic_vector(n-1 downto 0);
    opcode: in std_logic_vector(3 downto 0);
    result: out std_logic_vector(n-1 downto 0);
    status: out std_logic_vector(3 downto 0) --cvnz
  ) ;
end alu;

architecture structural of alu is
  component one_bit_alu_i
    port (
      a, b, set, cin: in std_logic;
      opcode: in std_logic_vector(3 downto 0);
      result, cout: out std_logic
    );
  end component one_bit_alu_i;
  component one_bit_alu_last
    port (
      a, b, set, cin: in std_logic;
      opcode: in std_logic_vector(3 downto 0);
      result, cout, sign_bit: out std_logic
    );
  end component one_bit_alu_last;
  signal status_inner: std_logic_vector(3 downto 0);
  signal carry: std_logic_vector(n-1 downto 0);
  signal result_inner: std_logic_vector(n-1 downto 0);
begin
  alu_0: one_bit_alu_i port map (
    a => a(0),
    b => b(0),
    set => status_inner(1),
    cin => opcode(2),
    opcode => opcode,
    result => result_inner(0),
    cout => carry(0)
  );
  alu_i : for i in 1 to n-2 generate
    alu_i: one_bit_alu_i port map (
      a => a(i),
      b => b(i),
      set => '0',
      cin => carry(i-1),
      opcode => opcode,
      result => result_inner(i),
      cout => carry(i)
    );
  end generate alu_i; -- alu_i

  alu_last: one_bit_alu_last port map(
    a => a(n-1),
    b => b(n-1),
    set => '0',
    cin => carry(n-2),
    opcode => opcode,
    result => result_inner(n-1),
    cout => carry(n-1),
    sign_bit => status_inner(1)
  );

  status_inner(0) <= '1' when result_inner = (result_inner'range=>'0') else '0'; --zero flag
  status_inner(2) <= carry(n-2) xor carry(n-1); --overflow flag
  status_inner(3) <= carry(n-1); --carry flag
  status <= status_inner;
  result <= result_inner;
end structural ; -- structural