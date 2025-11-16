`timescale 1ns/1ps

module TB_RISC;
parameter depth = 1024;
localparam T = 20;

logic CLK, RESET_N;

//CORE
logic [31:0] PC;
logic [31:0] instruction, alu_result, read_data, read_data2;
logic MemWrite, MemRead;
		
	ROM #(.depth(depth)) ROM(
		.address(PC[11:2]),
		.instruction(instruction)
	);

	RAM #(.depth(depth)) RAM(
		.CLK(CLK),
		.MemWrite(MemWrite),
		.address(alu_result[9:0]),
		.write_data(read_data2),
		.read_data(read_data)
	);
	
	CORE duv(
		.CLK(CLK),
		.RESET_N(RESET_N),
		.instruction(instruction),
		.PC(PC),
		.read_data(read_data),
		.read_data2(read_data2),
		.MemWrite(MemWrite),
		.MemRead(MemRead),
		.alu_result(alu_result)
	);
		
//CLK		
always #(T/2) CLK = ~CLK;

	task inicializar();
		begin
			CLK = 0;
			RESET_N = 1;
		end
	endtask
	
	task reset();
		begin
			RESET_N = 0;
			#T
			RESET_N = 1;
		end
	endtask

	initial begin
		$display("Iniciando Test Bench para FASE 4 del CORE");
		inicializar();
		reset();

		//Monitorear la señal `instruction` para detener la simulacion
		@(negedge CLK);
		while (!instruction[0] || instruction[0]) begin
			@(negedge CLK);
		end

		$display("Finalizando Test Bench");
		$stop;
	end

endmodule
