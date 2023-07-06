'''
La funcion verifica si un numero puede ser representado en la base dada, si lo es retorna el binario, si no retorna False
    Parametros:
        numero (str): Numero o letra
        base_inicio (int): Base que representa al numero
    Retorno:
        Retorna el binario si se puede representar, si no retorna False
'''
#Base hexadecimal
base_hexadecimal = ['0','1','2','3','4','5','6','7','8','9','A','B','C','D','E','F']

def ConversorBase(numero,base_inicio):
    if base_inicio == 16:
        if numero in base_hexadecimal:
            val_bas10 = base_hexadecimal.index(numero)
            if val_bas10 <= 0:
                return "0"
            binario_hexa = ""
            while val_bas10 > 0:
                residuo = int(val_bas10 % 2)
                val_bas10 = int(val_bas10 / 2)
                binario_hexa = str(residuo) + binario_hexa
            return binario_hexa
        else:
            print("Error")
        
    else:
        if base_inicio == 10:
            if int(numero) <= 0:
                return "0"
            binario_10 = ""
            while int(numero) > 0:
                residuo = int(int(numero) % 2)
                numero = int(int(numero) / 2)
                binario_10 = str(residuo) + binario_10
            return binario_10

        else:
            for var1 in numero: 
                if int(var1) not in range(0,base_inicio):
                    return False
            suma = 0
            cont = 0
            for item in reversed(numero):
                suma += int(item)*(base_inicio**cont)
                cont+=1
            if suma <= 0:
                return "0"
            binario_disbas = ""
            
            while suma > 0:
                residuo = int(suma % 2)
                suma = int(suma / 2)
                binario_disbas = str(residuo) + binario_disbas
            return binario_disbas  
        



'''
La funcion verifica si hay que extender el signo de los binarios del archivo, si es asi, lo extiende
    Parametros:
        num_bin (str): Binario que se usara para verificar si hay que extender el signo o no
        nbits (int): Numero de bits ingresados por el usuario
    Retorno:
        Retorna el binario con la extension de signo o retorna el binario entregado si no hay que extender el signo o retorna False si el numero es mas grande
'''
def SignExtension(num_bin, nbits):
    if len(num_bin) < nbits:
        if num_bin[0] == '0':
            ExtensionPos = ''
            restap = nbits - len(num_bin)
            contp = 0
            while contp < restap:
                ExtensionPos += '0'
                contp+=1
            ExtensionPos += num_bin
            return ExtensionPos
        else:
            ExtensionNeg = ''
            restan = nbits - len(num_bin)
            contn = 0
            while contn < restan:
                contn+=1
                ExtensionNeg += '1'
            ExtensionNeg += num_bin
            return ExtensionNeg
    elif len(num_bin) == nbits:
        return num_bin
    else:
        return False
    



'''
La funcion permite sumar dos elementos binarios que ya esten en Complemento 2
    Parametros:
        nu1 (str): Binario que se usara para la suma
        nu2 (str): Binario que se usara para la suma
        nu2 (int): Numero de bits ingresados por el usuario
    Retorno:
        Retorna 0 si NO se provoca un Overflow o retorna 1 si se provoca un Overflow o retorna 2 si son de distito largo
'''
def SumComplemento2(nu1,nu2,bits):
    if len(nu1) == len(nu2):
        cc=""
        i=bits
        cons=0
        if (nu1[0]==nu1[0]):
            cc=nu1[0]

        while i>0:
            l=i-1
            if (2==(int(nu1[l])+cons)):
                nu1=nu1[:i-1]+"0"+nu1[i:]
                cons=1
            elif (1==(int(nu1[l])+cons)):
                nu1=nu1[:i-1]+"1"+nu1[i:]
                cons=0
            else:
                nu1=nu1

            if (2==(int(nu1[l])+int(nu2[l]))):
                nu1=nu1[:i-1]+"0"+nu1[i:]
                cons=1
            elif (0==(int(nu1[l])+int(nu2[l]))):
                nu1=nu1
            else:
                nu1=nu1[:i-1]+"1"+nu1[i:]
            i-=1

        if (nu1[0]!=cc):
            return 1
        return 0
    else:
        return 2


    

