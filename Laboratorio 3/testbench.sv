// Modulo de pruebas
// El modulo realiza una prueba sobre los modulos que estan en el design
module v_v_testbench;
  //Variables ROM y Contador
  reg clk;
  reg m, reset;
  reg [7:0] A, B, RES;
  reg [2:0] Op;
  reg [18:0] ins;
  
  //Se instancia un modulo
  //Instancia v_v
  main p_v (
    .m(m),
    .clk(clk),
    .reset(reset),
    .outA(A),
    .outB(B),
    .outOp(Op),
    .resultado(RES),
    .instruccion(ins)
  );


  //Reloj
  initial clk = 0;
  always #3 clk = ~clk;
  
  always @(posedge clk)
      begin
        $display("<%h> <%b> <%b> <%b> <%b>", ins, Op, A, B, RES);
      end
  //Reset
  initial begin
    $dumpfile("dump.vcd");
    $dumpvars(1, p_v);
    reset = 1;
    m = 1;
    #4
    reset = 0;
    m = 1;
    $display("----------------inicio----------------");
    #7
    m = 1;
    
    //#42 $finish;
    #378 $finish;
  end
  
endmodule