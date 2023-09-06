# reconocimiento de patrones

Un área de la inteligencia artificial es el reconocimeinto de patrones, lo podemos reducir a clasificar un conjunto de puntos, por ejemplo, suponga que tiene un conjunto de puntos, y quiere hallar una forma de clasificarlos, es decir de saber si pertenecen a una clae u otra. Tenemos 2 casos:

1. caso línealmente separable.
2. caso no línealmente separable.

Trabajaremos con el caso lienalmente separable en 2D, en este caso el conjunto de puntos se puede separar por medio de una recta y el proceso de clasificación se reduce a encontrar la recta que divide amnbos conjuntos de puntos. En la siguiente imagen se muestra un conjunto de puntos de 2 clases (azules y rojos) y tenemos una recta que separa ambos conjuntos.


![puntos](puntos_clasif.jpg)

En resumen clasificar puntos linealmente separables se reduce a encontrar la ecuación de la recta que los separa.
Recordemos la ecuación de la recta:

en 2D: `y=w0+w1*x`
en 3D: `y=w0+w1*x1+w2*x2`

en 2D la ecuación `y=w0+w1*x` define una recta por medio de los valores `w0` y `w1`, esto se aclarará con el siguiente ejercicio:

En su navegador ejecute el programa :"separa_puntos_ej2.html"

![puntos](paragit2.jpg)

En este programa modifique en los cuadros de texto, los valores para `w0` y `w1` y trace la recta haciendo clic en el botón **grafica**. Empiece con valores aleatorios por ejemplo `w0=4` y `w1=1.5`, trace la recta y vaya modificando los valores de `wi` hasta que logre una recta que separe los dos conjuntos. Verá que efectivamente con modificar los vlaores de `w0` y `w1` puede encontrar una recta que separe ambos conjutnos de puntos.

Ahora debemos automatizarlo, hacer que un programa de manera automática encuentre la recta que divide ambos conjuntos. 

Para eso usaremos **SCILAB** y una red neuronal llamada **PERCEPTRON SIMPLE**.


## scilab (SL)
Scilab es un software para análisis numérico, con un lenguaje de programación de alto nivel para cálculo científico. Es desarrollado por Scilab Enterprises, bajo la licencia CeCILL, compatible con la GNU General Public License.

Las características de Scilab incluyen análisis numérico, visualización 2-D y 3-D, optimización, análisis estadístico, diseño y análisis de sistemas dinámicos, procesamiento de señales, e interfaces con Fortran, Java, C y C++. 