'''
La funcion permite leer el archivo, separar los datos y procesa la informacion
    Parametros:
        nom_arch (str): Nombre del archivo txt donde estan los numeros y sus respectivas bases
        rango (int): Numero de bits entregados por el usuario
    Retorno:
        No retorna nada
'''
def LectorArchivo(nom_arch, rango):
    problem_rep = [] #Problemas con la representacion
    problem_tamreg = [] #Problemas con el size de el registro
    problem_overflow = [] #Problemas con el overflow
    problem_suma = [] #Problemas con la suma
    with open(nom_arch, "r") as archivo:

        #Contadores
        cont_num = 0 # Numero en el archivo
        err_repnum = 0 # Numero de los errores en la representacion numerica
        err_repre = 0 # Numero de los errores en la representacion numerica
        err_sum = 0 # Numero de los errores en las sumas
        overf = 0 # Numero de las sumas que causaron overflow
        cont_filas = 0 # Numero de las filas (Para orientacion)

        for linea in archivo:
            cont_filas+=1
            base1,dat2,numero2 = linea.split(";")
            numero1,base2 = dat2.split("-")
            numero2 = numero2.strip("\n")
            if numero1 != "":
                cont_num+= 1
                if numero2 != "":
                    cont_num+= 1


            #Paso B
            val1 = ConversorBase(numero1, int(base1))
            if val1 is False:
                err_repnum +=1
                problem_rep.append(numero1+" en base "+base1)

            val2 = ConversorBase(numero2, int(base2))
            if val2 is False:
                err_repnum +=1
                problem_rep.append(numero2+" en base "+base2)


            #Paso C
            if val1 is not False:
                if len(val1) > rango:
                    err_repre+=1
                    problem_tamreg.append("Con "+str(rango)+" bits de tamaño no se pueden representar el "+numero1+" en base "+base1)

            if val2 is not False:
                if len(val2) > rango:
                    err_repre+=1
                    problem_tamreg.append("Con "+str(rango)+" bits de tamaño no se pueden representar el "+numero2+" en base "+base2)


            #Paso D
            if type(val1)==str:
                extn1 = SignExtension(val1,rango)
                if type(extn1) ==str:
                    if type(val2)==str:
                        extn2 = SignExtension(val2,rango)
                        if type(extn2) ==str:
                            k = SumComplemento2(extn1,extn2,rango)
                            if k == 1:
                                
                                problem_overflow.append("Hay Overflow entre "+extn1+" y "+extn2)
                                overf+=1
                                
                            elif k == 2:
                                problem_suma.append("No se realizan sumas en la fila: "+str(cont_filas))
                                err_sum+=1
                            else:
                                print()
                        else:
                            problem_suma.append("No se realizan sumas en la fila: "+str(cont_filas))
                            err_sum+=1
                    else:
                        problem_suma.append("No se realizan sumas en la fila: "+str(cont_filas))
                        err_sum+=1
                else:
                    problem_suma.append("No se realizan sumas en la fila: "+str(cont_filas))
                    err_sum+=1
            else:
                problem_suma.append("No se realizan sumas en la fila: "+str(cont_filas))
                err_sum+=1



    #Salidas
    print("****************************************************************************************************************************************************************\n")
    print("***************************************************************************Resultados***************************************************************************\n")

    #Paso A
    print("- Total numeros en el archivo: ", cont_num, "\n")


    #Paso B
    if err_repnum == 0:
        print("- Total numeros con error en la representacion numerica:", err_repnum,"\n")
    else:
        print("- Total numeros con error en la representacion numerica:", err_repnum, "\n")
        for obj in problem_rep:
            print("                                                           ", "-->" ,obj, "\n")


    #Paso C
    if err_repre == 0:
        print("- Total numeros que no pueden ser representados con el valor ingresado: ", err_repre, "\n")
    else:
        print("- Total numeros que no pueden ser representados con el valor ingresado: ", err_repre,"\n")
        for obj2 in problem_tamreg:
            print("                                                                          ", "-->" ,obj2, "\n")
    


    #Paso D
    if overf == 0:
        if err_sum == 0:
            print("- Total sumas realizadas en complemento dos que provocan overflow: ", overf, "\n")
            print("- Total sumas NO realizadas sin overflow: ", err_sum, "\n")
        else:
            print("- Total sumas realizadas en complemento dos que provocan overflow: ", overf, "\n")
            print("- Total sumas NO realizadas sin overflow: ", err_sum, "\n")
            for obj3 in problem_suma:
                print("                                             ", "-->" ,obj3, "\n")
    else:
        print("- Total sumas realizadas en complemento dos que provocan overflow: ", overf,"\n")
        for obj4 in problem_overflow:
            print("                                                                          ", "-->" ,obj4, "\n")

        if err_sum == 0:
            print("- Total sumas NO realizadas sin overflow: ", err_sum, "\n")
        else:
            print("- Total sumas NO realizadas sin overflow: ", err_sum, "\n")
            for obj5 in problem_suma:
                print("                                             ", "-->" ,obj5, "\n")
                

        
        
    print("****************************************************************************************************************************************************************\n")
    print("****************************************************************************************************************************************************************\n")


    #Se crea el archivo el archivo o se abre si ya esta creado y almacena los resultados
    salida = open("resultados.txt", "a")
    salida.writelines(str(cont_num)+";"+str(err_repnum)+";"+str(err_repre)+";"+str(overf)+"\n")
    salida.close()




'''
La funcion permite almacenar el tamaño el registro y entregarlo a la funcion LectorArchivo
    Parametros:
        No recibe ningun parametro
    Retorno:
        No retorna nada
'''
def Principal():
    #Tamaño el registro
    flag = True
    while flag:
        tregistro = int(input("Ingrese el tamaño del registro (1-32): "))
        if tregistro in range(1,32):
            #Se entrega la informacion la al funcion LectorArchivo
            LectorArchivo("numeros.txt", tregistro) #numeros.txt es el nombre del archivo de pruebas que esta en el pdf
            con = str(input("Desea ingresar otro tamaño del registro Y/N : "))
            if con == "Y":
                flag = True
            else:
                flag = False
        elif tregistro == 0:
            with open("resultados.txt", "r") as archivo:
                suma_arch = 0
                for linea in archivo:
                    num,representacion,tamano,overflow = linea.split(";")
                    overflow = int(overflow.strip("\n"))
                    suma_arch += int(representacion)+int(tamano)+int(overflow)
                #Verifica si continua o no
                if suma_arch > int(num):
                    flag = False
                else:
                    flag = True

        else:
            print("Favor ingrese un numero dentro del rango")
            flag = True


    


#Se inicia la ejecucion de la tarea
Principal()