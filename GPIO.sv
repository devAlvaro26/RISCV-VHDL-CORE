// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: GPIO.sv
//
// Descripción: Interfaz entradas y salidas placa proyecto 3 fase 4
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 14/01/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax (A3 5)
// -----------------------------------------------------------------------------------------------------

module GPIO(
	input logic CLK, RST_N,
	input logic MemGPIOWrite,
	input logic [10:0] address,
	input logic [16:0] DIN,
	input logic [31:0] MemGPIO,
	output logic [31:0] read_data_GPIO,
	output logic [17:0] LEDr,
	output logic [8:0] LEDg,
	output logic [3:0] HEX
	);

	
	//División de buses a elementos placa
	always_ff @(posedge CLK or negedge RST_N) begin
		if (!RST_N)
			begin
				read_data_GPIO <= 0;
				LEDr <= 0;
				LEDg <= 0;
				HEX <= 0;
			end
			
		else if(MemGPIOWrite)
			begin
				HEX <= MemGPIO[3:0]; //4 bits para display 7-segmentos
				LEDr <= MemGPIO[17:0]; //18 leds rojos
				LEDg <= MemGPIO[8:0]; //9 leds verdes
			end
		
		else
			begin
				read_data_GPIO <= DIN;
			end
	end
	
endmodule
