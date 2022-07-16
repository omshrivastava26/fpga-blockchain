`include "receiver.v"
`include "refer.v"
`include "issue.v"
`include "transfer.v"
`include "create.v"
`include "create_bram.v"

module extractor (
    input dcom,
    input clk,
    input tick_in
);

    parameter RAM_WIDTH = 32;
    parameter RAM_ADDR_BITS = 9;

    wire [7:0] bus;
    wire newbyt;
    integer i;
    integer init;
    integer flag;
    reg [8:0] ref_a;
    reg [8:0] isu_a;
    reg [8:0] crt_a;
    reg [8:0] tfr_a;
    wire [7:0] bus_create;
    wire [7:0] bus_issue;
    wire [7:0] bus_refer;
    wire [7:0] bus_transfer;
    wire newbyt_crt;
    wire newbyt_ref;
    wire newbyt_isu;
    wire newbyt_tfr;

    wire [1:0] signal;
    wire [31:0] key;
    wire [31:0] value;
    wire [31:0] updated_value;
    wire [31:0] transact_value;
    wire transact_kind;

    assign bus_create[0] = bus[0] & crt_a[0];
    assign bus_create[1] = bus[1] & crt_a[1];
    assign bus_create[2] = bus[2] & crt_a[2];
    assign bus_create[3] = bus[3] & crt_a[3];
    assign bus_create[4] = bus[4] & crt_a[4];
    assign bus_create[5] = bus[5] & crt_a[5];
    assign bus_create[6] = bus[6] & crt_a[6];
    assign bus_create[7] = bus[7] & crt_a[7];
    assign newbyt_crt = newbyt & crt_a[8];
    assign bus_issue[0] = bus[0] & isu_a[0];
    assign bus_issue[1] = bus[1] & isu_a[1];
    assign bus_issue[2] = bus[2] & isu_a[2];
    assign bus_issue[3] = bus[3] & isu_a[3];
    assign bus_issue[4] = bus[4] & isu_a[4];
    assign bus_issue[5] = bus[5] & isu_a[5];
    assign bus_issue[6] = bus[6] & isu_a[6];
    assign bus_issue[7] = bus[7] & isu_a[7];
    assign newbyt_isu = newbyt & isu_a[8];
    assign bus_refer[0] = bus[0] & ref_a[0];
    assign bus_refer[1] = bus[1] & ref_a[1];
    assign bus_refer[2] = bus[2] & ref_a[2];
    assign bus_refer[3] = bus[3] & ref_a[3];
    assign bus_refer[4] = bus[4] & ref_a[4];
    assign bus_refer[5] = bus[5] & ref_a[5];
    assign bus_refer[6] = bus[6] & ref_a[6];
    assign bus_refer[7] = bus[7] & ref_a[7];
    assign newbyt_ref = newbyt & ref_a[8];
    assign bus_transfer[0] = bus[0] & tfr_a[0];
    assign bus_transfer[1] = bus[1] & tfr_a[1];
    assign bus_transfer[2] = bus[2] & tfr_a[2];
    assign bus_transfer[3] = bus[3] & tfr_a[3];
    assign bus_transfer[4] = bus[4] & tfr_a[4];
    assign bus_transfer[5] = bus[5] & tfr_a[5];
    assign bus_transfer[6] = bus[6] & tfr_a[6];
    assign bus_transfer[7] = bus[7] & tfr_a[7];
    assign newbyt_tfr = newbyt & tfr_a[8];

    reciever rec(dcom, clk, tick_in, bus, newbyt);

    refer ref(bus_refer, newbyt, signal, key);
    create crt(bus_create);
    issue isu(bus_issue);
    transfer tfr(bus_transfer);

    create_bram
    #(
    	.RAM_WIDTH 		(RAM_WIDTH 		),
    	.RAM_ADDR_BITS 	(RAM_ADDR_BITS 	),
    	//.KEY_FILE 		("keyvalue.txt"),
    	.HASH_1_FILE	("hashtable1_key.txt"),
    	.HASH_2_FILE	("hashtable2_key.txt"),
    	.HASH_1_VALADD_FILE	("hashtable1_valadd.txt"),
    	.HASH_2_VALADD_FILE	("hashtable2_valadd.txt"),
    	.VALUE_FILE		("value_valueadd.txt"),
    	//.KEY_INIT_START_ADDR(0				),
    	//.KEY_INIT_END_ADDR	(14			    ),
    	.HASH_1_INIT_START_ADDR (0	),
    	.HASH_1_INIT_END_ADDR(11),
    	.HASH_2_INIT_START_ADDR(0),
    	.HASH_2_INIT_END_ADDR(22),
    	.HASH_1_VALADD_INIT_START_ADDR (0	),
    	.HASH_1_VALADD_INIT_END_ADDR(11),
    	.HASH_2_VALADD_INIT_START_ADDR(0),
    	.HASH_2_VALADD_INIT_END_ADDR(22),
    	.VALUE_INIT_START_ADDR(0),
    	.VALUE_INIT_END_ADDR(18)
    )
    create_bram_inst
    (
    	.clock			(clk			),
    	.ram_enable		(ram_enable		),
    	.write_enable	(write_enable	),
    	.key			(key			),
    	.signal			(signal			),
    	.transact_value	(transact_value	),
    	.transact_kind	(transact_kind	),
    	.value_addr		(value_addr		),
    	.updated_value	(updated_value	),
    	.value          (value          )
    );
    
    initial begin
        init <= 0;
        i <= 0;
        ref_a <= 0;
        isu_a <= 0;
        crt_a <= 0;
        tfr_a <= 0;
        flag <=0;
    end

    always@(bus) begin
        if(bus == 0 && flag == 0) begin
            //create
            crt_a <= 511;
            flag <= 1;
        end
        if(bus == 1 && flag == 0) begin
            //issue
            isu_a <= 511;
            flag <= 1;
        end
        if(bus == 2 && flag == 0) begin
            //transfer
            tfr_a <= 511;
            flag <= 1;
        end
        if(bus == 3 && flag == 0) begin
            //refer
            ref_a <= 511;
            flag <= 1;
        end
    end

    

endmodule