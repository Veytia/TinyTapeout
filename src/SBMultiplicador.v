module SBMultiplicador
(
	input  A,B,D,Cin,
	output Cout,S
);

wire y;

ComSum u0 (
	.DA(y),
	.DB(D),
	.DC(Cin),
	.S(S),
	.C(Cout)
);

	assign y = A & B;
	
endmodule
