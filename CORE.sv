// -----------------------------------------------------------------------------------------------------
// Universitat Politècnica de València
// Escuela Técnica Superior de Ingenieros de Telecomunicación
// -----------------------------------------------------------------------------------------------------
// Integracion de Sistemas Digitales
// Curso 2024-25
// -----------------------------------------------------------------------------------------------------
// Nombre del archivo: CORE.sv
//
// Descripción: Implementacion de un diseño de Microprocesador basado en RISC. FASE 4
// -----------------------------------------------------------------------------------------------------
// Versión: v1.0 | Fecha Modificación: 12/12/2024
//
// Autores: Rafa Budia, Jorge Nisa, Álvaro Roca, Alejandro Saez, Francesc Tudela y Paulina Wax (A3 5)
// -----------------------------------------------------------------------------------------------------

module CORE (
	input logic CLK, RESET_N,
	input logic [31:0] instruction, read_data,
	output logic MemWrite, MemRead,
	output logic [31:0] PC,
	output logic [31:0] alu_result, read_data1, read_data2
	);
	
	//Señales Banco de Registros
	logic [4:0] read_reg1, read_reg2, write_reg;
	logic [31:0] write_data;
	logic RegWrite;

	//Señales ALU
	logic [31:0] alu_in1, alu_in2;
	logic zero_flag, Jump;

	//Señales RAM
	logic [9:0] ram_address;
	
	//Control
	logic Branch;
	logic MemtoReg;
	logic [2:0] ALUOp;
	logic ALUSrc;
	logic [1:0] AuipcLui;
	
	//ALU_CONTROL
	logic [3:0] ALUControl;
	
	//Imm
	logic [31:0] imm;
	
	Register Register_Bank (
		.CLK(CLK),
		.RST_N(RESET_N),
		.RegWrite(RegWrite),
		.read_reg1(read_reg1),
		.read_reg2(read_reg2),
		.write_reg(write_reg),
		.write_data(write_data),
		.read_data1(read_data1),
		.read_data2(read_data2)
		);

	ALU ALU (
		.operando_a(alu_in1),
		.operando_b(alu_in2),
		.alu_control(ALUControl),
		.alu_result(alu_result),
		.zero(zero_flag),
		.Jump(Jump)
		);
	
	Control Control (
		.instruction(instruction[6:0]),
		.Branch(Branch),
		.MemRead(MemRead),
		.MemWrite(MemWrite),
		.MemtoReg(MemtoReg),
		.ALUOp(ALUOp),
		.ALUSrc(ALUSrc),
		.RegWrite(RegWrite),
		.AuipcLui(AuipcLui)
		);
		
	ALU_CONTROL ALU_CONTROL (
		.instruction({instruction[30],instruction[14:12]}),
		.ALUOp(ALUOp),
		.ALUControl(ALUControl)
		);
		
	ImmGen ImmGen (
		.inst(instruction),
		.imm(imm)
		);
		
	//PC	
	always_ff @(posedge CLK or negedge RESET_N) begin
		if (!RESET_N)
			PC <= 0;
		else
			begin
				if (Branch && Jump)
					PC <= PC + imm;
				else
					PC <= PC + 4;
			end
	end
	
//ALU
assign alu_in1 = (AuipcLui == 2'b00) ? PC : ((AuipcLui == 2'b01) ? 32'd0 : read_data1);
assign alu_in2 = (ALUSrc) ? imm : read_data2;

//Banco de registros	
assign read_reg1 = instruction[19:15];
assign read_reg2 = instruction[24:20];
assign write_reg = instruction[11:7];
assign write_data = (MemtoReg) ? read_data : alu_result;

endmodule
