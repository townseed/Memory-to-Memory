// Copyright (C) 2018  Intel Corporation. All rights reserved.
// Your use of Intel Corporation's design tools, logic functions 
// and other software and tools, and its AMPP partner logic 
// functions, and any output files from any of the foregoing 
// (including device programming or simulation files), and any 
// associated documentation or information are expressly subject 
// to the terms and conditions of the Intel Program License 
// Subscription Agreement, the Intel Quartus Prime License Agreement,
// the Intel FPGA IP License Agreement, or other applicable license
// agreement, including, without limitation, that your use is for
// the sole purpose of programming logic devices manufactured by
// Intel and sold by Intel or its authorized distributors.  Please
// refer to the applicable agreement for further details.


// Generated by Quartus Prime Version 18.1 (Build Build 625 09/12/2018)
// Created on Thu Oct 19 04:24:27 2023

memory memory_inst
(
	.CLK(CLK_sig) ,	// input  CLK_sig
	.memWrite(memWrite_sig) ,	// input  memWrite_sig
	.inputAddress(inputAddress_sig) ,	// input [15:0] inputAddress_sig
	.inputValue(inputValue_sig) ,	// input [15:0] inputValue_sig
	.outputValue(outputValue_sig) 	// output [15:0] outputValue_sig
);

defparam memory_inst.RAM_DEPTH = 65536;