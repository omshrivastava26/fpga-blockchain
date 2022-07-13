`timescale 1ns/1ns
`include "create_bram.v"
module create_bram_tb;

parameter RAM_WIDTH = 32;
parameter RAM_ADDR_BITS = 9;

reg							clk;
reg							ram_enable;
reg							write_enable;
reg							key;
wire							value_addr;

create_bram
#(
	.RAM_WIDTH 		(RAM_WIDTH 		),
	.RAM_ADDR_BITS 	(RAM_ADDR_BITS 	),
	.KEY_FILE 		("keyvalue.txt"),
	.HASH_1_FILE	("hash1.txt"),
	.HASH_2_FILE	("hash2.txt"),
	.KEY_INIT_START_ADDR(0				),
	.KEY_INIT_END_ADDR	(14			    ),
	.HASH_1_INIT_START_ADDR (0	),
	.HASH_1_INIT_END_ADDR(4),
	.HASH_2_INIT_START_ADDR(0),
	.HASH_2_INIT_END_ADDR(9)
)
create_bram_inst
(
	.clock			(clk			),
	.ram_enable		(ram_enable		),
	.write_enable	(write_enable	),
	.key			(key			),
	.value_addr		(value_addr		)
	
);
	
initial
begin
	clk = 1;
	 
end

initial
begin
	$dumpfile("wave.vcd");
	$dumpvars(0, create_bram_tb);
	
	ram_enable		<= 1;
	write_enable	<= 0;

	key <= 175;
	#10;

	key <=104;
	#100;
	
	
	
end

endmodule
						