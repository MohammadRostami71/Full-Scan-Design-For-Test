module CPU(
    clk,
    inst,
    reset,
    address,
    out_data,
    store
);
    input clk;
    input reset;
    input [7:0] inst;
    output [7:0] address;
    output [7:0] out_data;
    output store;

    wire [7:0] ir_out;
    IR ir (.clk(clk), .reset(reset), .ir_in(inst), .ir_out(ir_out));

    wire [1:0] c_func;
    wire c_jump;
    wire c_store;
    wire c_inc;
    wire c_load;
    wire c_reg_write;
    wire ADD;
    Controller controller(.opcode(ir_out[7:4]), 
        .func(c_func), .jump(c_jump), .store(c_store), .inc(c_inc), .load(c_load) ,.reg_write(c_reg_write),.ADD(ADD));
    
    wire [7:0] alu_in1;
    wire [7:0] alu_in2;
    wire [7:0] alu_out;
    ALU alu(.func(c_func), .in1(alu_in1), .in2(alu_in2), .alu_out(alu_out));

    wire [7:0] selected_reg_write;
    Mux2 reg_file_selector(.in1(alu_out) ,.in2({6'd0,ir_out[1:0]}), .sel(c_load) ,.out(selected_reg_write));

    wire [7:0] R1_out;
    wire [7:0] R2_out;
    RegisterFile registerfile(.clk(clk), .reset(reset), .reg_write(c_reg_write), .in_write(selected_reg_write), 
        .R1(ir_out[3:2]), .R2(ir_out[1:0]) ,.R1_out(R1_out),.R2_out(R2_out));
    assign alu_in1 = R1_out;
    assign alu_in2 = R2_out;

    wire [7:0] selected_address;
    wire [7:0] pc_out; 
	
    PC pc(clk, c_inc, reset, c_jump,selected_address,pc_out);

    wire [7:0] added_address;
    Adder adder (.in1(pc_out), .in2({4'd0,ir_out[3:0]}), .out(added_address));

    Mux2 address_selector(.in1(pc_out) ,.in2(added_address),.sel(c_jump), .out(selected_address));

    assign out_data = alu_out;
    assign address = selected_address;
    assign store = c_store;
endmodule
//////////////////////////
module Adder(in1,in2,out);
input [7:0] in1;
input [7:0] in2;
output reg [7:0] out;
always@(*)
	begin
	out <= in1 + in2 ;
	end
	
endmodule
/////////////////////////
module Mux2(
in1,
in2,
sel,
out
);
input [7:0] in1;
input [7:0] in2;
input sel;
output reg [7:0] out;
always@ (*) 
	begin
		if(sel == 1)
			out <= in1; 
		else
			out <= in2;
	end
endmodule
/////////////////////////////
module ALU(
func,
in1,
in2,
reset,
alu_out
);
input [1:0] func;
input [7:0] in1;
input [7:0] in2;
input reset;
output reg [7:0] alu_out;

always @(func)
	begin
	if ( reset )
		alu_out <= 0 ;
	else begin
      if(func == 2'b00) begin
	  alu_out <= in1 + in2;
	  end
      if(func == 2'b01) begin 
	  alu_out <= in1 - in2;
	  end
      if(func == 2'b10) begin
	  alu_out <= in1;
	  end
	  if(func ==2'b11) begin
	  alu_out <= 0;
	  end
	end
  end
endmodule
////////////////////////
module IR(	clk,
	reset,
	ir_in,
	ir_out
);
input reset;
input clk;
input [7:0] ir_in;
output reg [7:0] ir_out;

always @(posedge clk) 
		if (reset)
			ir_out <= 0;
		else
			ir_out <= ir_in;
endmodule
///////////////////
module PC(clk, c_inc, reset, c_jump,selected_address,pc_out);

input	clk;
input	reset;
input	c_inc;
output	reg [7:0]	pc_out;
input	[7:0]	selected_address;
input	c_jump;

always @(*)
	begin
		if (reset)
			pc_out <= 8'b0;
		else if (c_inc == 1)
			pc_out <= pc_out + 1;
		else if(c_jump == 1)
			pc_out <= selected_address;
	end
endmodule

//////////////////////////
module RegisterFile(clk,reset,reg_write,in_write,R1_out,R2_out,R1,R2);
input [1:0] R1;
input [1:0] R2;
input clk;
input reset;
input reg_write;
input [7:0]in_write;
output [7:0] R1_out;
output [7:0] R2_out;

reg [7:0] register [0:3];

assign R1_out = register[R1];
assign R2_out = register[R2];

always@(posedge clk)begin
	if (reset == 1) begin
		register[0] <= 0;
		register[1] <= 0;
		register[2] <= 0;
		register[3] <= 0;
	end
	if(reg_write ==1)
	begin
		register[R1] <= in_write;
	end
		
end
endmodule
module Controller (
    opcode,
    func,
    jump,
    store,
    inc,
    load,
    reg_write,
	ADD
);
    input [3:0] opcode;
    output [1:0] func;
    output jump;
    output store;
    output inc;
    output load;
    output reg_write;
	input ADD;
	
    assign func = opcode[1:0];
    assign load = opcode [2];
    assign store = opcode[1] & (~opcode[0]);
    assign jump = opcode[3];
    assign reg_write = opcode[3] | (~(opcode[3])& (~opcode[1]) );
    assign inc = ~opcode[3];
endmodule

