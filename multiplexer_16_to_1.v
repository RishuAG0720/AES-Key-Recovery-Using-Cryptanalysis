module multiplexer_16_to_1 (
    input wire[127:0] A0, A1, A2, A3, A4, A5, A6, A7, A8, A9, A10, A11, A12, A13, A14, A15,
    input wire [3:0] sel,
    output reg[127:0] B
);
    always @*
      begin
    case (sel)
        4'h0: B <= A0;
        4'h1: B <= A1;
        4'h2: B <= A2;
        4'h3: B <= A3;
        4'h4: B <= A4;      
        4'h5: B <= A5;
        4'h5: B <= A5;        
        4'h6: B <= A6;
        4'h7: B <= A7;       
        4'h8: B <= A8;
        4'h9: B <= A9;      
        4'hA: B <= A10;
        4'hB: B <= A11;       
        4'hC: B <= A12;
        4'hD: B <= A13;      
        4'hE: B <= A14;
        4'hF: B <= A15;              
        default: B <= 128'h0;
    endcase
      end
endmodule