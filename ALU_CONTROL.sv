// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: ALU_CONTROL.sv
//
// Descripción: Modulo de control para operaciones de la ALU
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 10/12/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax (A3 5)
// -----------------------------------------------------------------------------------------------------

module ALU_CONTROL(
	input logic [3:0] instruction,
	input logic [2:0] ALUOp,		//3 bits teniendo en cuenta futuras ampliaciones de operaciones
	output logic [3:0] ALUControl
	);
	
	
	always_comb begin
		case (ALUOp)
			3'b000:											// Tipo R
				case(instruction)							//	Instruction formado por el segundo bit de F7 y los 3 bits de F3
					4'b0000: ALUControl = 4'b0000;	// Instrucción ADD
					4'b1000:	ALUControl = 4'b0001;	// Instrucción SUB
					4'b0001: ALUControl = 4'b0101;	// Instrucción SLL
					4'b0010: ALUControl = 4'b1001;	// Instrucción SLT
					4'b0011:	ALUControl = 4'b1000;	// Instrucción SLTU
					4'b0100: ALUControl = 4'b0100;	// Instrucción XOR
					4'b0101: ALUControl = 4'b0110;	// Instrucción SRL
					4'b1101:	ALUControl = 4'b0111;	// Instrucción SRA
					4'b0110: ALUControl = 4'b0011;	// Instrucción OR
					4'b0111: ALUControl = 4'b0010;	// Instrucción AND
					default: ALUControl = 4'b0000;
				endcase
		
		
			3'b001:											// Tipo B
				case(instruction)							// Instruction formado x y los 3 bits de F3
					4'bX000: ALUControl = 4'b0001;	// Instrucción BEQ
					4'bX001:	ALUControl = 4'b0001;	// Instrucción BNE
					default: ALUControl = 4'b0001;
				endcase
					
		
		
			3'b010:											// Tipo S
				ALUControl = 4'b0000;					// Intrucción LW y SW

				
			3'b011:											// Tipo I
				case(instruction)							//	Instruction formado por el segundo bit de F7 y los 3 bits de F3
					4'b0000: ALUControl = 4'b0000;	// Instrucción ADDI
					4'b0001: ALUControl = 4'b0101;	// Instrucción SLLI
					4'b0010: ALUControl = 4'b1001;	// Instrucción SLTI
					4'b0011:	ALUControl = 4'b1000;	// Instrucción SLTIU
					4'b0100: ALUControl = 4'b0100;	// Instrucción XORI
					4'b0101: ALUControl = 4'b0110;	// Instrucción SRLI
					4'b1101:	ALUControl = 4'b0111;	// Instrucción SRAI
					4'b0110: ALUControl = 4'b0011;	// Instrucción ORI
					4'b0111: ALUControl = 4'b0010;	// Instrucción ANDI
					default: ALUControl = 4'b0000;
				endcase
			
			
			
			3'b100:											// Tipo U (AUIPC)
				ALUControl = 4'b0000;	// Instrucción AUIPC
			
			
			
			3'b101:											// Tipo U (LUI)
				ALUControl = 4'b1010;	// Instrucción LUI
				

			3'b110:											// Tipo UJ (JAL)
				ALUControl = 4'b1011;	// Instrucción JAL
				
				
			3'b111:											// Tipo I (JALR)
				ALUControl = 4'b1100;	// Instrucción JALR
					
			default: ALUControl = 4'b0000;			//Por defecto: resultado en 0
		endcase
	end

endmodule
