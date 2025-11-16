// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: ImmGen.sv
//
// Descripción: Modulo generador de inmediatos en funcion de tipo de operacion
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 26/11/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax (A3 5)
// -----------------------------------------------------------------------------------------------------

module ImmGen (
	input logic [31:0] inst,
	output logic [31:0] imm
	);

	always_comb begin
		case (inst[6:0])
			7'b0010011, 7'b0000011, 7'b1100111: imm = {{21{inst[31]}}, inst[30:20]};	//I
			7'b0100011: imm = {{21{inst[31]}}, inst[30:25], inst[11:7]};	//S
			7'b1100011: imm = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};	//B
			7'b0110111, 7'b0010111: imm = {inst[31:12], 12'd0};	//U
			7'b1101111: imm = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};	//J
			default: imm = 32'b0;
		endcase
	end

endmodule