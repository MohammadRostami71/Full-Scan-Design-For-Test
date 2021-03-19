`timescale 1 ns / 1ns

module Tester;


	reg [0:7]inst;
	wire [0:7] address_outF;
	wire [0:7] out_data_outF;
	wire store_outF;
//////////////////////////output Faulty ///////////////////////////////////////
wire CPU_wire_75_outF,CPU_wire_78_outF,CPU_wire_86_outF,CPU_wire_88_outF,CPU_wire_2_outF,CPU_wire_4_outF,CPU_wire_92_outF,CPU_wire_7_outF,
CPU_wire_126_outF,CPU_wire_142_outF,CPU_wire_158_outF,CPU_wire_174_outF,CPU_wire_190_outF,CPU_wire_206_outF,CPU_wire_222_outF,CPU_wire_238_outF,
CPU_wire_116_outF,CPU_wire_132_outF,CPU_wire_148_outF,CPU_wire_164_outF,CPU_wire_180_outF,CPU_wire_196_outF, CPU_wire_212_outF,CPU_wire_228_outF,
CPU_wire_123_outF,CPU_wire_139_outF,CPU_wire_155_outF,CPU_wire_171_outF,CPU_wire_187_outF,CPU_wire_203_outF,CPU_wire_219_outF,CPU_wire_235_outF,
CPU_wire_112_outF, CPU_wire_128_outF,CPU_wire_144_outF,CPU_wire_160_outF,CPU_wire_176_outF,CPU_wire_192_outF,CPU_wire_208_outF,CPU_wire_224_outF,
CPU_wire_10_outF,CPU_wire_12_outF,CPU_wire_14_outF,CPU_wire_16_outF,CPU_wire_18_outF,CPU_wire_20_outF,CPU_wire_22_outF,CPU_wire_24_outF,CPU_wire_58_outF,
CPU_wire_61_outF,CPU_wire_63_outF,CPU_wire_65_outF,CPU_wire_67_outF,CPU_wire_69_outF,CPU_wire_71_outF,CPU_wire_73_outF;

////////////////////////////////////// input Faulty /////////////////////////////////////////////////////////////////////
reg CPU_wire_83_inF,CPU_wire_84_inF,CPU_wire_85_inF,CPU_wire_87_inF,CPU_wire_89_inF,CPU_wire_90_inF,CPU_wire_91_inF,CPU_wire_93_inF,
CPU_wire_337_inF,CPU_wire_338_inF,CPU_wire_339_inF,CPU_wire_340_inF,CPU_wire_341_inF,CPU_wire_342_inF,CPU_wire_343_inF,CPU_wire_344_inF,
CPU_wire_346_inF,CPU_wire_347_inF,CPU_wire_348_inF,CPU_wire_349_inF,CPU_wire_350_inF,CPU_wire_351_inF,CPU_wire_352_inF,CPU_wire_353_inF,
CPU_wire_355_inF,CPU_wire_356_inF,CPU_wire_357_inF,CPU_wire_358_inF,CPU_wire_359_inF,CPU_wire_360_inF,CPU_wire_361_inF,CPU_wire_362_inF,
CPU_wire_364_inF,CPU_wire_365_inF,CPU_wire_366_inF,CPU_wire_367_inF,CPU_wire_368_inF,CPU_wire_369_inF,CPU_wire_370_inF,CPU_wire_371_inF,
CPU_wire_501_inF,CPU_wire_503_inF,CPU_wire_505_inF,CPU_wire_507_inF,CPU_wire_509_inF,CPU_wire_511_inF,CPU_wire_513_inF,CPU_wire_515_inF,
CPU_wire_619_inF,CPU_wire_622_inF,CPU_wire_625_inF,CPU_wire_628_inF,CPU_wire_631_inF,CPU_wire_634_inF,CPU_wire_637_inF,CPU_wire_640_inF;

	CPU_net FUT(inst,address_outF,out_data_outF,store_outF, CPU_wire_83_inF,CPU_wire_84_inF,CPU_wire_85_inF,CPU_wire_87_inF,CPU_wire_89_inF,CPU_wire_90_inF,CPU_wire_91_inF,CPU_wire_93_inF,
CPU_wire_337_inF,CPU_wire_338_inF,CPU_wire_339_inF,CPU_wire_340_inF,CPU_wire_341_inF,CPU_wire_342_inF,CPU_wire_343_inF,CPU_wire_344_inF,
CPU_wire_346_inF,CPU_wire_347_inF,CPU_wire_348_inF,CPU_wire_349_inF,CPU_wire_350_inF,CPU_wire_351_inF,CPU_wire_352_inF,CPU_wire_353_inF,
CPU_wire_355_inF,CPU_wire_356_inF,CPU_wire_357_inF,CPU_wire_358_inF,CPU_wire_359_inF,CPU_wire_360_inF,CPU_wire_361_inF,CPU_wire_362_inF,
CPU_wire_364_inF,CPU_wire_365_inF,CPU_wire_366_inF,CPU_wire_367_inF,CPU_wire_368_inF,CPU_wire_369_inF,CPU_wire_370_inF,CPU_wire_371_inF,
CPU_wire_501_inF,CPU_wire_503_inF,CPU_wire_505_inF,CPU_wire_507_inF,CPU_wire_509_inF,CPU_wire_511_inF,CPU_wire_513_inF,CPU_wire_515_inF,
CPU_wire_619_inF,CPU_wire_622_inF,CPU_wire_625_inF,CPU_wire_628_inF,CPU_wire_631_inF,CPU_wire_634_inF,CPU_wire_637_inF,CPU_wire_640_inF

	,CPU_wire_75_outF,CPU_wire_78_outF,CPU_wire_86_outF,CPU_wire_88_outF,CPU_wire_2_outF,CPU_wire_4_outF,CPU_wire_92_outF,CPU_wire_7_outF,
CPU_wire_126_outF,CPU_wire_142_outF,CPU_wire_158_outF,CPU_wire_174_outF,CPU_wire_190_outF,CPU_wire_206_outF,CPU_wire_222_outF,CPU_wire_238_outF,
CPU_wire_116_outF,CPU_wire_132_outF,CPU_wire_148_outF,CPU_wire_164_outF,CPU_wire_180_outF,CPU_wire_196_outF, CPU_wire_212_outF,CPU_wire_228_outF,
CPU_wire_123_outF,CPU_wire_139_outF,CPU_wire_155_outF,CPU_wire_171_outF,CPU_wire_187_outF,CPU_wire_203_outF,CPU_wire_219_outF,CPU_wire_235_outF,
CPU_wire_112_outF, CPU_wire_128_outF,CPU_wire_144_outF,CPU_wire_160_outF,CPU_wire_176_outF,CPU_wire_192_outF,CPU_wire_208_outF,CPU_wire_224_outF,
CPU_wire_10_outF,CPU_wire_12_outF,CPU_wire_14_outF,CPU_wire_16_outF,CPU_wire_18_outF,CPU_wire_20_outF,CPU_wire_22_outF,CPU_wire_24_outF,CPU_wire_58_outF,
CPU_wire_61_outF,CPU_wire_63_outF,CPU_wire_65_outF,CPU_wire_67_outF,CPU_wire_69_outF,CPU_wire_71_outF,CPU_wire_73_outF);

	initial begin
		$FaultCollapsing(Tester.FUT, "fault.flt");
		#10;
	end

endmodule