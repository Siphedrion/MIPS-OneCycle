all: datapath

datapath: datapath_bib.o mux2x1n.o sign_ext.o alu.o sll2bit.o register_file.o ripple_carry_adder.o
	ghdl -a --ieee=synopsys datapath.vhd

datapath_bib.o: datapath_bib.vhdl
	ghdl -a --ieee=synopsys datapath_bib.vhdl

mux2x1n.o: ../mux/mux2x1n.vhd
	ghdl -a --ieee=synopsys ../mux/mux2x1n.vhd

sign_ext.o: ../sign_ext/sign_ext.vhd
	ghdl -a --ieee=synopsys ../sign_ext/sign_ext.vhd

alu.o: ../alu_behavioral/alu-comp.vhdl
	ghdl -a --ieee=synopsys ../alu_behavioral/alu-comp.vhdl

sll2bit.o: ../sll2bit/sll2bit.vhd
	ghdl -a --ieee=synopsys ../sll2bit/sll2bit.vhd

register_file.o: ../register_file/register_file.vhd
	ghdl -a --ieee=synopsys ../register_file/register_file.vhd
	ghdl -a --ieee=synopsys ../register_file/register.vhd
	ghdl -a --ieee=synopsys ../register_file/decoder.vhd
	ghdl -a --ieee=synopsys ../register_file/tri-state_buffer.vhd
	ghdl -a --ieee=synopsys ../register_file/zero.vhd

ripple_carry_adder.o: ../ripple_carry_adder/ripple_carry_adder.vhd
	ghdl -a --ieee=synopsys ../ripple_carry_adder/ripple_carry_adder.vhd
	ghdl -a --ieee=synopsys ../ripple_carry_adder/full_adder.vhd

clean:
	rm *.o *.cf
