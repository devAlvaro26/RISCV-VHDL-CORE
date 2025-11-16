// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: Control.sv
//
// Descripción: Modulo de Control de señales del microprocesador
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 26/11/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax (A3 5)
// -----------------------------------------------------------------------------------------------------

module Control (
	input logic [6:0] instruction,
	output logic Branch,
	output logic MemRead,
	output logic MemtoReg,
	output logic [2:0] ALUOp,
	output logic MemWrite,
	output logic ALUSrc,
	output logic RegWrite,
	output logic [1:0] AuipcLui
	);
	
	parameter [6:0] Rformat=7'b0110011;
	parameter [6:0] Iformat=7'b0010011;
	parameter [6:0] LW=7'b0000011;
	parameter [6:0] SW=7'b0100011;
	parameter [6:0] Bformat=7'b1100011;
	parameter [6:0] JAL=7'b1101111;
	parameter [6:0] JALR=7'b1100111;
	parameter [6:0] LUI=7'b0110111;
	parameter [6:0] AUIPC=7'b0010111;	
	
	always_comb begin
		case (instruction)
			Rformat: begin
					ALUOp = 3'b000;
					AuipcLui = 2'b10;
					ALUSrc = 0;
					MemtoReg = 0;
					RegWrite = 1;
					MemWrite = 0;
					MemRead = 0;
					Branch = 0;
				end
				
			Iformat: begin
				ALUOp = 3'b011;
				AuipcLui = 2'b10;
				ALUSrc = 1;
				MemtoReg = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				Branch = 0;
			end

			LW: begin
				ALUOp = 3'b010;
				AuipcLui = 2'b10;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 1;
				MemtoReg = 1;
				ALUSrc = 1;
				Branch = 0;
			end

			SW: begin
				ALUOp = 3'b010;
				AuipcLui = 2'b10;
				ALUSrc = 1;
				RegWrite = 0;
				MemtoReg = 0;
				MemWrite = 1;
				MemRead = 0;
				Branch = 0;
			end
			
			Bformat: begin
					ALUOp = 3'b001;
					AuipcLui = 2'b10;
					ALUSrc = 0;
					RegWrite = 0;
					MemtoReg = 0;
					MemWrite = 0;
					MemRead = 0;
					Branch = 1;
				end
				
			AUIPC: begin
				ALUOp = 3'b100;
				AuipcLui = 2'b00;
				ALUSrc = 1;
				MemtoReg = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				Branch = 0;
			end

			LUI: begin
				ALUOp = 3'b101;
				AuipcLui = 2'b01;
				ALUSrc = 1;
				MemtoReg = 0;
				RegWrite = 1;
				MemWrite = 0;
				MemRead = 0;
				Branch = 0;
			end

			JAL: begin
					Branch=0;
					MemtoReg=0;
					ALUOp=3'b110;
					MemWrite=0;
					MemRead = 0;
					ALUSrc=0;
					RegWrite=0;
					AuipcLui=2'b10;
				end
						
			JALR: begin
					Branch=0;
					MemtoReg=1'b0;
					ALUOp=3'b111;
					MemWrite=0;
					MemRead = 0;
					ALUSrc=0;
					RegWrite=0;
					AuipcLui=2'b10;
				end

			default: begin
				ALUOp = 3'b000;
				AuipcLui = 2'b00;
				ALUSrc = 0;
				MemtoReg = 0;
				RegWrite = 0;
				MemWrite = 0;
				MemRead = 0;
				Branch = 0;
			end
		endcase
	end
	
endmodule
