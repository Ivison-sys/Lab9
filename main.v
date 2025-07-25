module ritmo(
    input key,
	input rst,
    input clk,
    output reg ledR, 
    output reg ledIni,
    output reg ledG
);
reg oldKey;
reg flag;
reg validMov, valid_conj;
parameter temp = 25_000_000;
parameter estado1 = 0, estado2 = 1, estado3 = 2, estado4 = 3, green = 4,  red = 5;
reg [2:0] state;
reg [32:0] contador;

initial begin
    state = estado1;
    flag = 0;
    contador = 0;
    validMov = 1;
    valid_conj = 1;
end

// Aqui eu analiso o pulso de 0 oara 1, quanodo há um pulso flag recebe 1;
always @(posedge clk) begin
	 oldKey <= key;
    flag <= (~oldKey && key);
end



// Parte condicional
always @(*) begin
    case(state)
        estado1: begin ledIni = 1; ledG = 0; ledR = 0; end
        estado2: begin ledIni = 0; ledG = 0; ledR = 0; end
        estado3: begin ledIni = 0; ledG = 0; ledR = 0; end
        estado4: begin ledIni = 0; ledG = 0; ledR = 0; end
        red: begin ledIni = 0; ledG = 0; ledR = 1; end
        green: begin ledIni = 0; ledG = 1; ledR = 0; end
    endcase
end

always @(posedge clk) begin

	 
    if(key == 0) begin
        contador <= contador + 1;
    end

    if(flag == 1) begin
        case(state)
            estado1: begin 
                valid_conj = 1;
                if(contador < temp) begin
                    state <= estado2;
                end else begin 
                    state <= red;
                end

            end
            estado2: begin 
                if(contador < temp) begin
							state <= estado3;
                end else begin 
                    state <= red;
                end
            end
            estado3: begin 
                if(contador >= temp) begin
                    state <= estado4;
                end else begin 
                    state <= red;
                end
            end
            estado4: begin 
                if(contador < temp) begin
                    state <= green;
                end else begin 
                   state <= red;
                end        
            end
            green: begin state = estado1; end
            red: begin state = estado1; end
            
        endcase
		  contador <= 0;
    end
  
end

endmodule