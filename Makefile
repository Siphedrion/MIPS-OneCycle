all: vcd

vcd: analize
	ghdl -e processor_testbench
	ghdl -r processor_testbench --vcd=result.vcd

analize:
	ghdl -a datapath/datapath_bib.vhdl mux/mux2x1n.vhd sign_ext/sign_ext.vhd sll2bit/sll2bit.vhd ripple_carry_adder/ripple_carry_adder.vhd ripple_carry_adder/full_adder.vhd barrel_shifter/shift_left.vhdl alu_behavioral/alu-comp.vhdl alu_behavioral/ALUControl.vhdl register_file/register_file.vhd register_file/register.vhd register_file/decoder.vhd register_file/zero.vhd register_file/tri-state_buffer.vhd datapath/datapath.vhd ctrl_unit/ctrl_unit.vhdl data_memory_async/data_memory.vhdl instr_mem-behavioral/ac_bib.vhdl instr_mem-behavioral/instr_mem.vhdl pc/pc.vhd processor_testbench_sll.vhd

#datapath:
#	ghdl -a datapath/datapath_bib.vhdl
#	ghdl -a mux/mux2x1n.vhd
#	ghdl -a sign_ext/sign_ext.vhd
#	ghdl -a sll2bit/sll2bit.vhd
#	ghdl -a ripple_carry_adder/ripple_carry_adder.vhd
#	ghdl -a ripple_carry_adder/full_adder.vhd
#	ghdl -a alu_behavioral/alu-comp.vhdl
#	ghdl -a alu_behavioral/ALUControl.vhdl
#	ghdl -a register_file/register_file.vhd
#	ghdl -a register_file/register.vhd
#	ghdl -a register_file/decoder.vhd
#	ghdl -a register_file/zero.vhd
#	ghdl -a register_file/tri-state_buffer.vhd
#	ghdl -a datapath/datapath.vhd
#
#ctrl_unit:
#	ghdl -a ctrl_unit/ctrl_unit.vhdl
#
#data_mem:
#	ghdl -a data_memory_async/data_memory.vhdl
#
#instr_mem:
#	ghdl -a instr_mem-structural/instruction_memory.vhdl
#
#pc:
#	ghdl -a pc/pc.vhd

clean:
	rm *.vcd *.cf


