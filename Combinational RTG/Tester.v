`timescale 1 ns / 1ns
module Tester();
	parameter numOfFaults = 1474;
	parameter initialExpFCount = 2;
	parameter utLimit = 1000;
	parameter desiredCoverage = 99;
	reg [8*50:1] wireName;
	reg stuckAtVal;
	reg [63:0] testVector;
	reg [1:numOfFaults] detectedListCT, detectedListAT;
	integer faultFile, testFile, testFile2,testFile3,testFile4, outputFile, status;
	integer uTests, detectedFaultsCT, expFCountCT, faultIndex;
	integer tmp, newDiscovered;
	real detectedFaultsAT, coverage;
	
	reg [0:7]inst;
	wire [0:7]address_outG, address_outF;
	wire [0:7]out_data_outG, out_data_outF;
	wire store_outG, store_outF;
	
	reg [72:0] woF, woG;
	
	////////////////////input Good //////////////////////////////////////////
	reg CPU_wire_75_inG,CPU_wire_78_inG,CPU_wire_86_inG,CPU_wire_88_inG,CPU_wire_2_inG,CPU_wire_4_inG,CPU_wire_92_inG,CPU_wire_7_inG,
	CPU_wire_126_inG,CPU_wire_142_inG,CPU_wire_158_inG,CPU_wire_174_inG,CPU_wire_190_inG,CPU_wire_206_inG,CPU_wire_222_inG,CPU_wire_238_inG,CPU_wire_116_inG,
	CPU_wire_132_inG,CPU_wire_148_inG,CPU_wire_164_inG,CPU_wire_180_inG,CPU_wire_196_inG, CPU_wire_212_inG,CPU_wire_228_inG,CPU_wire_123_inG,CPU_wire_139_inG,
	CPU_wire_155_inG,CPU_wire_171_inG,CPU_wire_187_inG,CPU_wire_203_inG,CPU_wire_219_inG,CPU_wire_235_inG,CPU_wire_112_inG, CPU_wire_128_inG,CPU_wire_144_inG,
	CPU_wire_160_inG,CPU_wire_176_inG,CPU_wire_192_inG,CPU_wire_208_inG,CPU_wire_224_inG,CPU_wire_10_inG,CPU_wire_12_inG,CPU_wire_14_inG,CPU_wire_16_inG,CPU_wire_18_inG,
	CPU_wire_20_inG,CPU_wire_22_inG,CPU_wire_24_inG,CPU_wire_58_inG,CPU_wire_61_inG,CPU_wire_63_inG,CPU_wire_65_inG,CPU_wire_67_inG,
	CPU_wire_69_inG,CPU_wire_71_inG,CPU_wire_73_inG;

////////////////////////////////////output Good //////////////////////////////////
wire CPU_wire_83_outG,CPU_wire_84_outG,CPU_wire_85_outG,CPU_wire_87_outG,CPU_wire_89_outG,CPU_wire_90_outG,CPU_wire_91_outG,CPU_wire_93_outG,
CPU_wire_337_outG,CPU_wire_338_outG,CPU_wire_339_outG,CPU_wire_340_outG,CPU_wire_341_outG,CPU_wire_342_outG,CPU_wire_343_outG,CPU_wire_344_outG,
CPU_wire_346_outG,CPU_wire_347_outG,CPU_wire_348_outG,CPU_wire_349_outG,CPU_wire_350_outG,CPU_wire_351_outG,CPU_wire_352_outG,CPU_wire_353_outG,
CPU_wire_355_outG,CPU_wire_356_outG,CPU_wire_357_outG,CPU_wire_358_outG,CPU_wire_359_outG,CPU_wire_360_outG,CPU_wire_361_outG,CPU_wire_362_outG,
CPU_wire_364_outG,CPU_wire_365_outG,CPU_wire_366_outG,CPU_wire_367_outG,CPU_wire_368_outG,CPU_wire_369_outG,CPU_wire_370_outG,CPU_wire_371_outG,
CPU_wire_501_outG,CPU_wire_503_outG,CPU_wire_505_outG,CPU_wire_507_outG,CPU_wire_509_outG,CPU_wire_511_outG,CPU_wire_513_outG,CPU_wire_515_outG,
CPU_wire_619_outG,CPU_wire_622_outG,CPU_wire_625_outG,CPU_wire_628_outG,CPU_wire_631_outG,CPU_wire_634_outG,CPU_wire_637_outG,CPU_wire_640_outG;

//////////////////////////input Faulty ///////////////////////////////////////
reg CPU_wire_75_inF,CPU_wire_78_inF,CPU_wire_86_inF,CPU_wire_88_inF,CPU_wire_2_inF,CPU_wire_4_inF,CPU_wire_92_inF,CPU_wire_7_inF,
CPU_wire_126_inF,CPU_wire_142_inF,CPU_wire_158_inF,CPU_wire_174_inF,CPU_wire_190_inF,CPU_wire_206_inF,CPU_wire_222_inF,CPU_wire_238_inF,
CPU_wire_116_inF,CPU_wire_132_inF,CPU_wire_148_inF,CPU_wire_164_inF,CPU_wire_180_inF,CPU_wire_196_inF, CPU_wire_212_inF,CPU_wire_228_inF,
CPU_wire_123_inF,CPU_wire_139_inF,CPU_wire_155_inF,CPU_wire_171_inF,CPU_wire_187_inF,CPU_wire_203_inF,CPU_wire_219_inF,CPU_wire_235_inF,
CPU_wire_112_inF, CPU_wire_128_inF,CPU_wire_144_inF,CPU_wire_160_inF,CPU_wire_176_inF,CPU_wire_192_inF,CPU_wire_208_inF,CPU_wire_224_inF,
CPU_wire_10_inF,CPU_wire_12_inF,CPU_wire_14_inF,CPU_wire_16_inF,CPU_wire_18_inF,CPU_wire_20_inF,CPU_wire_22_inF,CPU_wire_24_inF,CPU_wire_58_inF,
CPU_wire_61_inF,CPU_wire_63_inF,CPU_wire_65_inF,CPU_wire_67_inF,CPU_wire_69_inF,CPU_wire_71_inF,CPU_wire_73_inF;

////////////////////////////////////// output Faulty /////////////////////////////////////////////////////////////////////
wire CPU_wire_83_outF,CPU_wire_84_outF,CPU_wire_85_outF,CPU_wire_87_outF,CPU_wire_89_outF,CPU_wire_90_outF,CPU_wire_91_outF,CPU_wire_93_outF,
CPU_wire_337_outF,CPU_wire_338_outF,CPU_wire_339_outF,CPU_wire_340_outF,CPU_wire_341_outF,CPU_wire_342_outF,CPU_wire_343_outF,CPU_wire_344_outF,
CPU_wire_346_outF,CPU_wire_347_outF,CPU_wire_348_outF,CPU_wire_349_outF,CPU_wire_350_outF,CPU_wire_351_outF,CPU_wire_352_outF,CPU_wire_353_outF,
CPU_wire_355_outF,CPU_wire_356_outF,CPU_wire_357_outF,CPU_wire_358_outF,CPU_wire_359_outF,CPU_wire_360_outF,CPU_wire_361_outF,CPU_wire_362_outF,
CPU_wire_364_outF,CPU_wire_365_outF,CPU_wire_366_outF,CPU_wire_367_outF,CPU_wire_368_outF,CPU_wire_369_outF,CPU_wire_370_outF,CPU_wire_371_outF,
CPU_wire_501_outF,CPU_wire_503_outF,CPU_wire_505_outF,CPU_wire_507_outF,CPU_wire_509_outF,CPU_wire_511_outF,CPU_wire_513_outF,CPU_wire_515_outF,
CPU_wire_619_outF,CPU_wire_622_outF,CPU_wire_625_outF,CPU_wire_628_outF,CPU_wire_631_outF,CPU_wire_634_outF,CPU_wire_637_outF,CPU_wire_640_outF;

	
	CPU_net GUT(inst,CPU_wire_75_inG,CPU_wire_78_inG,CPU_wire_86_inG,CPU_wire_88_inG,CPU_wire_2_inG,CPU_wire_4_inG,CPU_wire_92_inG,CPU_wire_7_inG,
CPU_wire_126_inG,CPU_wire_142_inG,CPU_wire_158_inG,CPU_wire_174_inG,CPU_wire_190_inG,CPU_wire_206_inG,CPU_wire_222_inG,CPU_wire_238_inG,CPU_wire_116_inG,
CPU_wire_132_inG,CPU_wire_148_inG,CPU_wire_164_inG,CPU_wire_180_inG,CPU_wire_196_inG, CPU_wire_212_inG,CPU_wire_228_inG,CPU_wire_123_inG,CPU_wire_139_inG,
CPU_wire_155_inG,CPU_wire_171_inG,CPU_wire_187_inG,CPU_wire_203_inG,CPU_wire_219_inG,CPU_wire_235_inG,CPU_wire_112_inG, CPU_wire_128_inG,CPU_wire_144_inG,
CPU_wire_160_inG,CPU_wire_176_inG,CPU_wire_192_inG,CPU_wire_208_inG,CPU_wire_224_inG,CPU_wire_10_inG,CPU_wire_12_inG,CPU_wire_14_inG,CPU_wire_16_inG,CPU_wire_18_inG,
CPU_wire_20_inG,CPU_wire_22_inG,CPU_wire_24_inG,CPU_wire_58_inG,CPU_wire_61_inG,CPU_wire_63_inG,CPU_wire_65_inG,CPU_wire_67_inG,
CPU_wire_69_inG,CPU_wire_71_inG,CPU_wire_73_inG, address_outG, out_data_outG, store_outG,
 CPU_wire_83_outG,CPU_wire_84_outG,CPU_wire_85_outG,CPU_wire_87_outG,CPU_wire_89_outG,CPU_wire_90_outG,CPU_wire_91_outG,CPU_wire_93_outG,
CPU_wire_337_outG,CPU_wire_338_outG,CPU_wire_339_outG,CPU_wire_340_outG,CPU_wire_341_outG,CPU_wire_342_outG,CPU_wire_343_outG,CPU_wire_344_outG,
CPU_wire_346_outG,CPU_wire_347_outG,CPU_wire_348_outG,CPU_wire_349_outG,CPU_wire_350_outG,CPU_wire_351_outG,CPU_wire_352_outG,CPU_wire_353_outG,
CPU_wire_355_outG,CPU_wire_356_outG,CPU_wire_357_outG,CPU_wire_358_outG,CPU_wire_359_outG,CPU_wire_360_outG,CPU_wire_361_outG,CPU_wire_362_outG,
CPU_wire_364_outG,CPU_wire_365_outG,CPU_wire_366_outG,CPU_wire_367_outG,CPU_wire_368_outG,CPU_wire_369_outG,CPU_wire_370_outG,CPU_wire_371_outG,
CPU_wire_501_outG,CPU_wire_503_outG,CPU_wire_505_outG,CPU_wire_507_outG,CPU_wire_509_outG,CPU_wire_511_outG,CPU_wire_513_outG,CPU_wire_515_outG,
CPU_wire_619_outG,CPU_wire_622_outG,CPU_wire_625_outG,CPU_wire_628_outG,CPU_wire_631_outG,CPU_wire_634_outG,CPU_wire_637_outG,CPU_wire_640_outG);
	
	CPU_net FUT(inst,CPU_wire_75_inF,CPU_wire_78_inF,CPU_wire_86_inF,CPU_wire_88_inF,CPU_wire_2_inF,CPU_wire_4_inF,CPU_wire_92_inF,CPU_wire_7_inF,
CPU_wire_126_inF,CPU_wire_142_inF,CPU_wire_158_inF,CPU_wire_174_inF,CPU_wire_190_inF,CPU_wire_206_inF,CPU_wire_222_inF,CPU_wire_238_inF,
CPU_wire_116_inF,CPU_wire_132_inF,CPU_wire_148_inF,CPU_wire_164_inF,CPU_wire_180_inF,CPU_wire_196_inF, CPU_wire_212_inF,CPU_wire_228_inF,
CPU_wire_123_inF,CPU_wire_139_inF,CPU_wire_155_inF,CPU_wire_171_inF,CPU_wire_187_inF,CPU_wire_203_inF,CPU_wire_219_inF,CPU_wire_235_inF,
CPU_wire_112_inF, CPU_wire_128_inF,CPU_wire_144_inF,CPU_wire_160_inF,CPU_wire_176_inF,CPU_wire_192_inF,CPU_wire_208_inF,CPU_wire_224_inF,
CPU_wire_10_inF,CPU_wire_12_inF,CPU_wire_14_inF,CPU_wire_16_inF,CPU_wire_18_inF,CPU_wire_20_inF,CPU_wire_22_inF,CPU_wire_24_inF,CPU_wire_58_inF,
CPU_wire_61_inF,CPU_wire_63_inF,CPU_wire_65_inF,CPU_wire_67_inF,CPU_wire_69_inF,CPU_wire_71_inF,CPU_wire_73_inF, address_outF, out_data_outF, store_outF,
CPU_wire_83_outF,CPU_wire_84_outF,CPU_wire_85_outF,CPU_wire_87_outF,CPU_wire_89_outF,CPU_wire_90_outF,CPU_wire_91_outF,CPU_wire_93_outF,
CPU_wire_337_outF,CPU_wire_338_outF,CPU_wire_339_outF,CPU_wire_340_outF,CPU_wire_341_outF,CPU_wire_342_outF,CPU_wire_343_outF,CPU_wire_344_outF,
CPU_wire_346_outF,CPU_wire_347_outF,CPU_wire_348_outF,CPU_wire_349_outF,CPU_wire_350_outF,CPU_wire_351_outF,CPU_wire_352_outF,CPU_wire_353_outF,
CPU_wire_355_outF,CPU_wire_356_outF,CPU_wire_357_outF,CPU_wire_358_outF,CPU_wire_359_outF,CPU_wire_360_outF,CPU_wire_361_outF,CPU_wire_362_outF,
CPU_wire_364_outF,CPU_wire_365_outF,CPU_wire_366_outF,CPU_wire_367_outF,CPU_wire_368_outF,CPU_wire_369_outF,CPU_wire_370_outF,CPU_wire_371_outF,
CPU_wire_501_outF,CPU_wire_503_outF,CPU_wire_505_outF,CPU_wire_507_outF,CPU_wire_509_outF,CPU_wire_511_outF,CPU_wire_513_outF,CPU_wire_515_outF,
CPU_wire_619_outF,CPU_wire_622_outF,CPU_wire_625_outF,CPU_wire_628_outF,CPU_wire_631_outF,CPU_wire_634_outF,CPU_wire_637_outF,CPU_wire_640_outF);
	
	
	
	initial begin
		uTests = 0; coverage = 0;
		faultIndex = 1; detectedListAT = 0;
		expFCountCT = initialExpFCount;
		testFile = $fopen("TestVector.tst", "w");
		
		#10;
		while(coverage < desiredCoverage && uTests < utLimit) begin
		
			detectedFaultsCT = 0; detectedListCT = 0; detectedFaultsAT =0;
			
			testVector = $random($time);
			uTests = uTests + 1;
			faultIndex = 1;
			#10;
			newDiscovered = 0;
			faultFile = $fopen("fault.flt", "r");
			while(!$feof(faultFile)) begin // Fault Injection loop
				status=$fscanf(faultFile,"%s s@%b\n",wireName,stuckAtVal);
				$InjectFault(wireName, stuckAtVal);
				
				{inst,CPU_wire_75_inG,CPU_wire_78_inG,CPU_wire_86_inG,CPU_wire_88_inG,CPU_wire_2_inG,CPU_wire_4_inG,CPU_wire_92_inG,CPU_wire_7_inG,
CPU_wire_126_inG,CPU_wire_142_inG,CPU_wire_158_inG,CPU_wire_174_inG,CPU_wire_190_inG,CPU_wire_206_inG,CPU_wire_222_inG,CPU_wire_238_inG,CPU_wire_116_inG,
CPU_wire_132_inG,CPU_wire_148_inG,CPU_wire_164_inG,CPU_wire_180_inG,CPU_wire_196_inG, CPU_wire_212_inG,CPU_wire_228_inG,CPU_wire_123_inG,CPU_wire_139_inG,
CPU_wire_155_inG,CPU_wire_171_inG,CPU_wire_187_inG,CPU_wire_203_inG,CPU_wire_219_inG,CPU_wire_235_inG,CPU_wire_112_inG, CPU_wire_128_inG,CPU_wire_144_inG,
CPU_wire_160_inG,CPU_wire_176_inG,CPU_wire_192_inG,CPU_wire_208_inG,CPU_wire_224_inG,CPU_wire_10_inG,CPU_wire_12_inG,CPU_wire_14_inG,CPU_wire_16_inG,CPU_wire_18_inG,
CPU_wire_20_inG,CPU_wire_22_inG,CPU_wire_24_inG,CPU_wire_58_inG,CPU_wire_61_inG,CPU_wire_63_inG,CPU_wire_65_inG,CPU_wire_67_inG,
CPU_wire_69_inG,CPU_wire_71_inG,CPU_wire_73_inG} = testVector;
				
				{inst,CPU_wire_75_inF,CPU_wire_78_inF,CPU_wire_86_inF,CPU_wire_88_inF,CPU_wire_2_inF,CPU_wire_4_inF,CPU_wire_92_inF,CPU_wire_7_inF,
CPU_wire_126_inF,CPU_wire_142_inF,CPU_wire_158_inF,CPU_wire_174_inF,CPU_wire_190_inF,CPU_wire_206_inF,CPU_wire_222_inF,CPU_wire_238_inF,
CPU_wire_116_inF,CPU_wire_132_inF,CPU_wire_148_inF,CPU_wire_164_inF,CPU_wire_180_inF,CPU_wire_196_inF, CPU_wire_212_inF,CPU_wire_228_inF,
CPU_wire_123_inF,CPU_wire_139_inF,CPU_wire_155_inF,CPU_wire_171_inF,CPU_wire_187_inF,CPU_wire_203_inF,CPU_wire_219_inF,CPU_wire_235_inF,
CPU_wire_112_inF, CPU_wire_128_inF,CPU_wire_144_inF,CPU_wire_160_inF,CPU_wire_176_inF,CPU_wire_192_inF,CPU_wire_208_inF,CPU_wire_224_inF,
CPU_wire_10_inF,CPU_wire_12_inF,CPU_wire_14_inF,CPU_wire_16_inF,CPU_wire_18_inF,CPU_wire_20_inF,CPU_wire_22_inF,CPU_wire_24_inF,CPU_wire_58_inF,
CPU_wire_61_inF,CPU_wire_63_inF,CPU_wire_65_inF,CPU_wire_67_inF,CPU_wire_69_inF,CPU_wire_71_inF,CPU_wire_73_inF} = testVector;
				
				#60;
				
				woG = {address_outG, out_data_outG, store_outG,
CPU_wire_83_outG,CPU_wire_84_outG,CPU_wire_85_outG,CPU_wire_87_outG,CPU_wire_89_outG,CPU_wire_90_outG,CPU_wire_91_outG,CPU_wire_93_outG,
CPU_wire_337_outG,CPU_wire_338_outG,CPU_wire_339_outG,CPU_wire_340_outG,CPU_wire_341_outG,CPU_wire_342_outG,CPU_wire_343_outG,CPU_wire_344_outG,
CPU_wire_346_outG,CPU_wire_347_outG,CPU_wire_348_outG,CPU_wire_349_outG,CPU_wire_350_outG,CPU_wire_351_outG,CPU_wire_352_outG,CPU_wire_353_outG,
CPU_wire_355_outG,CPU_wire_356_outG,CPU_wire_357_outG,CPU_wire_358_outG,CPU_wire_359_outG,CPU_wire_360_outG,CPU_wire_361_outG,CPU_wire_362_outG,
CPU_wire_364_outG,CPU_wire_365_outG,CPU_wire_366_outG,CPU_wire_367_outG,CPU_wire_368_outG,CPU_wire_369_outG,CPU_wire_370_outG,CPU_wire_371_outG,
CPU_wire_501_outG,CPU_wire_503_outG,CPU_wire_505_outG,CPU_wire_507_outG,CPU_wire_509_outG,CPU_wire_511_outG,CPU_wire_513_outG,CPU_wire_515_outG,
CPU_wire_619_outG,CPU_wire_622_outG,CPU_wire_625_outG,CPU_wire_628_outG,CPU_wire_631_outG,CPU_wire_634_outG,CPU_wire_637_outG,CPU_wire_640_outG};

				woF = {address_outF, out_data_outF, store_outF,
CPU_wire_83_outF,CPU_wire_84_outF,CPU_wire_85_outF,CPU_wire_87_outF,CPU_wire_89_outF,CPU_wire_90_outF,CPU_wire_91_outF,CPU_wire_93_outF,
CPU_wire_337_outF,CPU_wire_338_outF,CPU_wire_339_outF,CPU_wire_340_outF,CPU_wire_341_outF,CPU_wire_342_outF,CPU_wire_343_outF,CPU_wire_344_outF,
CPU_wire_346_outF,CPU_wire_347_outF,CPU_wire_348_outF,CPU_wire_349_outF,CPU_wire_350_outF,CPU_wire_351_outF,CPU_wire_352_outF,CPU_wire_353_outF,
CPU_wire_355_outF,CPU_wire_356_outF,CPU_wire_357_outF,CPU_wire_358_outF,CPU_wire_359_outF,CPU_wire_360_outF,CPU_wire_361_outF,CPU_wire_362_outF,
CPU_wire_364_outF,CPU_wire_365_outF,CPU_wire_366_outF,CPU_wire_367_outF,CPU_wire_368_outF,CPU_wire_369_outF,CPU_wire_370_outF,CPU_wire_371_outF,
CPU_wire_501_outF,CPU_wire_503_outF,CPU_wire_505_outF,CPU_wire_507_outF,CPU_wire_509_outF,CPU_wire_511_outF,CPU_wire_513_outF,CPU_wire_515_outF,
CPU_wire_619_outF,CPU_wire_622_outF,CPU_wire_625_outF,CPU_wire_628_outF,CPU_wire_631_outF,CPU_wire_634_outF,CPU_wire_637_outF,CPU_wire_640_outF};
				
				if(woG != woF) begin
					detectedFaultsCT = detectedFaultsCT + 1;
					detectedListCT[faultIndex] = 1'b1;
					if(detectedListAT[faultIndex] == 0)
					newDiscovered = newDiscovered + 1;
				end //end of if
				$RemoveFault(wireName);
				#20;
				faultIndex = faultIndex + 1;
			end//end of while(!feof(faultFile))
			
			$fclose(faultFile);
			
			detectedFaultsAT = 0;
			if(detectedFaultsCT < expFCountCT)
				tmp = expFCountCT / 2;
			else tmp = (detectedFaultsCT + expFCountCT) / 2;
			expFCountCT = tmp;
			
			if(detectedFaultsCT >= expFCountCT && (newDiscovered > 0))
				begin
					detectedFaultsAT = 0;
					
					for(faultIndex=1; faultIndex<=numOfFaults; faultIndex=faultIndex+1)
						if((detectedListAT[faultIndex]==1) || (detectedListCT[faultIndex]==1))
						begin
							detectedListAT[faultIndex] = 1'b1;
							detectedFaultsAT = detectedFaultsAT + 1;
						end
					coverage = 100 * detectedFaultsAT / numOfFaults;
					$fdisplay(testFile, "%b", testVector);
				end
			#10;
		end //end of while of Coverage
		$display("Number of Random Vectors Generated: %d", uTests);
		$display("Coverage : %d", coverage);
		
	end //end of initial
endmodule