// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: ROM.sv
//
// Descripción: Modulo de memoria ROM
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 23/11/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax
// -----------------------------------------------------------------------------------------------------

module ROM 
	#(parameter depth = 1024) (
	input logic [$clog2(depth)-1:0] address,		//1024 posiciones
	output logic [31:0] instruction					//32 bits datos
	);
	
	logic [31:0] mem [0:depth-1]; 					//ROM 32x1024
	
	initial begin
		$readmemh("rom_mem.hex", mem);
	end
	
assign instruction = mem[address];

endmodule
