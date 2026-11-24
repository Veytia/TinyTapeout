module ComSum
(
	input DA,DB,DC,
	output S,C
);

wire SS,Aor,Bor;

SemiSum u0 (
	.A(DA),
	.B(DB),
	.S(SS),
	.C(Aor)
);
SemiSum u1 (
	.A(SS),
	.B(DC),
	.S(S),
	.C(Bor)
);

	assign C = Aor | Bor;
	
endmodule
