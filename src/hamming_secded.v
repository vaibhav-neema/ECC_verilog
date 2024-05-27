`timescale 1ns / 1ps
 

module hamming_secded (
          input [3:0] i_secded,
          input [4:0] i_noise,
          //output[6:0] o_7seg,
 output[3:0] o_secded,
 output      o_1bit_error,
 output      o_2bit_error,
 output      o_parity_error  );
 
 //internal logic (glue logic)
         wire [6:0] enc_hamming_code; //output for the Hamming encoder
         wire       enc_parity;

wire [6:0] o_noise_hamming_code; //Outputs for noise module
wire       o_noise_parity;
wire [6:0] o_syndrome;  //Output for the Hamming decoder
         wire [2:0] in_7seg;  //input for 7Segment display decoder

//Instantiate the Hamming74 Encoder
hamming74_enc HAMM_ENC0 (
                 .i_data         (i_secded  ),
                          .o_hamming_code (enc_hamming_code),
                          .o_parity       (enc_parity ) );
       
         //Instantiate the noise module  
         noise_add NOISE0 (
                           .i_data  ({enc_parity, enc_hamming_code}  ),
  .i_noise (i_noise ),
  .o_data  ({o_noise_parity, o_noise_hamming_code}) );
 
//Instantiate the Hamming74 Decoder
hamming74_dec HAMM_DEC0 (
  .i_data        (o_noise_hamming_code),
  .i_parity      (o_noise_parity      ),
  .o_syndrome    (o_syndrome          ),
  .o_data        (o_secded            ),
  .o_1bit_error  (o_1bit_error        ),
  .o_2bit_error  (o_2bit_error        ),
  .o_parity_error(o_parity_error      ) );
 
 
 endmodule
