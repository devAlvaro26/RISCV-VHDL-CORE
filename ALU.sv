// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: ALU.sv
//
// Descripción: Modulo ALU del microprocesador
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 10/12/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax
// -----------------------------------------------------------------------------------------------------

module ALU (
	input logic [31:0] operando_a,		//Operando A de 32 bits
	input logic [31:0] operando_b,		//Operando B de 32 bits
	input logic [3:0]  alu_control,		//Señal de control de la operación (4 bits)
	output logic [31:0] alu_result,
	output logic zero,						//Flag de cero (1 si el resultado es 0)
	output logic Jump							//Bit usado para la puerta AND que afecta a PC
	);

	always_comb begin
		case (alu_control)
			4'b0000: begin
							alu_result = operando_a + operando_b;								//Suma (ADD, ADDI, AUIPC, SW, LW)
							Jump=0;
						end
										 
			4'b0001: begin
							alu_result = operando_a - operando_b;								//Resta (SUB, BEQ, BNE)
							Jump=(operando_a-operando_b == 0);
						end

			4'b0010: begin
							alu_result = operando_a & operando_b;								//AND (AND, ANDI)
							Jump=0;
						end

			4'b0011: begin
							alu_result = operando_a | operando_b;								//OR (OR, ORI)
							Jump=0;
						end

			4'b0100: begin
							alu_result = operando_a ^ operando_b;								//XOR (XOR, XORI)
							Jump=0;
						end

			4'b0101: begin
							alu_result = operando_a << operando_b[4:0];						//Desplazar lógicamente izq (SLL, SLLI)
							Jump=0;
						end

			4'b0110: begin
							alu_result = operando_a >> operando_b[4:0];						//Desplazar lógicamente der (SRL, SRLI)
							Jump=0;
						end

			4'b0111: begin
							alu_result = $signed(operando_a) >>> operando_b[4:0];			//Desplazar aritméticamente der (SRA, SRAI) [copia el bit de signo]
							Jump=0;
						end

			4'b1000: begin
							alu_result = operando_a < operando_b; 								//Comparación menor que (SLTU, SLTIU) [signed]
							Jump=0;
						end

			4'b1001: begin
							alu_result = $signed(operando_a) < $signed(operando_b);		//Comparación menor que (SLT, SLTI) [unsigned]
							Jump=0;
						end

			4'b1010: begin
							alu_result = operando_b;												//Cargar en la parte alta un inmediato de 20 bits (LUI)
							Jump=0;
						end

			4'b1011: begin
							alu_result = 0;															//Instrucción JAL
							Jump=1;
						end

			4'b1100:	begin 
							alu_result = operando_a+operando_b;									//Es la suma de operandos cambiando el flag J (JALR)
							Jump=1;
						end
										 
			default: begin
						alu_result = 32'b0;
						Jump=0;																			//Por defecto: resultado en 0
						end

		endcase
	end

//Flag de zero
assign zero = (alu_result == 32'b0) ? 1'b1 : 1'b0;

endmodule
