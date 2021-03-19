`timescale 1 ns / 1ns
module Tester;
	
	reg clk;
    reg reset;
	reg [0:7]inst;
	wire [0:7]address;
	wire [0:7]out_data;
    wire store;

	
	CPU_net FUT(clk,inst,reset,address,out_data,store);
	initial begin 
	
		$FaultCollapsing(Tester.FUT,"fault.flt");
		#10;
	
	end 

endmodule
