library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all; 

entity tb_instr_mem is
end entity;

architecture beh of tb_instr_mem is
component instr_mem is
    generic ( programa : string := "programa.bin");
    port ( cs      : in  std_logic;
           address : in  std_logic_vector(31 downto 0);
           dataout : out std_logic_vector(31 downto 0)
);
end component;
signal s_cs      : std_logic:='0';
signal s_address : std_logic_vector(31 downto 0) := (others=>'Z');
signal s_dataout : std_logic_vector(31 downto 0); 
begin
	U0 : instr_mem port map ( s_cs, s_address, s_dataout );
	process --proceso de escritura
		variable dir : std_logic_vector(31 downto 0) := (others=>'0');
		variable uno : std_logic_vector(31 downto 0) := std_logic_vector(to_unsigned(1,32));
	begin
      wait for 10 ns;
      s_cs <= '1';
      for i in 0 to 56 loop
		if (i mod 4) = 0 then
			s_address <= dir;
			wait for 10 ns;
		end if;
		dir := std_logic_vector(unsigned(dir) + unsigned(uno));
      end loop;
      s_cs <= '0';
      wait for 10 ns;
  end process;
end architecture beh;
