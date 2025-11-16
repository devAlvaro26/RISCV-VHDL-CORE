// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: MemoryController.sv
//
// Descripción: Controlador de memoria para implementacion en placa
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 27/12/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax (A3 5)
// -----------------------------------------------------------------------------------------------------

module MemoryController(
	input logic MemWrite,
	input logic [10:0] read_address,
	input logic [31:0] write_data,
	input logic [31:0] Ram_read_data,
	input logic [31:0] read_data_GPIO,
	output logic [10:0] address_out,
	output logic [31:0] read_data,
	output logic [31:0] Ram_write_data,
	output logic [31:0] MemGPIO_out,
	output logic MemWrite_out, MemGPIOWrite
	);

	always_comb begin
		if (MemWrite) begin
			//Mientras read address valida display de valor
			if (read_address <= 'd1023)
				begin
					MemWrite_out <= MemWrite;
					MemGPIOWrite <= MemWrite;
					Ram_write_data <= write_data;
					MemGPIO_out <= write_data;
					read_data <= Ram_read_data;
				end
			else
				//No cambios en display
				begin
					MemWrite_out <= 0;
					MemGPIOWrite <= MemWrite;
					MemGPIO_out <= write_data;
					Ram_write_data <= write_data;
					read_data <= read_data_GPIO;
				end
				
		end
		
		else
			begin
				read_data <= read_data_GPIO;
				Ram_write_data <= 0;
				MemGPIO_out <= 0;
				MemWrite_out <= 0;
				MemGPIOWrite <= 0;
			end
	end
	
assign address_out = read_address;

endmodule
