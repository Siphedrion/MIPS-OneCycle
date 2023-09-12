library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;
use work.ac_bib.all;

entity instr_mem is
    generic ( programa : string );
    port ( cs      : in  std_logic;
           address : in  std_logic_vector(31 downto 0);
           dataout : out std_logic_vector(31 downto 0) 
);
end entity;

architecture beh of instr_mem is
    signal mem: tipoROM:=carga_programa(programa);
begin
    process(address)
    begin
        if cs = '1' then
            dataout(31 downto 24) <= mem(to_integer(unsigned(address)));
            dataout(23 downto 16) <= mem(to_integer(unsigned(address))+1);
            dataout(15 downto  8) <= mem(to_integer(unsigned(address))+2);
            dataout(7  downto  0) <= mem(to_integer(unsigned(address))+3);
        else
            dataout <= (others => 'Z');
        end if;
    end process;
end architecture beh;
