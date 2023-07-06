Nombres, Roles USM y Paralelo: Benjamin Alejandro Pavez Ortiz,  202173628-K,  200
                               Vicente Gabriel Illanes Ayala,   202173651-4,  200

SO: Windows 11

Version Logisim: 2.7.1

Instrucciones de uso:

1) El programa funciona sin problemas con el ejemplo del pdf

2) El Circuito_1 recibe de entrada 3 bits para el eje X y 3 bits para el eje Y, el circuito retorna 4 bits que representa la direccion que tomar para el siguiente punto

3) El Circuito_2 recibe de entrada 3 bits para el eje X , 3 bits para el eje Y , 4 bits para la direccion, el circuito retorna 3 bits para el eje X y 3 bits para el eje Y que representa el       proximo punto valido

4) Las memorías utilizadas en esta tarea fueron implementadas por nosotros, y son el Sr Latch, D Latch, D Flip-Flop y luego se adicionaron 2 más las cuales la unica diferencia que tienen  son el poder guardar más bits en ellas repitiendo estructuras.

5) Las distintas partes del circuito main son (de izquierda a derecha) los inputs del estado inicial, dos mux sincronizados con un reloj dedicado, Circuito_1 (Estado-Direccion),
Flip-Flops con su reloj dedicado, Estado+Dire-N_Estado(Circuito_2), por ultimo los outpus de Estado siguiente y Direccion para llegar a ellos. Ignorando los
inputs y los outpus, los mux la unica función que tienen es bloquear el estado inicial despues de los primeros 2 ticks. Luego el Circuito_1 recibe un estado para 
devolver la direccion del siguiente estado. Tanto el estado actual como la direccion se guardan en los Flip-Flops en el transcurso de 1 tick, por ultimo 
el estado actual como la direccion ingresan como inputs al Circuito_2 para que este devuelva el estado siguiente. Tanto la direccion como el estado nuevo son
entregados a los outputs, y el estado nuevo pasa por los mux e ingresa al Circuito_1.

6) El primer reloj, ubicado abajo a la izquierda del circuito main, tiene 2 ticks para el voltaje bajo y 28 ticks para el voltaje alto, el segundo tiene 1 tick para el 
voltaje alto y para el bajo. Esto se hizo para que despues de los primeros 2 ticks los mux bloqueen el estado inicial y no sigan ingresando al circuito como inputs.
y se le dan 28 segundo al bloqueo ya que el maximo de pasos para llegar a la salida son 14, asi que quedan 14x2 ticks para relizar esos 14 pasos.

7) En base a lo anterior si usted ingresa un estado que necesita menos de 14 pasos para llegar a la salida, el circuito seguira arrojando valores despues de 
la cantidad de pasos que ingreso.

