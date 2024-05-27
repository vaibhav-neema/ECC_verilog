module hamming74_enc(
                input  [3:0] i_data,
output [6:0] o_hamming_code,
output  o_parity );  //optional

reg p1, p2, p4;

always @(*) begin
p1 = i_data[0] ^ i_data[1] ^ i_data[3];  //
p2 = i_data[0] ^ i_data[2] ^ i_data[3];
p4 = i_data[1] ^ i_data[2] ^ i_data[3];
end
//Rearrange the data bits for the output
//Input  : d3 d2 d1  d0
//Output : d7 d6 d5 p4 d3 p2 p1

assign o_hamming_code = {i_data[3:1], p4, i_data[0], p2, p1}; // concatenation i/p & parity
// create the optional parity
assign o_parity = ^o_hamming_code;
endmodule