Nombres, Roles USM y Paralelo: Benjamin Alejandro Pavez Ortiz,  202173628-K,  200
                               Vicente Gabriel Illanes Ayala,   202173651-4,  200

SO: Windows 10

IDE: Visual Studio Code

Version interprete de Python: 3.10.6 64-bit

Desarrollo:

Funcion ConversorBase: La funcion verifica si un numero puede ser representado en la base dada, si lo es retorna el binario, si no retorna False
Funcion SignExtension: La funcion verifica si hay que extender el signo de los binarios del archivo, si es asi, lo extiende
Funcion SumComplemento2: La funcion permite sumar dos elementos binarios que ya esten en Complemento 2
Funcion LectorArchivo: La funcion permite leer el archivo, separar los datos y procesa la informacion
Funcion Principal: La funcion permite almacenar el tamaño el registro y entregarlo a la funcion LectorArchivo

Instrucciones de uso:

1) El programa funciona sin problemas con el ejemplo del pdf

2) El programa ademas funciona sin problemas con otros ejemplos (Hay casos que provocaron Overflow)

3) Todas las funciones se encuentras detalladamente comentadas

4) Los supuestos realizados son los datos del archivos numeros.txt estan como en el ejemplo del laboratorio

5) Cuando el programa finaliza, NO se elimina el archivo resultados.txt, pero si desea hacer otra ejecucion despues de finalizado el programa, debe ELIMINAR el archivo, para que no se junten los anteriores resultados

6) Si hay o no hay overflow, se mostrara cuales filas NO se pudieron sumar

7) Ademas del archivo con los resultados obtenidos, tambien se mostrara por terminal los resultados

8) Al ingresar un numeros, se mostrara los resultados por pantalla y se guardara en el archivo, ademas se preguntara si desea continuar, si es asi, se ingresa Y y se pedira que digite nuevamente

9) Cuando se digita 0, el programa va a verificar si la cantidad de errores es mayor que la cantidad de numeros en el archivo, si no es asi, el programa pedira otro numero, sino se termina el programa

10) En la terminal, los resultados de mostraran de la siguiente forma: - Total de errores: <numero de los errores>
                                                                                                                   --> <en que parte o que numero dio el error>
                                                                                                                   ...

