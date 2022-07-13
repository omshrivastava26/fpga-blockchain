`include "receiver.v"
`include "refer.v"
`include "issue.v"
`include "transfer.v"
`include "create.v"

module extractor (
    input dcom,
    input clk,
    input tick_in
);
    wire [7:0] bus;
    reg [7:0] packet [12:0];
    integer i;
    integer init;
    integer flag;
    reg [7:0] ref_a;
    reg [7:0] isu_a;
    reg [7:0] crt_a;
    reg [7:0] tfr_a;
    wire [7:0] bus_create;
    wire [7:0] bus_issue;
    wire [7:0] bus_refer;
    wire [7:0] bus_transfer;

    assign bus_create[0] = bus[0] & crt_a[0];
    assign bus_create[1] = bus[1] & crt_a[1];
    assign bus_create[2] = bus[2] & crt_a[2];
    assign bus_create[3] = bus[3] & crt_a[3];
    assign bus_create[4] = bus[4] & crt_a[4];
    assign bus_create[5] = bus[5] & crt_a[5];
    assign bus_create[6] = bus[6] & crt_a[6];
    assign bus_create[7] = bus[7] & crt_a[7];
    assign bus_issue[0] = bus[0] & isu_a[0];
    assign bus_issue[1] = bus[1] & isu_a[1];
    assign bus_issue[2] = bus[2] & isu_a[2];
    assign bus_issue[3] = bus[3] & isu_a[3];
    assign bus_issue[4] = bus[4] & isu_a[4];
    assign bus_issue[5] = bus[5] & isu_a[5];
    assign bus_issue[6] = bus[6] & isu_a[6];
    assign bus_issue[7] = bus[7] & isu_a[7];
    assign bus_refer[0] = bus[0] & ref_a[0];
    assign bus_refer[1] = bus[1] & ref_a[1];
    assign bus_refer[2] = bus[2] & ref_a[2];
    assign bus_refer[3] = bus[3] & ref_a[3];
    assign bus_refer[4] = bus[4] & ref_a[4];
    assign bus_refer[5] = bus[5] & ref_a[5];
    assign bus_refer[6] = bus[6] & ref_a[6];
    assign bus_refer[7] = bus[7] & ref_a[7];
    assign bus_transfer[0] = bus[0] & tfr_a[0];
    assign bus_transfer[1] = bus[1] & tfr_a[1];
    assign bus_transfer[2] = bus[2] & tfr_a[2];
    assign bus_transfer[3] = bus[3] & tfr_a[3];
    assign bus_transfer[4] = bus[4] & tfr_a[4];
    assign bus_transfer[5] = bus[5] & tfr_a[5];
    assign bus_transfer[6] = bus[6] & tfr_a[6];
    assign bus_transfer[7] = bus[7] & tfr_a[7];

    reciever rec(dcom, clk, tick_in, bus);

    refer ref(bus_refer);
    create crt(bus_create);
    issue isu(bus_issue);
    transfer tfr(bus_transfer);
    
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
            crt_a <= 255;
            flag <= 1;
        end
        if(bus == 1 && flag == 0) begin
            //issue
            isu_a <= 255;
            flag <= 1;
        end
        if(bus == 2 && flag == 0) begin
            //transfer
            tfr_a <= 255;
            flag <= 1;
        end
        if(bus == 3 && flag == 0) begin
            //refer
            ref_a <= 255;
            flag <= 1;
        end
    end

    

endmodule