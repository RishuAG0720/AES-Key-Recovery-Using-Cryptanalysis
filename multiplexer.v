module mux_2_1 (
    input wire a,
    input wire b,
    input wire sel,

    output wire x
);
    
    assign x = (a&(~sel))|(b&sel);

endmodule