## instalación
Descargue el software desde: [sitio oficial scilab](https://www.scilab.org).

## introducción

En estas notas solo abordaremos los elementos básicos de Scilab que necesitaremos para hacer nuestros ejercicios, SL es un interprete por lo que puede ejecutar sentencias directamente o crear programas, empezaremos ejecutando sentencias directamente.

### Crear un arreglo en SL de 2*3, 2 renglones 3 columna.

En la consola de SCILAB ponga:

```scilab
--> m=[4,2,3;5,6,7]
 m  = 

   4.   2.   3.
   5.   6.   7.
```
### Multiplicar matriz por escalar:
```scilab
--> m*2
 ans  =

   8.    4.    6. 
   10.   12.   14.
```
### Multiplicar matrices:
```scilab
--> A=[2,3,4;3,4,5]
 A  = 

   2.   3.   4.
   3.   4.   5.

--> B=[2,2;3,3;4,4]
 B  = 

   2.   2.
   3.   3.
   4.   4.

--> C=A*B
 C  = 

   29.   29.
   38.   38.
```

### Multiplicar arreglo elemento a elemento
```scilab
--> A=[1,2,3]
 A  = 

   1.   2.   3.

--> B=[2,2,2]
 B  = 

   2.   2.   2.

--> C=A.*B
 C  = 

   2.   4.   6.
```
### Garficar x^2

En SL en el menu **file** seleccione la opcion **'open a file'**, cree un nuevo archivo con nombre **"grafica.sce"**, en el editor que se abre ponga el código:

```scilab
x=linspace(0, 100, 100);
for i=1:100
    y(i)=x(i)*x(i);
end
plot(x,y,'r');
```
En la caja de herramientas sobre el editor busque el boton **"save and execute"** para ejecutar el programa, haga clic y verá lo siguiente:

![x^2](xcuadrada.jpg)

`linspace(ini, fin, n);` crea una arreglo unidimensional con n datos equidistantes entre los valores ini y fin, estos representarán los valores de `x` en la recta numerica.

Como queremos `x` al cuadrado, `y=x^2`, debemos calcular `y` para esos puntos `x`.

`y(i)=x(i)*x(i);`

### trazar una línea

recuerde que la ecuacion de la recta la podemos ver como: 

**y=w1*x1+w0**

Tracemos una recta en scilab:

```scilab
x=linspace(0, 100, 100);
w0=3;
w1=0.5;
for i=1:100
    y(i)=w1*x(i)+w0;
end
plot(x,y,'r');
```

Explicacuón:

`linespace(x1,x2,n)` devuelve un arreglo de n puntos equidistantes entre los valores x1 y x2.

Con `x=linespace(0,100,100)`, obtenemos un arreglo de 100 puntos entre 0 y 100, que representaran los puntos del eje X de la recta.

Con el for creamos los valores `Y` de la recta, en Scilab las variables se crean de manera dinámica, de tal forma que en el primer ciclo del for se esta creando el arreglo `y`, con el primer valor `y(1)`, y en cada iteración se aumenta su tamaño con un nuevo elemento `y(i)`.

Finalmente `plot(x,y,'r')` traza una recta en 2D en color rojo para los valores `x,y`, donde `x,y` son los arreglos con las coordenadas `x,y`.

## Archivo de trabajo para reconocimiento de patrones 
### caso linealmente separable
Crearemos un archivo de trabajo con puntos en 2D con una distribusión como esta:

![puntos](puntos_clasif.jpg)
Grafica 1 20 puntos clasificados.

La idea es tener un conjunto de puntos linealmente seprables donde los puntos por encima de la línea pertenecen a la clase 1 y los puntos por debajo pertenecen a la clase -1.

Este conjunto de puntos lo guardaremos en un archivo para nuestras pruebas de algoritmos de clasificación.

Para este ejercicio, crearemos 20 puntos aleatorios y los dividiremos en 2 clases.

Código:

```scilab
//crea archivo de trabajo
//seran 20 puntos
np=20;
//creamos los 20 puntos aleatorios de 0 a 100 en 2D
x=round(rand(2,np,'uniform')*100);
x1=x(1,:);//Arreglo x1 con las coordenadas x
y1=x(2,:);//Arreglo y1 con las coordenadas y

//Trazamos una linea en y-x=0 o sea f(x)=x o sea
//y=x o sea 0=x-y
//valores de las clases en F
F=[1;-1];

//generamos los valores x,y de la recta
x2=linspace(0,100,100);
for i=1:100
    y2(i)=x2(i);
end
//trazamos la recta
plot(x2,y2,'r');


//Clasificamos los puntos a la izq o der de la linea
for i=1:np
    l(i)=F(2)*y1(i)+F(1)*x1(i);
    class_F(i)=sign(l(i));
end
//mostramos los puntos con difernte color segun su clase
for i=1:np
    if(class_F(i)==1)
        plot(x1(i),y1(i),'r*')
     else
         plot(x1(i),y1(i),'b*')
    end
end
//escribimos los puntos al archivo de trabajo
M=[x1',y1',class_F];
write('datos1.txt',M);

```

### explicacion del código

primero crearemos 20 puntos aleatorios
```scilab
//creamos una matriz (2*20)
x=round(rand(2,np,'uniform')*100);
//El primer renglon de la matriz será la coordenadas x
x1=x(1,:);//Arreglo x1 con las coordenadas x
//el segundo renglon de la matriz será la coordenadas y
y1=x(2,:);//Arreglo y1 con las coordenadas y
```
`rand(2,np,'uniform')` crea un conjunto de 20 valores aleatorios entre 0 y 1, distribuidos uniformemente, los multiplicamos por 100 para que de valores entre 0 y 100, por ejemplo un si un valor aleatorio generado en 0.2345 al multplicar * 100 dara 23.45, el 23 es el que nos interesa. Finalmente la función round elimina los decimales y deja solo el 23.

La matriz v creada tiene 20 datos de la forma:
|x|y|
|----|----|
|56.0|83.0|
|32.0|15.0|
|11.0| 5.0|
|34.0|45.0|
...

con la sentencia `x1=x(1,:);` creamos el vector x que cotiene todos los valores de la columna 1 de la matriz.


Tracemos una líea que pase por enmedio del área donde estan los puntos:

```scilab
x2=linspace(0,100,100);
for i=1:100
    y2(i)=x2(i);
end
plot(x2,y2,'r');
``` 

Para clasificar, note que todo punto por debajo de la linea, tienen una coordenada **x** mayor que su coordenada **y** (x>y), a su vez todo punto por encima de la linea tiene una coordenada (y>x).

Si hacemos una resta de `x-y` y obtenemos el signo del resultado de la resta (la funcion signo es una funcion de scilab que da 1 si el argumento es positivo y -1 si es negativo), con eso podemos asignar una clase u otra a cada punto, los puntos por encima de la linea serán de clase 1 y los puntos por debajo serán de clase -1.

```scilab
//Clasificamos los puntos a arriba o abajo de la linea
//restando el y del punto menos el y de la recta
for i=1:np
    l(i)=F(2)*y1(i)+F(1)*x1(i);
    class_F(i)=sign(l(i));
end
```
Creamos un arreglo F con la clase de cada punto.


Finalmente graficamos los puntos segun su clase y los guardamos en un archivo:
```scilab
for i=1:np
    if(class_F(i)==1)
        plot(x1(i),y1(i),'r*')
     else
         plot(x1(i),y1(i),'b*')
    end
end

M=[x1',y1',class_F];
write('datos1.txt',M);

```
## Clasificacion de puntos percepron simple

Para clasificar normalmente tenemos conjuntos muy grandes de miles o millones de puntos, se toma una muestra aleatoria de esos puntos, a esa muestra se le llama conjunto de trabajo, ese conjunto de trabajo debe ser representativo del conjunto original de datos. Una vez que se tiene el conjunto de trabajo, se entrena la red neuronal con el conjunto de trabajo, y se espera que despues del entrenamiento calsifique bien todos los puntos fuera del conjunto de trabajo (que la recta encontrada para el conjunto de trabajo divida efectivamente todos los puntos fuera de la muestra para ambas clases de puntos). Para conjuntos pequeños de datos para el conjunto de trabajo podemos tomar el total de puntos.

Para este ejemplo de clasificación crearemos un conjunto de 20 puntos aleatorios y los clasificaremos como en la **gráfica 1** donde se muestra la clasificacion con colores diferentes, ahora le daremos estos puntos clasificados al perceptron y este toma esos valores y busca una recta que clasifique los puntos.
La recta encontrada por el perceptron la muestra en verde.
Si la recta divide bien los puntos, el perceptron funciona bien.

```scilab
//Jesus Alejandro Flores Hernandez 
//codigo en SCILAB
//Ejemplode perceptron simple
//Probado y revisado 22-sep 2023
//Genera unn conjunto de numeros dentro de los limites del cuadro
//(-1,1),(1,1),(1,-1),(-1,-1)
//Traza una recta y-2x=0 ie y=2x
//Clasifica los puntos segun la recta (este sera el conjunto de trabajo)
//a continuacion aplica el algoritmo de perceptron

////////////// Genera el conjunto de trabajo /////////////
nct=20; //tamaño del conjunto de trabajo
x=2*rand(2,nct)-1;
x1=x(1,:);//Arreglo x1 contiene coordenadas x
y1=x(2,:);//Arreglo y1 contiene coordenadas y
plot(x1,y1,'*');

//Graficamos una linea arbitraria y=2x
//calculamos el y de la linea
x2=linspace(-1,1,100);
for i=1:100
    y2(i)=2*x2(i); //y=2x
end
//mostramos área de trabajo para fines visuales solamente
plot(x2,y2,'r') //trazamos una línea roja


//Clasificamos los puntos arriba y abajo de la linea
//los puntos a comparar con la recta tienen 
//la misma coordenada x que la recta
//solo hay que calcular la y de la recta
//y la y del punto y restar,
//para el conjunto de puntos:
//la y de la recta es 2x y la y del punto es y1
//por tanto la resta es: 2x-y1
//clasificamos segun el resultado
//si la resta es positiva el punto esta por arriba de la recta
//y tendra clase 1, en caso contrario tendra clase 0
for i=1:nct
    l(i)=2*x1(i)-y1(i); 
    class_F(i)=sign(l(i));  
end

//mostramos los puntos clasificados
for i=1:nct
        if class_F(i)==1 then
            plot(x1(i),y1(i),'gre*');
        else
            plot(x1(i),y1(i),'blu*');    
        end
end
///// fin de generacion de conjunto de trabajo ////

//////Algoritmo de perceptron /////////////////////
///////////////////////////////////////////////////
//la función hipotesis es la ecuacion de la recta
//0=w1*x+w2*y 
//los pesos iniciales son w1=0 and w2=0
W=[0;0];
//Calculamos la salida del perceptron con los pesos
//actuales para todos los puntos g(x)=w1*x1+w2*y1
for i=1:nct
    g(i)=sign(W(2)*y1(i)+W(1)*x1(i));
end 
//en g(i) quedan los puntos clasificados 
//segun los datos iniciales del perceptron

//~= operador relacional es distinto que
//buscamos las salidas que no concuerdan con nuestra
//clasificación, este operador,
//en el arreglo ind pone los indices 
//donde loa arreglos g y class_F son diferentes
ind = find(g ~= class_F);
//es decir en ind tenemos los idices donde la clasificacion
//que tenemos no coincide con la clasificacion del preceptron

iter=1;
while ~isempty(ind) //si es vacio => fin
    //si no esta vacio entonces hay valores erroneos 
    //en el percpetron
    //operador .* es multiplicación de matrices 
    //elemento a elemento
    //actualizamos los pesos
    W(1) = W(1) + (class_F(ind(1))-g(ind(1))).*x1(ind(1));  // 
    W(2) = W(2) + (class_F(ind(1))-g(ind(1))).*y1(ind(1));  // 
    //calculamos la nueva salida del perceptron
    for i=1:nct
         temp(i)=sign(W(2)*y1(i)+W(1)*x1(i));
    end
    //buscamos donde esta mal la estimacion del perceptron
    ind = find(temp ~= class_F);
    iter = iter + 1;
    g=temp;
end
mprintf("w0= %f, w1=%f \n",W(1),W(2));
//recta resultante 
//0=w1*xr+w2*yr
//despejando yr
//yr=-(w1*xr)/w2
//
//trazamos la rceta en verde

xr=linspace(-1,1,100);
for i=1:100
    yr(i)=-(W(1)*xr(i))/W(2);
end
plot(xr,yr,'g')
//si la recta separa los puntos de la misma forma de la racta roja
//hemos clasificado bien.


```

Referencias:

[sitio oficial](https://www.scilab.org)

[linespace en scilab](https://help.scilab.org/linspace)

[scilab y vscode](https://dev.to/fcomovaz/run-scilab-in-vs-code-3l39#vs-code-❤-scilab)
