`timescale 1 ns / 1ns
module Tester;

	parameter nff = 56; 		 
	parameter in_size = 8; 	
	parameter out_size = 17;	
	parameter st_size = 56;	
	parameter stIndex = 34; 	
	parameter line_size = st_size * 2 + in_size + out_size;
	reg [8*50:1] wireName;
	
	parameter numOfPIs = 17;
	parameter numOfPOs = 8;
	parameter numOfDffs = 56;
	
	reg [numOfPIs+ numOfPOs + 2 * numOfDffs - 1 : 0] line;
	reg stuckAtVal;
	reg clk;
	reg[7:0] inst;
	reg reset;
	reg Si;
	reg NbarT;
	reg [16:0] PO; 
	
	wire[7:0] address;
	wire[7:0] out_data;
	wire store;
	wire So;
	integer faultFile, testFile, status,numOfFaults,index,numOfDetected,detected;
	reg [39:0]saved_st;
	reg [39:0]cur_expected_st;
	reg [39:0]pre_expected_st;
	reg [16:0]expected_PO;
	reg [16:0]SampledPO;
	
	CPU_net FUT(clk,inst,reset,address,out_data,store,NbarT,Si,So);
	always #10 clk = ~clk;
	initial begin
		clk = 0;
		/* faultFile = $fopen("fault.flt", "w");
		$FaultCollapsing(Tester.FUT, "fault.flt");
		$fclose(faultFile); */
		faultFile = $fopen("fault.flt", "r");
		numOfDetected = 0;
		numOfFaults = 0;
		while( !$feof(faultFile)) begin
			testFile = $fopen("TestVector.tst","r");
			status = $fscanf(faultFile,"%s s@%b\n",wireName, stuckAtVal );
			$InjectFault ( wireName, stuckAtVal );
			reset = 1'b1; #1;
			reset = 1'b0;
			inst = 0;
			cur_expected_st = 0;
			detected = 1'b0;
			
			while((!$feof(testFile))&&(!detected))begin
				status = $fscanf(testFile,"%b\n",line);
				pre_expected_st = cur_expected_st;
				expected_PO = line[out_size - 1:0];
				cur_expected_st = line[st_size + out_size -1 :out_size];
				inst = line[st_size+out_size+in_size-1:st_size+out_size];
				@(posedge clk);
				NbarT = 1'b1;
				index = stIndex;
				repeat(nff) begin
					Si = line[index];
					saved_st[index - stIndex] = So;
					@(posedge clk);
					index = index + 1;
				end
				PO={address,out_data,store};
				SampledPO = PO;
				NbarT = 1'b0;
				#5;
				if({pre_expected_st, expected_PO} != {saved_st, SampledPO})
				begin
					numOfDetected = numOfDetected + 1;
					detected = 1;
				end
			end//test
			if(detected == 0) $display("NOT DETECTED = %s s@%b", wireName, stuckAtVal );
			$RemoveFault(wireName);
			numOfFaults = numOfFaults + 1;
			$fclose(testFile);
		end//fault
		$fclose(faultFile);
		$display("number of faults = %f",numOfFaults );
		$display("number of detected faults = %f", numOfDetected );
		$display("Coverage = %f", numOfDetected * 100.0 / numOfFaults);
		$stop;
	end//initial
endmodule