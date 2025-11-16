// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: Decoder.sv
//
// Descripción: Decodificador 7 segmentos para placa
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 27/12/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax (A3 5)
// -----------------------------------------------------------------------------------------------------

module Decoder(
	input logic [3:0] HEX,
	output logic L0,L1,L2,L3,L4,L5,L6
	);
	
	logic [6:0] segmento;
	
	always_comb begin
		case (HEX)
			4'b0000: segmento = 7'b1000000; //0
			4'b0001: segmento = 7'b1111001; //1
			4'b0010: segmento = 7'b0100100; //2
			4'b0011: segmento = 7'b0110000; //3
			4'b0100: segmento = 7'b0011001; //4
			4'b0101: segmento = 7'b0010010; //5
			4'b0110: segmento = 7'b0000010; //6
			4'b0111: segmento = 7'b1111000; //7
			4'b1000: segmento = 7'b0000000; //8
			4'b1001: segmento = 7'b0011000; //9
			4'b1010: segmento = 7'b0001000; //A
			4'b1011: segmento = 7'b0000011; //B
			4'b1100: segmento = 7'b1000110; //C
			4'b1101: segmento = 7'b0100001; //D
			4'b1110: segmento = 7'b0000110; //E
			4'b1111: segmento = 7'b0001110; //F
			default: segmento = 7'b1111111; //default
		endcase
	end
	
assign L0 = segmento[0];
assign L1 = segmento[1];
assign L2 = segmento[2];
assign L3 = segmento[3];
assign L4 = segmento[4];
assign L5 = segmento[5];
assign L6 = segmento[6];

endmodule
