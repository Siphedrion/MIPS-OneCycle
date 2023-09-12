library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

entity alu is
    port (  A, B   : in std_logic_vector(31 downto 0);
            ALUctl : in std_logic_vector(3 downto 0);
            ALUout : out std_logic_vector(31 downto 0);
            Zero   : out std_logic );
end alu;

architecture comportamiento of alu is
    signal result : std_logic_vector(31 downto 0);
    signal ResSLT : std_logic_vector(31 downto 0) := (others => '0');
begin
    Zero <= '0' when unsigned(result) > 0 else '1';
    with ALUctl select
        result <= A and B when "0000",
                  A or  B when "0001",
                  std_logic_vector(signed(A) + signed(B)) when "0010",
                  std_logic_vector(signed(A) - signed(B)) when "0110",
                  ResSLT  when "0111",
                  not( A or B ) when "1100",
                  (others => '0') when others;
    ResSLT(0) <= '1' when signed(A) < signed(B) else '0';
    ALUout <= result;
end comportamiento;
