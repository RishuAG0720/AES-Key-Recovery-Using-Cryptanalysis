`include "multiplexer_16_to_1.v"


module tb_multiplexer_16_to_1;
wire[127:0] A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15;
wire [3:0] sel;
wire[127:0] B;

multiplexer_16_to_1 edsvdf
(
    .sel(sel),
    .B(B),
    .A0(A0),
    .A1(A1),
    .A2(A2),
    .A3(A3),
    .A4(A4),
    .A5(A5),
    .A6(A6),
    .A7(A7),
    .A8(A8),
    .A9(A9),
    .A10(A10),
    .A11(A11),
    .A12(A12),
    .A13(A13),
    .A14(A14),
    .A15(A15)
    
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_multiplexer_16_to_1.vcd");
    $dumpvars(0, tb_multiplexer_16_to_1);
end

initial begin
   clk <= 0;
   A0 <= 128'd0;
   A1 <= 128'd1;
   A2 <= 128'd2;
   A3 <= 128'd3;
   A4 <= 128'd4;
   A5 <= 128'd5;
   A6 <= 128'd6;
   A7 <= 128'd7;
   A8 <= 128'd8;
   A9 <= 128'd9;
   A10 <= 128'd10;

   #10

   sel <= 4'b0010;
   #10
   sel <= 4'b0101;
   #10
   sel <= 4'b1110;
   $finish;

end

endmodule
