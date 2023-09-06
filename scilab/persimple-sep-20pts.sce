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
//si la recta sepra los puntos de la misma forma de la racta roja
//hemos clasificado bien.
