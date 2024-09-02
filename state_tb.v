`include "aes_top.v"


module tb_aes_top;
reg clk;
reg reset;
reg start;
wire done;
reg[127:0] plaintext;
reg[127:0] key;
wire[127:0] cipher;

aes_top aet
(
    .reset (reset),
    .clk (clk),
    .plaintext(plaintext),
    .key(key),
    .start(start),
    .ciphertext(cipher),
    .done(done)
);

localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_aes_top.vcd");
    $dumpvars(0, tb_aes_top);
end

initial begin
    clk = 0;
    key <= 128'h31323334353637383930313233343536;
    plaintext <= 128'h616263646566;

    // output should be 67FA251AAFCDB834F75BCA46361FC31E
    
    reset = 1;
    #10
    reset = 0;
    #10
    start = 1;
    #10
    start = 0;
    #150;


    $finish;
end

endmodule
