// JUAN CAMILO DE HOYOS RODELO
// 000447613
// juanc.hoyos@upb.edu.co
(INICIO)
            @16400
            D=A

            @pscreen
            M=D         //pscreen = 16400

            @256
            D=A

            @cont
            M=D         //cont = 256

            @32
            D=A
            @cont2      //contador para la linea horizontal
            M=D

            @4096
            D=A
            @comienzo   //mitad horizontal
            M=D

            @KBD
            D=M
            @84     //tecla T
            D=D-A
            @VERTICAL
            D;JEQ

            @KBD
            D=M
            @67     //tecla C
            D=D-A 
            @SETCL
            D;JEQ

            @INICIO
            0;JMP
(VERTICAL)
            @cont
            D=M         // D = 256

            @HORIZONTAL
            D;JEQ       // if(D = 0) ir a HORIZONTAL

            @256
            D=A         //D = 256

            @pscreen
            A=M         //A = pscreen
            M=D         //M = 256

            @cont
            M=M-1       //resto 1 a cont

            @32
            D=A         //D = 32

            @pscreen
            M=M+D       //pscreen = pscreen + 32

            @VERTICAL
            0;JMP       //ir a VERTICAL

(HORIZONTAL)
            @comienzo
            D=M         //D = comienzo = 4096

            @SCREEN
            A=A+D       //almaceno en A el adress de la mitad horizontal
            M=-1        //los 32 bits correspondientes a esa coordenada cambian a -1 = negro

            @comienzo
            M=M+1       //salto a la siguiente coordenada

            @cont2
            M=M-1       //le resto 1 al contador
            D=M         //almaceno en D el dato del contador
            @END
            D;JEQ       //cuando D sea 0 salto al final

            @HORIZONTAL
            0;JMP

(SETCL)
            @16384 //16384 + (128*32)
            D=A
            @coord //variable donde inicia el dibujo
            M=D 
            @8192 //candidad de registros a pintar
            D=A
            @cont //contador filas pantalla
            M=D
            @1
            D=A 
            @salto
            M=D
            @color
            M=0
            @RECT
            0;JMP

(RECT)
            @coord //16384 + (128*32)
            D=M
            @pscreen
            M=D //memoria donde inicia la pantalla

(PAINT)
            @cont //D=cont
            D=M 

            @END
            D;JEQ //if cont = 0 goto END

            //@256 Pixeles que se van a pintar bits
            //D=A
            @color
            D=M
            @pscreen
            A=M 
            M=D //Pinto de negro el registro inicial

            @cont //cont = cont-1
            M=M-1

            @salto
            D=M

            @pscreen
            M=M+D //M+D

            @PAINT
            0;JMP

(END)
            @INICIO
            0;JMP