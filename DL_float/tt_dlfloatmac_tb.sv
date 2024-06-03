module tt_dlfloatmac_tb() ;

  logic [7:0] ui_in,uio_in;
  logic ena,rst_n, clk;
  logic [7:0] uo_out,uio_out,uio_oe;



    tt_um_dlfloatmac dut (
        .clk(clk),
        .rst_n(rst_n),
        .ui_in(ui_in),
        .uo_out(uo_out),
        .uio_in(uio_in),
        .uio_out(uio_out),
        .uio_oe(uio_oe),
        .ena(ena)
    );

 initial 
  begin
    clk = 0;
    forever #5 clk = ~clk;
  end

    initial begin
     
       

       
        #10 rst_n = 0;

     //a=1.32 ; b=2.45
        #10 begin
            ena = 1;
            ui_in = 8'b10100011;//lower 8 bits of a
            uio_in = 8'b10111110;//upper 8 bits of a
          
            #10 begin
                ui_in = 8'b01110011;//lower 8 bits of b
                uio_in = 8'b01000000;//upper 8 bits of b
            end
        end

        
        #40 $finish;
    end

 
    always @(posedge clk) begin
        $display("Time: %t, ui_in: %h, uo_out: %h, uio_in: %h, uio_out: %h, uio_oe: %b", $time, ui_in, uo_out, uio_in, uio_out, uio_oe);
    end

endmodule
