all: tb_data_mem.vcd

tb_data_mem.vcd: data_mem.o tb_data_mem.o
	ghdl -e --ieee=synopsys tb_data_mem
	./tb_data_mem --stop-time=220ns --vcd=tb_data_mem.vcd
	gtkwave tb_data_mem.vcd

data_mem.o: data_mem.vhdl
	ghdl -a --ieee=synopsys data_mem.vhdl

tb_data_mem.o: tb_data_mem.vhdl
	ghdl -a --ieee=synopsys tb_data_mem.vhdl

clean:
	rm *.o tb_data_mem *.vcd *.cf
