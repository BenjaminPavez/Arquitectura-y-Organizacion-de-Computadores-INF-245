// Modulo counter
// El modulo representa a un contador para la memoria ROM
// Entradas:
//          m: Entrada que representa el numero al que debe llegar el contador
//          reset: Entrada que representa al reset
//          clk: Entrada que representa al reloj           
// Salidas:
//          count: Registro de 6 bits que almacena el conteo
module counter(
  input m,
  input reset,
  input clk,
  output logic [5:0] count
);
  always @(posedge clk)
  begin
    if (reset)
      count <= 6'b000000;
    else if (m)
      count <= count + 1;
    else
      count <= count - 1;
  end
endmodule




// Modulo ROM
// El modulo almacena instrucciones en hexadecimal que ya esta cargadas
// Entradas:
//          contador: Registro de 6 bits que almacena el conteo        
// Salidas:
//          outinstruction: Registro de 19 bits que almacena la instruccion en binario
//          instruction: Registro de 19 bits que almacena la instruccion en binario
module ROM(
  input [5:0] contador,
  output reg [18:0] outinstruction,
  output reg [18:0] instruction
);

  reg [18:0] memoria [0:63]; // cada registro ocupa 19 bits en hexadecimal, y la ROM es de 64 bits
  initial begin
    // Se cargan las instrucciones en hexadecimal a la ROM
    memoria[0] = 19'h01713;
    memoria[1] = 19'h1034C;
    memoria[2] = 19'h21F05;
    memoria[3] = 19'h31F02;
    memoria[4] = 19'h45D52;
    memoria[5] = 19'h55D52;
    memoria[6] = 19'h65D52;
    memoria[7] = 19'h75D52;
    memoria[8] = 19'h01713;
    memoria[9] = 19'h75D52;
    memoria[10] = 19'h75D52;
    memoria[11] = 19'h75D52;
    memoria[12] = 19'h75D52;
    memoria[13] = 19'h75D52;
    memoria[14] = 19'h75D52;
    memoria[15] = 19'h75D52;
    memoria[16] = 19'h75D52;
    memoria[17] = 19'h75D52;
    memoria[18] = 19'h75D52;
    memoria[19] = 19'h75D52;
    memoria[20] = 19'h75D52;
    memoria[21] = 19'h75D52;
    memoria[22] = 19'h75D52;
    memoria[23] = 19'h75D52;
    memoria[24] = 19'h75D52;
    memoria[25] = 19'h75D52;
    memoria[26] = 19'h75D52;
    memoria[27] = 19'h75D52;
    memoria[28] = 19'h75D52;
    memoria[29] = 19'h75D52;
    memoria[30] = 19'h75D52;
    memoria[31] = 19'h75D52;
    memoria[32] = 19'h75D52;
    memoria[33] = 19'h75D52;
    memoria[34] = 19'h75D52;
    memoria[35] = 19'h75D52;
    memoria[36] = 19'h75D52;
    memoria[37] = 19'h75D52;
    memoria[38] = 19'h75D52;
    memoria[39] = 19'h75D52;
    memoria[40] = 19'h75D52;
    memoria[41] = 19'h75D52;
    memoria[42] = 19'h75D52;
    memoria[43] = 19'h75D52;
    memoria[44] = 19'h75D52;
    memoria[45] = 19'h75D52;
    memoria[46] = 19'h75D52;
    memoria[47] = 19'h75D52;
    memoria[48] = 19'h75D52;
    memoria[49] = 19'h75D52;
    memoria[50] = 19'h75D52;
    memoria[51] = 19'h75D52;
    memoria[52] = 19'h75D52;
    memoria[53] = 19'h75D52;
    memoria[54] = 19'h75D52;
    memoria[55] = 19'h75D52;
    memoria[56] = 19'h75D52;
    memoria[57] = 19'h75D52;
    memoria[58] = 19'h75D52;
    memoria[59] = 19'h75D52;
    memoria[60] = 19'h75D52;
    memoria[61] = 19'h75D52;
    memoria[62] = 19'h75D52;
    memoria[63] = 19'h00000;
    
  end

  assign instruction = memoria[contador];
  assign outinstruction = memoria[contador];
endmodule




// Modulo Splitter
// El modulo a partir de una entrada de 19 bits la separa en la operacion a realizar junto con los numeros a utilizar
// Entradas:
//          En: Registro de 19 bits que almacena la instruccion en binario         
// Salidas:
//          Op: Registro de 3 bits que almacena la Operacion a realizar
//          NumA: Registro de 8 bits que almacena el Inmediato A 
//          NumB: Registro de 8 bits que almacena el Inmediato B
//          Op2: Registro de 3 bits que almacena la Operacion a realizar
//          NumA2: Registro de 8 bits que almacena el Inmediato A
//          NumB2: Registro de 8 bits que almacena el Inmediato B
module Splitter(
  input [18:0] En,
  output reg [2:0] Op,
  output reg [7:0] NumA,
  output reg [7:0] NumB,
  output reg [2:0] Op2,
  output reg [7:0] NumA2,
  output reg [7:0] NumB2,
);
  assign Op = En[18:16];
  assign NumA = En[16:8];
  assign NumB = En[8:0];
  assign Op2 = Op;
  assign NumA2 = NumA;
  assign NumB2 = NumB;
