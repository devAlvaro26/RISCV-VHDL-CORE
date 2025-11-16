// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: RAM.sv
//
// Descripción: Modulo de memoria RAM
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 23/11/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax
// -----------------------------------------------------------------------------------------------------

module RAM 
	#(parameter depth = 1024) (
	input  logic CLK,
	input  logic MemWrite, MemRead,
	input  logic [$clog2(depth)-1:0] address,	//1024 posiciones
	input  logic [31:0] write_data,
	output logic [31:0] read_data
	);
	
	logic [31:0] mem [0:depth-1];    			//Memoria RAM de 32x1024

	//Escritura sincrona
	always_ff @(posedge CLK) begin
		if (MemWrite)
			begin
				mem[address] <= write_data;
			end
	end

//Lectura asincrona
assign read_data = mem[address];

endmodule
