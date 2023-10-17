library ieee;
use ieee.std_logic_1164.all;

entity shift_left is port(
	datain : in std_logic_vector(31 downto 0);
	dataout : out std_logic_vector(31 downto 0);
	shamt : in std_logic_vector(4 downto 0)
);
end shift_left;

architecture estructura of shift_left is
	type multiarray is array (5 downto 0) of std_logic_vector(31 downto 0);
	signal inter : multiarray;
begin
    with shamt(0) select inter(1) <= inter(0) when '0', inter(0)(30 downto 0)&'0' when others;
    with shamt(1) select inter(2) <= inter(1) when '0', inter(1)(29 downto 0)&"00" when others;
    with shamt(2) select inter(3) <= inter(2) when '0', inter(2)(27 downto 0)&"0000" when others;
    with shamt(3) select inter(4) <= inter(3) when '0', inter(3)(23 downto 0)&"00000000" when others;
    with shamt(4) select inter(5) <= inter(4) when '0', inter(4)(15 downto 0)&"0000000000000000" when others;
    inter(0) <= datain;
    dataout <= inter(5);
end estructura;
