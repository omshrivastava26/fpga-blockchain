module refer (
    input [7:0] byte,
    input newbyt,
    output reg [1:0] signal,
    output reg [31:0] key,
    output reg [31:0] transact_kind,
    output reg [31:0] transact_value
);

    reg init1 = 0;
    reg [7:0] packet [11:0];
    reg [3:0] i;
    reg trigger;
    reg init2 = 0;
    reg init3 = 0;
    
    initial begin
        init1 = 0;
        i = 0;
        init2 = 0;
        init3 = 0;
    end

    always@(newbyt) begin
        if(init1 == 0) begin
            init1 = 1;
        end else begin
            if(init2 == 0) begin
                init2 = 1;
            end
            else begin
                if(init3 == 0) begin
                    init3 = 1;
                end
            //$display("refer");
                else begin
                    if(i < 12) begin
                        //$display("byte %d", byte);
                        //$display("i %d", i);
                        packet[i] = byte;
                        //$display("%d", packet[i]);
                        i = i+1;
                        //$display("%d, new i", i);
                        //$display("I reach here");
                        //$display("%d", packet[i]);
                    end
                    if(i == 12) begin
                        //$display("do i reach here?");
                        trigger = 1;
                    end
                end
            end
        end
    end

    always@(trigger) begin
        signal= 2;
        transact_kind = 0;
        key[31:24] = packet[0];
        key[23:16] = packet[1];
        key[15:8] = packet[2];
        key[7:0] = packet[3];
        value[31:24] = packet[8];
        value[23:16] = packet[9];
        value[15:8] = packet[10];
        value[7:0] = packet[11];

        signal = 2;
        transact_kind = 1;
        key[31:24] = packet[4];
        key[23:16] = packet[5];
        key[15:8] = packet[6];
        key[7:0] = packet[7];
        value[31:24] = packet[8];
        value[23:16] = packet[9];
        value[15:8] = packet[10];
        value[7:0] = packet[11];
        //$display("%d", key);
    end

endmodule