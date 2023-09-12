library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity data_memory is
  port(
    clk, MemRead, MemWrite : in std_logic;
    address : in  std_logic_vector(31 downto 0);
    datain  : in  std_logic_vector(31 downto 0);
    dataout : out std_logic_vector(31 downto 0)
  );
end data_memory;

architecture behavioral of data_memory is
	type tipoRAM is array(0 to 255) of std_logic_vector(7 downto 0);
  signal memDatos : tipoRAM;
begin
	process(clk)
  begin
		if rising_edge(clk) then
			if MemWrite = '1' then
				memDatos(to_integer(unsigned(address)))   <= datain(31 downto 24);
				memDatos(to_integer(unsigned(address))+1) <= datain(23 downto 16);
				memDatos(to_integer(unsigned(address))+2) <= datain(15 downto 8);
				memDatos(to_integer(unsigned(address))+3) <= datain(7 downto 0);
			end if;
		end if;
  end process;
  
  --Asynchronous reading
  dataout(31 downto 24) <= memDatos(to_integer(unsigned(address))) 
                           when MemRead = '1' else (others => 'Z');
  dataout(23 downto 16) <= memDatos(to_integer(unsigned(address))+1) 
                           when MemRead = '1' else (others => 'Z');
  dataout(15 downto 8)  <= memDatos(to_integer(unsigned(address))+2) 
                           when MemRead = '1' else (others => 'Z');
  dataout(7 downto 0)   <= memDatos(to_integer(unsigned(address))+3) 
                           when MemRead = '1' else (others => 'Z');

end behavioral;
