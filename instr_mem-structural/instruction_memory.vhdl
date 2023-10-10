library ieee;
use ieee.std_logic_1164.all;

entity instruction_memory is
  port (
    addr: in std_logic_vector(31 downto 0);
    instruction: out std_logic_vector(31 downto 0)
  ) ;
end instruction_memory;

architecture structural of instruction_memory is

  component decoder
    port (
      a: in std_logic_vector(4 downto 0);
      d: out std_logic_vector(31 downto 0);
      enable: in std_logic
    );
  end component decoder;
  
  signal dec_line: std_logic_vector(31 downto 0);

begin

  decoder5x32_u: decoder port map(
    a => addr(6 downto 2),
    d => dec_line,
    enable => '1'
  );

--TODO: Make the generation of decoder lines automatically

  instruction(31) <= dec_line( 1) or dec_line(10) or dec_line(11) or
                     dec_line(14) or dec_line(15);
  instruction(30) <= '0';
  instruction(29) <= dec_line( 0) or dec_line( 5) or dec_line( 6) or
                     dec_line(14) or dec_line(15) or dec_line(16) or
                     dec_line(18);
  instruction(28) <= dec_line( 4) or dec_line( 7) or dec_line(13);
  instruction(27) <= dec_line( 1) or dec_line( 6) or dec_line(10) or
                     dec_line(11) or dec_line(14) or dec_line(15) or
                     dec_line(17) or dec_line(19);
  instruction(26) <= dec_line( 1) or dec_line( 7) or dec_line(10) or
                     dec_line(11) or dec_line(14) or dec_line(15);
  instruction(25) <= dec_line( 3) or dec_line( 5) or dec_line( 6) or
                     dec_line( 9) or dec_line(16) or dec_line(18);
  instruction(24) <= dec_line( 4) or dec_line( 7) or dec_line(10) or
                     dec_line(11) or dec_line(12) or dec_line(13) or
                     dec_line(14) or dec_line(15);
  instruction(23) <= dec_line(12);
  instruction(22) <= dec_line( 9) or dec_line(10) or dec_line(11) or
                     dec_line(14) or dec_line(15);
  instruction(21) <= dec_line( 0) or dec_line( 6) or dec_line(16);
  instruction(20) <= dec_line( 0) or dec_line( 1) or dec_line( 3) or 
                     dec_line( 5) or dec_line( 8) or dec_line(16) or
                     dec_line(17) or dec_line(18) or dec_line(19);
  instruction(19) <= dec_line( 6) or dec_line( 9) or dec_line(10) or
                     dec_line(11) or dec_line(12) or dec_line(14) or
                     dec_line(15);
  instruction(18) <= dec_line(11) or dec_line(14);
  instruction(17) <= dec_line( 0) or dec_line( 1) or dec_line( 3) or
                     dec_line(10) or dec_line(12) or dec_line(15);
  instruction(16) <= dec_line( 1) or dec_line( 3) or dec_line( 5) or
                     dec_line( 8) or dec_line( 9) or dec_line(10) or
                     dec_line(12) or dec_line(15) or dec_line(16);
  instruction(15) <= dec_line( 2) or dec_line( 5) or dec_line(16);
  instruction(14) <= dec_line( 3) or dec_line( 5) or dec_line( 8) or
                     dec_line( 9) or dec_line(12) or dec_line(16);
  instruction(13) <= dec_line( 5) or dec_line(16);
  instruction(12) <= dec_line( 5) or dec_line( 9) or dec_line(16);
  instruction(11) <= dec_line( 5) or dec_line( 8) or dec_line(16);
  instruction(10) <= dec_line( 5) or dec_line(16);
  instruction( 9) <= dec_line( 5) or dec_line(16);
  instruction( 8) <= dec_line( 5) or dec_line(16);
  instruction( 7) <= dec_line( 5) or dec_line( 8) or dec_line(16);
  instruction( 6) <= dec_line( 5) or dec_line(16);
  instruction( 5) <= dec_line( 2) or dec_line( 3) or dec_line( 5) or
                     dec_line( 9) or dec_line(12) or dec_line(16) or
                     dec_line(20);
  instruction( 4) <= dec_line( 5) or dec_line(16);
  instruction( 3) <= dec_line( 3) or dec_line( 4) or dec_line( 5) or
                     dec_line( 7) or dec_line(12) or dec_line(16);
  instruction( 2) <= dec_line( 0) or dec_line( 4) or dec_line( 5) or
                     dec_line(11) or dec_line(13) or dec_line(15) or
                     dec_line(16) or dec_line(17);
  instruction( 1) <= dec_line( 3) or dec_line( 4) or dec_line( 5) or
                     dec_line( 7) or dec_line(12) or dec_line(16) or
                     dec_line(17) or dec_line(19);
  instruction( 0) <= dec_line( 4) or dec_line( 5) or dec_line(16) or
                     dec_line(18) or dec_line(19);

end structural ; -- structural