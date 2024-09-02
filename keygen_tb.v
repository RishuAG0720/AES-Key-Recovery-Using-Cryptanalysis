`include "aes_key_expand.v"
`include "sbox.v"
`default_nettype none

module tb_aes_key_expand_128;
reg clk;
reg rst_n;
reg [127:0] key;
wire [127:0] key_exp_0,key_exp_1,key_exp_2,key_exp_3,key_exp_4,key_exp_5,key_exp_6,key_exp_7,key_exp_8,key_exp_9,key_exp_10;
aes_key_expand_128 keygen
(
    .clk (clk),
    .key(key),
    .key_s0(key_exp_0),
    .key_s1(key_exp_1),
    .key_s2(key_exp_2),
    .key_s3(key_exp_3),
    .key_s4(key_exp_4),
    .key_s5(key_exp_5),
    .key_s6(key_exp_6),
    .key_s7(key_exp_7),
    .key_s8(key_exp_8),
    .key_s9(key_exp_9),
    .key_s10(key_exp_10)
);



localparam CLK_PERIOD = 10;
always #(CLK_PERIOD/2) clk=~clk;

initial begin
    $dumpfile("tb_aes_key_expand.vcd");
    $dumpvars(0, tb_aes_key_expand_128);
end

initial begin
    #10 clk <= 0;
    key <= 128'hA4F53244903CB7212F23757B5C8F3388;
    #500
    $finish;

end

endmodule
`default_nettype wire