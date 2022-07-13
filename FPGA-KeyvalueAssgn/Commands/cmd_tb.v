`include "transmitter.v"
`include "cmdextract.v"
`timescale 1ps/1ps

module tb;

reg [7:0] bus_value;
wire [7:0] data_out;
wire signal; 
time clk_time = 1;
time tick_time = 200;
time freq = 32000;
reg ticker;
reg clock;
reg read_enable;

transmitter test (bus_value , clock , ticker , read_enable , signal);
// receiver_2 rec (signal , ticker , clock , data_out );
extractor rec (signal , clock , ticker);

initial begin
    clock<=0;
    ticker<=0;
    read_enable<=1;
end


initial begin

    $dumpfile("check.vcd");
    $dumpvars(0,tb);

    #freq read_enable=0; bus_value=3;
    #freq  read_enable=1;

    #freq read_enable=0; bus_value=45;
    #freq  read_enable=1;

    #freq read_enable=0; bus_value=09;
    #freq read_enable=1;

    #freq read_enable=0; bus_value=67;
    #freq read_enable=1;

    #freq read_enable=0; bus_value=101;
    #freq read_enable=1;


    #freq #freq $finish;




end

always #tick_time ticker <= ~ticker;
always #clk_time clock <= ~clock;
endmodule