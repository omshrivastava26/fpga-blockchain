module create_bram
	#(
		parameter RAM_WIDTH 		= 32,
		parameter RAM_ADDR_BITS 	= 9,
		parameter KEY_FILE 		= "keyvalue.txt",
      parameter HASH_1_FILE      = "hash1.txt",
      parameter HASH_2_FILE      = "hash2.txt",
		parameter KEY_INIT_START_ADDR 	= 0,
		parameter KEY_INIT_END_ADDR		= 14,
      parameter HASH_1_INIT_START_ADDR 	= 0,
		parameter HASH_1_INIT_END_ADDR		= 4,
      parameter HASH_2_INIT_START_ADDR 	= 0,
		parameter HASH_2_INIT_END_ADDR		= 9
      
	)
	(
	input							clock,
	input							ram_enable,
	input							write_enable,
   input                   key,
   output              reg  value_addr
	);
	
   integer hash1;
   integer hash2;
   (* RAM_STYLE="BLOCK" *)
   reg [RAM_WIDTH-1:0] ram_name_KEY [(2**RAM_ADDR_BITS)-1:0];
   //(* RAM_STYLE="BLOCK" *)
   reg [RAM_WIDTH-1:0] ram_name_HASH_1 [(2**RAM_ADDR_BITS)-1:0];
   //(* RAM_STYLE="BLOCK" *)
   reg [RAM_WIDTH-1:0] ram_name_HASH_2 [(2**RAM_ADDR_BITS)-1:0];


   //  The forllowing code is only necessary if you wish to initialize the RAM 
   //  contents via an external file (use $readmemb for binary data)
   initial begin
      $readmemh(KEY_FILE, ram_name_KEY, KEY_INIT_START_ADDR, KEY_INIT_END_ADDR);
      $readmemh(HASH_1_FILE, ram_name_HASH_1, HASH_1_INIT_START_ADDR, HASH_1_INIT_END_ADDR);
      $readmemh(HASH_1_FILE, ram_name_HASH_2, HASH_2_INIT_START_ADDR, HASH_2_INIT_END_ADDR);
   end
    
   always @(posedge clock) begin
      
      
      hash1=key%5;
      hash2=key%10;

      if (ram_name_HASH_1[hash1]!=0) begin
        value_addr = ram_name_HASH_1[hash1];

      end else begin
        value_addr = ram_name_HASH_2[hash2];
      end
      $display("Value addr is %d ", value_addr );


   end
      
      

endmodule
						