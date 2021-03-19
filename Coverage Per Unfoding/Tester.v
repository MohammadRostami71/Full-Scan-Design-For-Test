`timescale 1 ns / 1ns

module Tester ();
	parameter numOfFaults = 1586.0;
	parameter efCountCT = 2;
	parameter desiredCoverage = 99;
	parameter utLimit = 1000;
	integer clockCount;
	real coverage;
	reg [8*50:1] wireName;
	reg stuckAtVal;
	reg [7:0] testVector;
	reg [1:numOfFaults] detectedListCT, detectedListAT;
	integer uTests, detectedFaultCT, detectedFaultsAT, faultIndex;
	integer faultFile, status ;
	reg clk;
	reg reset;
	reg[7:0] inst;
	wire[7:0] address_G;
	wire[7:0] out_data_G;
	wire store_G;
	wire[7:0] address_F;
	wire[7:0] out_data_F;
	wire store_F;
	
	reg[16:0] woG;
	reg[16:0] woF;
	
	CPU_net GUT (clk,inst,reset,address_G,out_data_G,store_G);
	CPU_net FUT (clk,inst,reset,address_F,out_data_F,store_F);
	initial begin
		uTests = 0;
		clk = 0;
		coverage = 0;
		faultIndex = 1; detectedListAT = 0; detectedFaultsAT = 0;
		detectedListCT = 0; detectedFaultCT = 0;
		while((coverage < desiredCoverage) && (uTests < utLimit)) begin
			testVector = $random($time);
			clockCount = $urandom($time) % 100;
			$display("TV=%b, CC=%d, uTest=%d", testVector, clockCount, uTests);
			uTests = uTests + 1;
			faultFile = $fopen("fault.flt", "r");
			while( ! $feof(faultFile)) begin
				status=$fscanf(faultFile,"%s s@%b\n",wireName,stuckAtVal);
				faultIndex = faultIndex + 1;
				if(detectedListAT[faultIndex] == 0) begin
					reset = 1;
					@(posedge clk) @(negedge clk);
					reset = 0;
					$InjectFault ( wireName, stuckAtVal);
					{inst} = testVector;
					repeat(clockCount) @(posedge clk) @(negedge clk);
					woG = {address_G, out_data_G, store_G};
					woF = {address_F, out_data_F, store_F};
					if (woG != woF) begin
						detectedFaultCT = detectedFaultCT + 1;
						detectedListCT[faultIndex] = 1;
						$display("Fault:%s SA%b detected by %b by %d pulse at %t.",wireName,stuckAtVal,inst,clockCount,$time);
					end //if
					$RemoveFault(wireName);
				end //if !detected
			end //end of while ( ! $feof(faultFile))
			$fclose (faultFile);
			if(detectedFaultCT >= efCountCT) begin
				for(faultIndex=1;faultIndex<=numOfFaults; faultIndex=faultIndex+1)
				if((detectedListCT[faultIndex] == 1'b1)) begin
					detectedListAT[faultIndex] = 1'b1;
				end
			end
		end //while coverage
		for(faultIndex=1;faultIndex<=numOfFaults; faultIndex=faultIndex+1)
				if((detectedListAT[faultIndex] == 1'b1))
					detectedFaultsAT = detectedFaultsAT + 1;
		coverage = 100 * (detectedFaultsAT/numOfFaults);
		$display("fault coverage = %f\n", coverage );
		$stop;
	end //end of initial
	always #25 clk = ~clk;
	
endmodule