library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use ieee.math_real.all;

entity tb_data_mem is
end tb_data_mem;

architecture estimulos of tb_data_mem is
	component data_mem is
		port( clk, MemRead, MemWrite : in std_logic;
          address : in  std_logic_vector(31 downto 0);
          datain  : in  std_logic_vector(31 downto 0);
          dataout : out std_logic_vector(31 downto 0) );
	end component;
	constant num_vecs  : integer := 10;
	constant wordMIPS : integer := 32;
	constant wordMem  : integer := 8;
	constant periodo : time := 10 ns;
	type tablaAMem is array (0 to num_vecs-1) of std_logic_vector(wordMem-1 downto 0);
	type tablaDMem is array (0 to num_vecs-1) of std_logic_vector(wordMIPS-1 downto 0);
	constant tablaAddrs : tablaAMem :=
	(x"FC", x"04", x"2F", x"10", x"CC",
	 x"7F", x"03", x"46", x"32", x"B6");
	constant tablaDatos : tablaDMem :=
	(x"C319797B", x"14B358FB", x"AA98FF2E", x"17FF68C8", x"C28F1158",
	 x"0AB4A5D6", x"00888CE1", x"68CBA9E4", x"AEB706C9", x"068BF517");
	signal s_clk, s_MemRead, s_MemWrite : std_logic := '0';
	signal s_address, s_datain : std_logic_vector(31 downto 0) := (others=>'0');
	signal s_dataout : std_logic_vector(31 downto 0);
begin
	process
	begin
		for k in 0 to num_vecs-1 loop
			wait for periodo;
			s_address(7 downto 0) <= tablaAddrs(k);
			s_datain <= tablaDatos(k);
		end loop;
		for k in 0 to num_vecs-1 loop
			wait for periodo;
			s_address(7 downto 0) <= tablaAddrs(k);
		end loop;
	end process;

	process
	begin
		for k in 1 to 40 loop
			if k=1 then
				wait for 15 ns;
			else
				wait for 5 ns;
			end if;
			s_clk <= not(s_clk);
		end loop;
	end process;

	process
	begin
		s_MemWrite <= '1';
		wait for 110 ns;
		s_MemWrite <= '0';
		s_MemRead <= '1';
		wait for 110 ns;
		s_MemRead <= '0';
	end process;

	U0 : data_mem port map ( s_clk, s_MemRead, s_MemWrite, s_address, s_datain, s_dataout );
end estimulos;
