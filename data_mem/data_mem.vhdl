library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_mem is
    port( clk, MemRead, MemWrite : in std_logic;
          address : in  std_logic_vector(31 downto 0);
          datain  : in  std_logic_vector(31 downto 0);
          dataout : out std_logic_vector(31 downto 0) );
end data_mem;

architecture comportamiento of data_mem is
	type tipoRAM is array(0 to 255) of std_logic_vector(7 downto 0);
	signal memDatos : tipoRAM;
begin
	process(clk)
	begin
		if clk'event and clk='1' then
			if MemWrite = '1' then
				memDatos(to_integer(unsigned(address)))   <= datain(31 downto 24);
				memDatos(to_integer(unsigned(address))+1) <= datain(23 downto 16);
				memDatos(to_integer(unsigned(address))+2) <= datain(15 downto 8);
				memDatos(to_integer(unsigned(address))+3) <= datain(7 downto 0);
			elsif MemRead = '1' then
				dataout(31 downto 24) <= memDatos(to_integer(unsigned(address)));
				dataout(23 downto 16) <= memDatos(to_integer(unsigned(address))+1);
				dataout(15 downto 8)  <= memDatos(to_integer(unsigned(address))+2);
				dataout(7 downto 0)   <= memDatos(to_integer(unsigned(address))+3);
			else
				dataout <= (others=>'Z');
			end if;
		end if;
	end process;
end comportamiento;
