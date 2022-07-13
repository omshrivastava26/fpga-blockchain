module issue (
    input [7:0] byte
);

    reg init1 = 0;
    //reg init2 = 0;
    
    initial begin
        init1 <= 0;
        //init2 <= 0;
    end

    always@(byte) begin
        if(init1 == 0) begin
            init1 <= 1;
        end else begin
            //if(init2 == 0) begin
            //    init2 <= 1;
            //end
            //else begin
            $display("issue");
            //end
        end
    end

endmodule