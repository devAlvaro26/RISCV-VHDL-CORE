// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: RISC4.sv
//
// Descripción: Implementacion de un diseño de Microprocesador basado en RISC. FASE 4
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 12/12/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax (A3 5)
// -----------------------------------------------------------------------------------------------------

module RISC4 #(parameter depth = 1024) (
	input logic CLK, RESET_N,
	input logic [16:0] DIN,
	output logic [17:0] LEDr,
	output logic [8:0] LEDg,
	output logic L1,L2,L3,L4,L5,L6,L0
	);
	
	logic [31:0] PC;
	logic [31:0] instruction, alu_result, read_data, read_data2;
	logic MemWrite, MemRead;
	
	logic MemWrite_controller;
	logic [10:0] address_out;
	logic [31:0] read_data_controller, Ram_write_data;
	
	logic MemGPIOWrite;
	logic [31:0] MemGPIO, read_data_GPIO;
	
	logic [3:0] HEX;
	
	ROM #(.depth(depth)) ROM(
		.address(PC[11:2]),
		.instruction(instruction)
		);

	RAM #(.depth(depth)) RAM(
		.CLK(CLK),
		.MemWrite(MemWrite_controller),
		.MemRead(MemRead),
		.address(address_out[9:0]),
		.write_data(Ram_write_data),
		.read_data(read_data)
		);
	
	CORE CORE(
		.CLK(CLK),
		.RESET_N(RESET_N),
		.instruction(instruction),
		.PC(PC),
		.read_data(read_data_controller),
		.read_data2(read_data2),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.alu_result(alu_result)
		);
		
	MemoryController MemoryController(
		.MemWrite(MemWrite),
		.read_address(alu_result[10:0]),
		.write_data(read_data2),
		.Ram_read_data(read_data),
		.address_out(address_out),
		.read_data(read_data_controller),
		.Ram_write_data(Ram_write_data),
		.MemWrite_out(MemWrite_controller),
		.MemGPIO_out(MemGPIO),
		.read_data_GPIO(read_data_GPIO),
		.MemGPIOWrite(MemGPIOWrite)
		);
		
	GPIO GPIO(
		.CLK(CLK),
		.RST_N(RESET_N),
		.DIN(DIN),
		.address(address_out),
		.MemGPIO(MemGPIO),
		.MemGPIOWrite(MemGPIOWrite),
		.read_data_GPIO(read_data_GPIO),
		.HEX(HEX),
		.LEDr(LEDr),
		.LEDg(LEDg)
		);
		
	Decoder Decoder(
		.HEX(HEX),
		.L0(L0),
		.L1(L1),
		.L2(L2),
		.L3(L3),
		.L4(L4),
		.L5(L5),
		.L6(L6)
		);
	
endmodule
