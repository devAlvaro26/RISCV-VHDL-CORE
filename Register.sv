// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: Register.sv
//
// Descripción: Modulo de registro del microprocesador
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 23/11/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax
// -----------------------------------------------------------------------------------------------------

module Register (
	input logic CLK, RST_N,
	input logic RegWrite,
	input logic [4:0] read_reg1,
	input logic [4:0] read_reg2,
	input logic [4:0] write_reg,
	input logic [31:0] write_data,
	output logic [31:0] read_data1,
	output logic [31:0] read_data2
	);

	//32 registros de 32 bits
	logic [31:0] [31:0] registers;

	//Escritura sincrona
	always_ff @(posedge CLK or negedge RST_N) begin
		if (!RST_N)
            registers <= 0;
		else
			if (RegWrite && write_reg != 0)
				registers[write_reg] <= write_data;
	end

//Lectura asincrona
assign read_data1 = registers[read_reg1];
assign read_data2 = registers[read_reg2];	
	
endmodule
