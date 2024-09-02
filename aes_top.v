`include "aes_key_expand.v"
`include "multiplexer_16_to_1.v"
`include "subbytes.v"
`include "shiftrows.v"
`include "mixcolumn.v"

module aes_top (
    input wire clk,
    input wire reset,
    input wire[127:0] plaintext,
    input wire[127:0] key,
    input wire start,

    output reg[127:0] ciphertext,
    output reg done
);
    
    reg [3:0] state;
    
    reg [127:0] state_reg;
    
    wire [127:0] sr_out;
    wire [127:0] mix_out;
    wire [127:0] sub_to_sr;

    wire [10:0][127:0] key_exp;
    
    wire [127:0] curr_rd_key;
    
    parameter RESET = 4'b1111 ;
    parameter R0 = 4'b0000, R1 = 4'b0001, R2 = 4'b0010, R3 = 4'b0011, R4 = 4'b0100, R5 = 4'b0101, R6 = 4'b0110, R7=4'b0111, R8=4'b1000, R9=4'b1001, R10=4'b1010;
    parameter DONE = 4'b1011;
    parameter IDLE = 4'b1100;


    aes_key_expand_128 keygen 
    (
        .clk (clk),
        .key (key),
        .key_s0(key_exp[0]),
        .key_s1(key_exp[1]),
        .key_s2(key_exp[2]),
        .key_s3(key_exp[3]),
        .key_s4(key_exp[4]),
        .key_s5(key_exp[5]),
        .key_s6(key_exp[6]),
        .key_s7(key_exp[7]),
        .key_s8(key_exp[8]),
        .key_s9(key_exp[9]),
        .key_s10(key_exp[10])
    );

    multiplexer_16_to_1 mux
    (
        .sel(state),
        .B(curr_rd_key),
        .A0(key_exp[0]),
        .A1(key_exp[1]),
        .A2(key_exp[2]),
        .A3(key_exp[3]),
        .A4(key_exp[4]),
        .A5(key_exp[5]),
        .A6(key_exp[6]),
        .A7(key_exp[7]),
        .A8(key_exp[8]),
        .A9(key_exp[9]),
        .A10(key_exp[10]),
        .A11(128'b0),
        .A12(128'b0),
        .A13(128'b0),
        .A14(128'b0),
        .A15(128'b0)
    );


    subbytes sub(state_reg,sub_to_sr);
    shiftrows sr(sub_to_sr,sr_out);
    mixcolumn mx(sr_out,mix_out);

    

    always @(posedge reset or posedge clk)
    begin
        if(reset)
        begin
            state <= RESET;
            done <= 1'b0;
        end
        else if(start)
        begin
            state <= R0;
        end
        else if(state == DONE)
        begin
            state <= IDLE;
        end
        else if(state == IDLE||state == RESET)
        begin
            state <= IDLE;
            done <= 1'b0;
        end
        else
        begin
            state <= state + 1;
            if(state == DONE)
            begin
                done <= 1'b1;
            end
        end
    end

    always @(posedge clk)
    begin
        case (state)
            R0:begin  
                state_reg <= plaintext^curr_rd_key;
                done <= 1'b0;
            end
            R1:begin
                state_reg <= mix_out^curr_rd_key;
            end
            R2:begin
                state_reg <= mix_out^curr_rd_key;
            end
            R3:begin
                state_reg <= mix_out^curr_rd_key;
            end
            R4:begin
                state_reg <= mix_out^curr_rd_key;
            end
            R5:begin
                state_reg <= mix_out^curr_rd_key;
            end
            R6:begin
                state_reg <= mix_out^curr_rd_key;
            end
            R7:begin
                state_reg <= mix_out^curr_rd_key;
            end
            R8:begin
                state_reg <= mix_out^curr_rd_key;
            end
            R9:begin
                state_reg <= mix_out^curr_rd_key;
            end
            R10:begin
                state_reg <= sr_out^curr_rd_key;
            end
            DONE: begin
                done <= 1'b1;
                ciphertext <= state_reg;
            end
            IDLE: done <= 1'b0;
            RESET: begin 
            done <= 1'b0;
            ciphertext <= 128'b0;
            end
            default: done <= 1'b0;
        endcase
    end


endmodule
