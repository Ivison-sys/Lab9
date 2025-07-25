module ritmo(
    input key;
    output reg red, green;
);
reg oldKey;
reg flag;
parameter temp = 25_000_000;
parameter estado1 = 0, estado2 = 1, estado3 = 2, estado4 = 3, ledG = 4,  ledR = 5, inicio = 6;
reg [2:0] state;
reg [32:0] contador;

initial begin
    state = inicio;
    flag = 0;
end

// Aqui eu analiso o pulso de 0 oara 1, quanodo há um pulso flag recebe 1;
always @(posedge clk) begin
    oldRst <= rst;
    flag <= (~oldRst && rst);
end

// Parte condicional
always @(*) begin

end

endmodule