clear all
A=1;
fs=8000;    %frecuencia de muestreo en Hz

%teclaFila = {697 697 697 770 770 770 852 852 852 941}
%teclaCol = {1209 1336 1477 1209 1336 1477 1209 1336 1477 1336}

%pido que ingresen la tecla:
%a = input('Ingresar un numero DTMF:');
%if(a==0)
 %  a=10;
%end
%genero 1 segundo de duraci?n
t=0:1/fs:1;
largot=length(t);

%frecCol=cell2mat(teclaCol(a))
%frecFil = cell2mat(teclaFila(a))


f1=A*sin(2*pi*1336*t); 
%f1=A*sin(2*pi*frecCol*t); 
f2 =A*sin(2*pi*770*t);
%f2 =A*sin(2*pi*frecFil*t);
f5=f1+f2;
%escucho el tono que produce.
sound(f5);
%Calculo su espectro
F5 = fft(f5,512);
f = fs/2*linspace(0,1,512/2);
figure(1)
plot(f,abs(F5(1:512/2)))
title('Espectro de la señal de la tecla 5. Son dos tonos.');

dt=0.01
potT=sum(abs(f5).^2)/dt
%fcs = {730, 800, 900, 1000};
fcs = {750, 830, 900, 1000}
ffilas = {697,770,852,941};

for i=1:length(fcs)
    fc=cell2mat(fcs(i));    %frecuencia de corte
    wc=2*pi*fc/fs; %frecuencia normalizada
    N=66;   %orden del filtro=66. L=67 muestras
    k=1:N/2;
    h=sin(wc*k)./(pi*k); %N/2 coeficientes positivos 

    hneg=h(N/2:-1:1);   %los espejo
    h=[hneg wc/pi h];
    H=fft(h,512);
    figure(2);
    f = fs/2*linspace(0,1,512/2);
    plot(f,abs(H(1:512/2))) 
    hold on
    title('Filtro pasabajo para la deteccion de los tonos de las filas');
    %filtro la señal por convolucion
    y1=conv(f5,h);
    figure(3)
    %subplot(2,1,1)
    %plot(t,y1(1:largot));
    %hold on
    %title('Salida en el dom del tiempo. Deteccion de tono de LF');
    %Calculo su transformada
    Y1 = fft(y1,512);
    f = fs/2*linspace(0,1,512/2);
    %subplot(2,1,2)
    plot(f,abs(Y1(1:512/2))) 
    hold on
    title('Espectro de la salida. Deteccion de los tonos de LF');

    %Calculo la energia de la señal en el dominio del tiempo
    potOut=2*(sum(abs(y1).^2)/dt)
    per = potOut*100/potT
    
    if(per >= 80)
        break;
    end
end
%ya sabemos cual es la frecuencia de la fila. Lo resto a la senal original 
%para poder detectar el tono de HF
filaFrec = cell2mat(ffilas(i))
f5 = f5-A*sin(2*pi*filaFrec*t);
figure(4)
F5 = fft(f5,512);
f = fs/2*linspace(0,1,512/2);
plot(f,abs(F5(1:512/2)))
title('Espectro luego de restarle el tono de LF detectado');
%vamos a trabajar con las columnas.
fci={1280,1350,1500}
fcol ={1209,1336,1477}

dt=0.01
potT=sum(abs(f5).^2)/dt
for n=1:length(fci)
    fc=cell2mat(fci(n));    %frecuencia de corte
    wc=2*pi*fc/fs; %frecuencia normalizada
    N=66;   %orden del filtro=66. L=67 muestras
    k=1:N/2;
    h=sin(wc*k)./(pi*k); %N/2 coeficientes positivos 

    hneg=h(N/2:-1:1);   %los espejo
    h=[hneg wc/pi h];
    H=fft(h,512);
    figure(5);
    f = fs/2*linspace(0,1,512/2);
    plot(f,abs(H(1:512/2))) 
    hold on
    title('Filtro pasabajo para la deteccion de los tonos de las columnas');
    %filtro la señal por convolucion
    y1=conv(f5,h);
    figure(6)
    %subplot(2,1,1)
    %plot(t,y1(1:largot));
    %hold on
    %title('Filtro pasabajo de los tonos de las columnas');

    %Calculo su transformada
    Y1 = fft(y1,512);
    f = fs/2*linspace(0,1,512/2);
    %subplot(2,1,2)
    plot(f,abs(Y1(1:512/2))) 
    hold on
    title('Espectro de la salida')

    %Calculo la energia de la señal en el dominio del tiempo
    potOut=2*(sum(abs(y1).^2)/dt)
    per = potOut*100/potT
    
    if(per >= 60)
        break;
    end
end

fcolumna = cell2mat(fcol(n))
teclas = {1 2 3;4 5 6;7 8 9;nan 0 nan}
%la tecla presionada es:
tecla = teclas(i,n)
