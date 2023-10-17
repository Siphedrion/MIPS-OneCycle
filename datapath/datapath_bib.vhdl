library ieee;
use ieee.std_logic_1164.all;
use ieee.numeric_std.all;

package datapath_bib is

  component mux2x1n
    generic(n: integer);
    port (
      a, b: in std_logic_vector(n-1 downto 0);
      sel: in std_logic;
      f: out std_logic_vector(n-1 downto 0)
    ) ;
  end component mux2x1n;

  component sign_ext
    generic (imm_width: integer);
    port (
      a: in std_logic_vector(imm_width-1 downto 0);
      a_extend: out std_logic_vector(2*imm_width-1 downto 0)
    );
  end component sign_ext;

  component alu is
    port (
        A, B   : in std_logic_vector(31 downto 0);
        ALUctl : in std_logic_vector(3 downto 0);
        SHamt  : in std_logic_vector(4 downto 0);
        ALUout : out std_logic_vector(31 downto 0);
        Zero   : out std_logic
    );
    end component alu;

  component sll2bit
    port (
      imm32: in std_logic_vector(31 downto 0);
      addr: out std_logic_vector(31 downto 0)
    );
  end component sll2bit;

  component register_file
    port (
      data_in: in std_logic_vector(31 downto 0);
      read_addr_1: in std_logic_vector(4 downto 0);
      read_addr_2: in std_logic_vector(4 downto 0);
      write_addr: in std_logic_vector(4 downto 0);
      reg_1: out std_logic_vector(31 downto 0);
      reg_2: out std_logic_vector(31 downto 0);
      clear: in std_logic;
      clk: in std_logic;
      write_data: in std_logic
    );
  end component register_file;

  component ripple_carry_adder is
    --generic (n: integer := 32);
    port (
      a, b: in  std_logic_vector(31 downto 0);
      cin:  in  std_logic;
      sum:  out std_logic_vector(31 downto 0);
      cout: out std_logic
    ) ;
  end component ripple_carry_adder;

end package datapath_bib;
