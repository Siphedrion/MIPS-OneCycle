all:tb_instr_mem.vcd

tb_instr_mem.vcd:tb_instr_mem
	#./tb_instr_mem --stop-time=800ns --vcd=tb_instr_mem.vcd
	ghdl -r tb_instr_mem --stop-time=170ns --vcd=tb_instr_mem.vcd
	gtkwave tb_instr_mem.vcd

tb_instr_mem:ac_bib.o instr_mem.o tb_instr_mem.o
	ghdl -e $@ 

instr_mem.o:instr_mem.vhdl
	ghdl -a $^

tb_instr_mem.o:tb_instr_mem.vhdl
	ghdl -a $^

ac_bib.o:ac_bib.vhdl
	ghdl -a $^

clean:
	rm *.o *.cf *.vcd tb_instr_mem
