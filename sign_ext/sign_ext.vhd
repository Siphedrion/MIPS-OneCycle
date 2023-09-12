library ieee;
use ieee.std_logic_1164.all;

entity sign_ext is
  generic (imm_width: integer);
  port (
    a: in std_logic_vector(imm_width-1 downto 0);
    a_extend: out std_logic_vector(2*imm_width-1 downto 0)
  );
end sign_ext;

architecture dataflow of sign_ext is
begin
  sign_gen : for i in 0 to 2*imm_width-1 generate
    copy_a: if i < imm_width generate
      a_extend(i) <= a(i);
    end generate copy_a;
    copy_sign: if i >= imm_width generate
      a_extend(i) <= a(imm_width-1);
    end generate copy_sign;
    --a_extend(i) <= a(i) when i < imm_width else a(imm_width-1);
  end generate sign_gen; -- sign_gen
end dataflow ; -- dataflow