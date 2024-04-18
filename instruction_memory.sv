module imem
	(
	input logic  [11:0] a,
	output logic [11:0] rd
	);	
	
	(* ram_init_file = "memoria.mif" *) logic [11:0] RAM[63:0];
	assign rd = RAM[a[11:2]]; // word aligned
endmodule
