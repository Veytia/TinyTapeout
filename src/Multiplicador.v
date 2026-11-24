module Multiplicador #(
    parameter NBits = 4
) (
    input  wire [NBits-1:0]       A,
    input  wire [NBits-1:0]       B,
    output wire [(NBits*2)-1:0]   P
);

    // Definición de matrices internas (equivalentes a los tipos array en VHDL)
    // C: matriz de NBits filas por (NBits + 1) columnas
    // FAq: matriz de NBits filas por (NBits + 1) columnas
    wire [NBits:0] C [0:NBits-1];
    wire [NBits:0] FAq [0:NBits-1];

    // C(0) <= (others=>'0')
    assign C[0] = {(NBits+1){1'b0}};

    // Primera_Fila
    genvar j, i;
    generate
        for (j = 0; j < NBits; j = j + 1) begin : primera_fila_gen
            assign C[0][j] = 1'b0;
            assign FAq[0][j] = A[j] & B[0];
        end
    endgenerate

    assign FAq[0][NBits] = 1'b0;

    // Filas_B y Columnas_A
    generate
        for (i = 1; i < NBits; i = i + 1) begin : filas_b_gen
            // C(i)(0) debe estar conectado a tierra (0) según la lógica implícita de la primera columna
            // En VHDL no se asigna explícitamente pero en la celda inicial entra Cin = C(i)(0) que vale 0.
            assign C[i][0] = 1'b0;

            for (j = 0; j < NBits; j = j + 1) begin : columnas_a_gen
                SBMultiplicador Multi (
                    .A    (A[j]),
                    .B    (B[i]),
                    .D    (FAq[i-1][j+1]),
                    .Cin  (C[i][j]),
                    .Cout (C[i][j+1]),
                    .S    (FAq[i][j])
                );
            end
            assign FAq[i][NBits] = C[i][NBits];
        end
    endgenerate

    // Salida
    generate
        for (i = 0; i < NBits; i = i + 1) begin : salida_gen
            assign P[i] = FAq[i][0];
            assign P[i + NBits] = FAq[NBits-1][i+1];
        end
    endgenerate
	 
endmodule