endmodule




// Modulo ALU
// El modulo a partir de la separacion del Splitter, realiza la operacion con los numeros A y B
// Entradas:
//          A: Registro de 8 bits que almacena el Inmediato A
//          B: Registro de 8 bits que almacena el Inmediato B
//          operacion: Registro de 3 bits que almacena la Operacion a realizar         
// Salidas:
//          resultado: Registro de 8 bits que almacena el resultado de la Operacion
module ALU(
  input [7:0] A,
  input [7:0] B,
  input [2:0] operacion,
  output reg [7:0] resultado
);
  
  // Suma con Prefix Adder
  logic [7:0] carrysum;
  logic [7:0] sum;
  
  assign carrysum[0] = 1'b0;
  
  generate
    genvar i;
    for (i = 0; i < 8; i++) begin : stages_suma
      assign sum[i] = A[i] ^ B[i] ^ carrysum[i];
      assign carrysum[i+1] = (A[i] & B[i]) | (A[i] & carrysum[i]) | (B[i] & carrysum[i]);
    end
  endgenerate
  
  // Resta con Prefix Adder
  logic [7:0] carryres;
  logic [7:0] res;
  logic [7:0] comple2;
  
  assign comple2 = ~B + 1'b1;
  assign carryres[0] = 1'b0;
  
  generate
    genvar j;
    for (j = 0; j < 8; j++) begin : stages_resta
      assign res[j] = A[j] ^ comple2[j] ^ carryres[j];
      assign carryres[j+1] = (A[j] & comple2[j]) | (A[j] & carryres[j]) | (comple2[j] & carryres[j]);
    end
  endgenerate
  
  always @* begin
    case (operacion)
      3'b000: resultado = sum;
      3'b001: resultado = res;
      3'b010: resultado = A << B;
      3'b011: resultado = A >> B;
      3'b100: resultado = A & B;
      3'b101: resultado = A | B;
      3'b110: resultado = A ^ B;
      3'b111: resultado = ~A;
      default: resultado = 0;
    endcase
  end
endmodule




// Modulo Resultado
// El modulo se encarga de almacenar los registros para posteriormente inprimirlos por pantalla
// Entradas:
//          A: Registro de 8 bits que almacena el Inmediato A
//          B: Registro de 8 bits que almacena el Inmediato B
//          inOp: Registro de 3 bits que almacena la Operacion a realizar
//          inres: Registro de 8 bits que almacena el resultado de la Operacion        
// Salidas:
//          Op: Registro de 3 bits que almacena la Operacion a realizar
//          NumA: Registro de 8 bits que almacena el Inmediato A
//          NumB: Registro de 8 bits que almacena el Inmediato B
//          resultado: Registro de 8 bits que almacena el resultado de la Operacion
module Resultado(
  input [7:0] A,
  input [7:0] B,
  input [2:0] inOp,
  input [7:0] inres,
  output reg [2:0] Op,
  output reg [7:0] NumA,
  output reg [7:0] NumB,
  output reg [7:0] resultado
);
  assign Op = inOp;
  assign NumA = A;
  assign NumB = B;
  assign resultado = inres;
endmodule




// Modulo main
// El modulo representa a un BUS que conecta todos los modulos para el funcionamiento
// Entradas:
//          clk: Entrada que representa al reloj
//          reset: Entrada que representa al reset
//          m: Entrada que representa el numero al que debe llegar el contador       
// Salidas:
//          outOp: Registro de 3 bits que almacena la Operacion a realizar
//          outA: Registro de 8 bits que almacena el Inmediato A
//          outB: Registro de 8 bits que almacena el Inmediato B
//          instruccion: Registro de 19 bits que almacena la instruccion en binario 
//          resultado: Registro de 8 bits que almacena el resultado de la Operacion
module main(
  input clk,
  input reset,
  input m,
  output reg [2:0] outOp,
  output reg [7:0] outA,
  output reg [7:0] outB,
  output reg [18:0] instruccion,
  output reg [7:0] resultado
);
  wire [5:0] c;
  wire [18:0] ins;
  wire [2:0] inOp;
  wire [7:0] inA;
  wire [7:0] inB;
  wire [2:0] inOp2;
  wire [7:0] inA2;
  wire [7:0] inB2;
  wire [7:0] resu;

  // Se instancia al modulo counter
  counter c1(
    .m(m),
    .reset(reset),
    .clk(clk),
    .count(c)
  );
  // Se instancia al modulo ROM
  ROM R(
    .contador(c),
    .instruction(ins),
    .outinstruction(instruccion)
  );
  // Se instancia al modulo Splitter
  Splitter split(
    .En(ins),
    .Op(inOp),
    .NumA(inA),
    .NumB(inB),
    .Op2(inOp2),
    .NumA2(inA2),
    .NumB2(inB2)
  );
  // Se instancia al modulo ALU
  ALU ALL(
    .A(inA),
    .B(inB),
    .operacion(inOp),
    .resultado(resu)
  );
  // Se instancia al modulo Resultado
  Resultado RES(
    .A(inA2),
    .B(inB2),
    .inOp(inOp2),
    .inres(resu),
    .Op(outOp),
    .NumA(outA),
    .NumB(outB),
    .resultado(resultado)
  );
endmodule