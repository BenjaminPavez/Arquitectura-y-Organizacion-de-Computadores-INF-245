
@-----------------------------------------inputs-------------------------


@inputs funcion 1
.data
str1:   .asciz "mar"     @ Cadena 1
str2:   .asciz "rama"     @ Cadena 2
result: .word 0   

@inputs funcion 3
vector:     .word 1, 2, 3, 4, 5, 6, 7, 8, 9, 10
longitud:   .word 10
.text
.extern printInt

@inputs funcion 2
 mov R0,#2
 mov R1,#1

 mov R7, #3 @Eleccion de funcion a utilizar

 cmp R7,#1
 beq fun1
 cmp R7,#2
 beq Fun2
 cmp R7,#3
 beq fun3


@-------------------------------------------PARTE 1----------------------------

@ Carga la cadena 1 en r1
fun1:
    ldr r1, =str1         @ Carga la cadena 1 en r1
    ldr r2, =str2         @ Carga la cadena 2 en r2

@ Convierte los caracteres en la cadena 1 a minúsculas1
cambio1:
    ldrb r3, [r1]        
    cmp r3, #0x00        
    beq cambio2         
    cmp r3, #'a'        
    blt proxCaracter1   
    cmp r3, #'z'        
    bgt proxCaracter1   
    add r3, r3, #0x20   
    strb r3, [r1]

@ va al proximo caracre del string 1        
proxCaracter1:
    add r1, r1, #1      
    b cambio1          

@ Convierte los caracteres en la cadena 2 a minúsculas
cambio2:
    ldrb r4, [r2]       
    cmp r4, #0x00       
    beq comprobarCadenas   
    cmp r4, #'a'        
    blt proxCaracter2   
    cmp r4, #'z'        
    bgt proxCaracter2   
    add r4, r4, #0x20   
    strb r4, [r2]

@ va al proximo caracre del string 2    
proxCaracter2:
    add r2, r2, #1      
    b cambio2           

@ Comprueba cadenas
comprobarCadenas:
    ldr r1, =str1        
    ldr r2, =str2        

    ldrb r3, [r1]       

@ Ciclo while
while1:
    cmp r3, #0x00      
    beq comprobarCadena2   
    ldr r5, =str2       
    ldrb r4, [r5]       

@ Ciclo while
while2:
    cmp r4, #0x20       
    bne continuar       
    add r5, r5, #1      
    ldrb r4, [r5]       
    cmp r4, #0x00       
    bne while2       
    ldr r0, =1         
    b detener           

continuar:

@ Ciclo while
while3:
    cmp r4, #0x00       
    beq anagramaFalso   
    sub r7, r3, r4      
    cmp r7, #0x00       
    bne sinoB           
    ldr r4, =0x20       
    strb r4, [r5]
    add r1, r1, #1      
    ldrb r3, [r1]       
    b while1            


sinoB:
    add r5, r5, #1      
    ldrb r4, [r5]       
    b while3            

@ Comprueba
comprobarCadena2:
    ldr r2, =str2        

@ Ciclo while que recorre la cadena 2
whileComprobarCadena2:
    ldrb r1, [r2]       
    cmp r1, #0x00       
    beq anagramaVerdadero   
    cmp r1, #0x20       
    bne anagramaFalso   
    add r2, r2, #1     
    b whileComprobarCadena2   

@ Se concluye que los dos strings no son anagramas
anagramaFalso:
    ldr r0, =0          
    ldr r2, =0          
    bl printInt         
    b detener           

@ Se concluye que los dos strings son anagramas
anagramaVerdadero:
    ldr r0, =1          
    ldr r2, =1          
    bl printInt         
    wfi                 

@ Se detiene la funcion
detener:
    ldr r2, =0          
    bl printInt         
    wfi

@-------------------------------------------PARTE 2----------------------------
Fun2:
 MOV R2, R1
 MOV R1, R0
 MOV R0, #0
 BL FUN
 B stop2

FUN:
 PUSH {LR} @Guarda cuando se llama la función
 cmp R1, R2
 BLT C1
 BEQ C2
 cmp R2, #0
 BEQ C2

ELSE:@SUMA

 SUB R1, R1,#1
 PUSH {R0} @Guarda los valores para poder utilizarlos cuando se salga de la recursion
 PUSH {R1}
 PUSH {R2}
 BL FUN @Entra a la primera Recursion

 MOV R3, R0 @Almacena los retornos
 POP {R2} @Se accede a los valores guardados
 POP {R1}
 POP {R0}
 ADD R0, R3, R0
 PUSH {R0}
 MOV R0, #0
 MOV R3, #0
 SUB R2,R2,#1
 BL FUN @Segunda Recursion
 
 MOV R3,R0 
 POP {R0}
 ADD R0, R3
 MOV R3, #0
 POP {PC}
 
C1:
 MOV R0,#0
 POP {PC}  @ Pop R14 only

C2:
 MOV R0,#1
 POP {PC}   @ Pop R14 only



stop2:
   mov r2, r0
   mov r0,#0
   mov r0,#0
   bl printInt
   wfi


@-------------------------------------------PARTE 3----------------------------
fun3:
    ldr r3, =vector       @ Cargar la dirección del vector en r3
    ldr r4, =longitud     @ Cargar la dirección de la longitud en r4
    ldrb r4, [r4]          @ Cargar la longitud del vector en r4
    mov r0, #0            @ Inicializar índice del vector en r0

for_loop:
    lsl r2, r0, #2        @ Calcular el desplazamiento multiplicando el índice por 4 (tamaño de cada elemento)
    add r2, r2, r3        @ Calcular la dirección del elemento del vector sumando el desplazamiento al puntero base
    ldrb r1, [r2]          @ Cargar el elemento del vector en r1
    lsl r1, r1, #31       @ Desplazar el número 31 bits a la izquierda
    cmp r1, #0            @ Comparar el resultado con cero
    beq next_iteration      @
    b print_number       @

print_number:
    add r0, r0, #1        @ IMPAR Incrementar el índice del vector
    cmp r0, r4            @ Comparar el índice con la longitud del vector
    blt for_loop          @ Volver al bucle si no se ha recorrido todo el vector
    b imprimir
next_iteration:
    add r5, r5,#1
    ldrb r1, [r2]          @ Cargar el elemento del vector en r1
    PUSH {r1}
    add r0, r0, #1        @ PAR Incrementar el índice del vector
    cmp r0, r4            @ Comparar el índice con la longitud del vector
    blt for_loop          @ Volver al bucle si no se ha recorrido todo el vector
    b imprimir



imprimir:
    mov r1, #0 @ Movemos el eje y a cero (puedes ajustar esto segun tus necesidades)
    mov r0, #0
    mov R2, R5
    bl printInt @ Imprimimos la cantidad de numeros pares

loop_print:
    mov r0,#2
    add r1,r5, #0
    cmp R5, #0
    beq FINAL
    POP {R2}
    bl printInt
    sub r5,#1
    b loop_print
    
    



FINAL:    wfi
