library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;
use std.textio.all;

package ac_bib is
    type tipoROM is array(0 to 255) of std_logic_vector(7 downto 0);
    function carga_programa (programa : string) return tipoROM;
end package ac_bib;

package body ac_bib is
  
  function carga_programa (programa : string) return tipoROM is
    variable mem : tipoROM := (others=>(others=>'-'));
    file          prg : text open read_mode is programa;
    variable    linea : line;
    variable     inst : bit_vector(31 downto 0);
    variable      dir : integer;
    variable  espacio : character;
  begin
    while not endfile(prg) loop
      readline(prg,linea);
      read(linea, dir);    -- la direccion la convierte a entero
      read(linea,espacio); -- lee espacio
      read(linea,inst);    -- lee instruccion o dato
      mem(dir)  :=to_stdlogicvector(inst(31 downto 24));
      mem(dir+1):=to_stdlogicvector(inst(23 downto 16));
      mem(dir+2):=to_stdlogicvector(inst(15 downto  8));
      mem(dir+3):=to_stdlogicvector(inst( 7 downto  0));
    end loop;
    return mem;
  end carga_programa;
 
end package body ac_bib;
