module shift_left_2(
    output [31:0] shifted_address,
    input [31:0] address
);

// Connect the input bits to the output bits shifted left by 2 positions
genvar i;
generate
    for (i = 0; i < 30; i = i + 1) begin : shift
        buf(shifted_address[i+2], address[i]);
    end
endgenerate

// The two least significant bits of the shifted output are always 0
buf(shifted_address[0], 1'b0);
buf(shifted_address[1], 1'b0);

endmodule
